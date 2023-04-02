//
//  FestivalView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct FestivalView: View {
    @ObservedObject var festivalsVM : FestivalsViewModel
    @ObservedObject var viewModel : FestivalViewModel
    @StateObject var joursVM : JourListViewModel = JourListViewModel(jourViewModels : [])
    @StateObject var zonesVM : ZoneListViewModel = ZoneListViewModel(zoneViewModelArray: [])
    @StateObject var benevolesVM : BenevoleListViewModel = BenevoleListViewModel(benevoleViewModels: [])
    @StateObject var authManager : AuthManager = AuthManager()
    
    @State private var isEditingName = false
    @State private var editedName = ""
    @State private var isEditingYear = false
    @State private var editedYear = ""
    @State private var isEditingClosed = false
    @State private var isClosed : Bool = false
    
    @State private var selectedSection : FestivalSection = .jours // par défaut
    
    // for alert 
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    @State private var nbre_participants = 0

    enum FestivalSection {
            case jours
            case zones
        }
    
    var body: some View {
        let festivalIntent : FestivalIntent = FestivalIntent(viewModel: viewModel)
        let benevolesIntent : BenevolesIntent = BenevolesIntent(viewModel: benevolesVM)
        let zonesIntent : ZonesIntent = ZonesIntent(viewModel: zonesVM)
        let joursIntent : JoursIntent = JoursIntent(viewModel: joursVM)
        
        List {
            Section(header: Text("Participants")) {
                if benevolesVM.loading{
                    ProgressView("Loading participants...")
                }else{
                    Text("Nombre de participants : \(nbre_participants)")
                }
            }
            Section(header: Text("Nom")) {
                if isEditingName {
                    TextField("Nom du Festival", text: $editedName, onCommit: {
                        Task{
                            let festivalUpdated = await festivalIntent.updateFestival(id: viewModel._id, editedProperty: editedName, editing: "nom")
                            if festivalUpdated{
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
            
            Section(header: Text("Année")) {
                if isEditingYear {
                    TextField("Année", text: $editedYear, onCommit: {
                        Task {
                            let festivalUpdated = await festivalIntent.updateFestival(id: viewModel._id, editedProperty: editedYear, editing: "annee")
                            if festivalUpdated {
                                isEditingYear = false
                                // show success alert
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
                    })
                    .keyboardType(.numberPad)
                } else {
                    Text("\(String(viewModel.annee))")
                        .font(.headline)
                        .onTapGesture {
                            if let isAdmin = authManager.isAdmin{
                                if isAdmin{
                                    isEditingYear = true
                                    editedYear = "\(viewModel.annee)"
                                }
                            }
                        }
                }
            }
            
            Section(header: Text("Est clôturé")) {
                if let isAdmin = authManager.isAdmin{
                    if isAdmin{
                        Toggle(isOn: $isClosed) {
                            if isEditingClosed {
                                Text("Est clôturé")
                            } else {
                                Text(viewModel.estCloture ? "Oui" : "Non")
                            }
                        }
                        .onTapGesture {
                            isEditingClosed = true
                            isClosed = viewModel.estCloture
                        }
                        if isEditingClosed {
                            Button(action: {
                                Task {
                                    let festivalUpdated = await festivalIntent.updateFestival(id: viewModel._id, editedProperty: isClosed, editing: "estCloture")
                                    if festivalUpdated {
                                        isEditingClosed = false
                                        // show success alert
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
                            }, label: {
                                Text("Valider")
                            })
                        }
                    }else{
                        Text(viewModel.estCloture ? "Oui" : "Non")
                    }
                }else{
                    Text(viewModel.estCloture ? "Oui" : "Non")
                }

            }
            
            Picker(selection: $selectedSection, label: Text("")) {
                Text("Jours").tag(FestivalSection.jours)
                Text("Zones").tag(FestivalSection.zones)
            }
            .pickerStyle(SegmentedPickerStyle())
            .listRowBackground(Color.white)
            
            // affichage de la section
            if selectedSection == .jours {
                if benevolesVM.loading || joursVM.loading{
                    ProgressView("Loading jours ...")
                }else{
                    JourListView(joursVM : joursVM ,festivalVM: viewModel, benevolesVM: benevolesVM)
                }
            } else {
                if zonesVM.loading{
                    ProgressView("Loading zones ...")
                }else{
                    ZoneListView(zonesVM: zonesVM, festivalVM : viewModel)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .navigationTitle(viewModel.nom)
        //.navigationBarItems(trailing:
        //HStack {
          //  if let isAdmin = authManager.isAdmin{
            //    if isAdmin{
                    // First button
              //      Button(action: {
                //    }) {
                  //      if selectedSection == .jours {
                            // envoie le user vers la page de création du jour
                    //        NavigationLink(destination: AddJourView(joursVM: joursVM, festivalsVM: festivalsVM)) {
                      //          Text("Jour")
                        //        Image(systemName: "plus")
                          //  }
                        //} else if selectedSection == .zones {
                          //  NavigationLink(destination: AddZoneView(zonesVM: zonesVM, festivalsVM: festivalsVM)) {
                            //    Text("Zones")
                              //  Image(systemName: "plus")
                            //}
                        //}
                    //}
                //}
            //}
        //})
        .task {
            // load the list of benevoles with their nested affectations
            let benevolesDocLoaded = await benevolesIntent.getBenevolesNested()
            if benevolesDocLoaded{
                nbre_participants = festivalIntent.getNbreBenevolesDocInFestival(benevolesDocVM: benevolesVM)
            }
            let joursLoaded = await joursIntent.getJoursByFestival(festivalId: viewModel._id)
            if !joursLoaded{
                alertMessage = joursVM.errorMessage
                alertTitle = "Error"
                showAlert = true
            }else{
                let zonesLoaded = await zonesIntent.getZonesByFestival(festivalId: viewModel._id)
                if !zonesLoaded{
                    alertMessage = zonesVM.errorMessage
                    alertTitle = "Error"
                    showAlert = true
                }
            }
        }
    }
}


