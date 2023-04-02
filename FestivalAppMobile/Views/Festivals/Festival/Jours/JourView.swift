//
//  JourFestivalView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct JourView: View {
    @ObservedObject var viewModel: JourViewModel
    @StateObject var benevolesVM : BenevoleListViewModel = BenevoleListViewModel(benevoleViewModels: [])
    @ObservedObject var festivalVM : FestivalViewModel
    @StateObject var zonesVM : ZoneListViewModel = ZoneListViewModel(zoneViewModelArray: [])
    @State var authManager : AuthManager = AuthManager()
    
    @State var nbre_participants = 0
    
    @State private var isEditingName = false
    @State private var editedName = ""

    // for popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    @State private var selectedDate: Date = Date()
    @State private var isEditingDate = false

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    
    var body: some View {
        
        let benevolesIntent : BenevolesIntent = BenevolesIntent(viewModel: benevolesVM)
        let festivalIntent : FestivalIntent = FestivalIntent(viewModel: festivalVM)
        let zonesIntent : ZonesIntent = ZonesIntent(viewModel: zonesVM)
        let jourIntent : JourIntent = JourIntent(viewModel: viewModel)
        
        let startOfYear = Calendar.current.date(from: DateComponents(year: festivalVM.annee, month: 1, day: 1))!
        let endOfYear = Calendar.current.date(from: DateComponents(year: festivalVM.annee, month: 12, day: 31))!
        
        List {
            if benevolesVM.loading || zonesVM.loading{
                ProgressView("Loading Jour ...")
            }else{
                Section(header: Text("Date")) {
                    if isEditingDate{
                        DatePicker("Date", selection: $selectedDate, in: startOfYear...endOfYear ,displayedComponents: [.date])
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .onChange(of: selectedDate) { newDate in
                                let formattedNewDate = dateFormatter.string(from: newDate)
                                   Task {
                                       let jourUpdated = await jourIntent.updateJour(id: viewModel._id, editedProperty: formattedNewDate, editing: "date")
                                       if jourUpdated {
                                           // show success alert
                                           self.isEditingDate = false
                                           alertMessage = viewModel.successMessage
                                           alertTitle = "Success"
                                           showAlert = true
                                       } else {
                                           // show error alert
                                           alertMessage = viewModel.errorMessage
                                           alertTitle = "Error"
                                           showAlert = true
                                       }
                                   }
                            }
                            .onSubmit {
                                self.isEditingDate = false
                            }
                    }else{
                        let formattedDate = UtilityHelper.formattedDateString(from: viewModel.date)
                        HStack{
                            Text(formattedDate)
                                .font(.title2)
                            if let isAdmin = authManager.isAdmin{
                                if isAdmin {
                                    Spacer()
                                    Button(action: {
                                        selectedDate = UtilityHelper.dateFromString(viewModel.date) ?? Date()
                                        isEditingDate = true
                                    }) {
                                        Image(systemName: "pencil")
                                    }
                                }
                            }
                        }
                    }

                }

                
                Section(header: Text("Nom")) {
                    if isEditingName {
                        TextField("Nom du Jour", text: $editedName, onCommit: {
                            Task{
                                let jourUpdated = await jourIntent.updateJour(id: viewModel._id, editedProperty: editedName, editing: "nom")
                                if jourUpdated{
                                    isEditingName = false
                                    // show success alert
                                    alertMessage = viewModel.successMessage
                                    alertTitle = "Success"
                                    showAlert = true
                                }else{
                                    // show error alert
                                    alertMessage = viewModel.errorMessage
                                    alertTitle = "Error"
                                    showAlert = true
                                }
                            }
                        })
                    } else {
                        Text(viewModel.nom)
                            .font(.headline)
                            .onTapGesture {
                                if let isAdmin = authManager.isAdmin{
                                    if isAdmin{
                                        isEditingName = true
                                        editedName = viewModel.nom
                                    }
                                }
                            }
                    }
                }
                
                Section(header: Text("Heure ouverture - Heure fermeture")) {
                    Text("\(viewModel.heure_ouverture) - \(viewModel.heure_fermeture)")
                        .font(.body)
                }
                
                Section(header: Text("Participants")) {
                    Text("Nombre de participants : \(nbre_participants)")
                        .font(.body)
                }
                
                CreneauListView(jourVM: viewModel, benevolesVM : benevolesVM, zonesVM: zonesVM, festivalVM : festivalVM)
            }
        }
        .navigationTitle("Jour")
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .task {

            // load the list of benevoles with their nested affectations
            let benevolesDocLoaded = await benevolesIntent.getBenevolesNested()
            if benevolesDocLoaded{
                nbre_participants = festivalIntent.getNbreBenevolesDocInFestival(benevolesDocVM: benevolesVM)
            }
 
            let zonesLoaded = await zonesIntent.getZonesByFestival(festivalId: festivalVM._id)
            if !zonesLoaded{
                alertMessage = zonesVM.errorMessage
                alertTitle = "Error"
                showAlert = true
            }
        }
    }
}


