//
//  FestivalView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct FestivalView: View {
    @ObservedObject var viewModel: FestivalViewModel
    @StateObject var joursVM : JourListViewModel = JourListViewModel(jourViewModels : [])
    
    @State private var isEditingName = false
    @State private var editedName = ""
    @State private var selectedSection : FestivalSection = .jours // par défaut
    
    // for alert 
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    enum FestivalSection {
            case jours
            case zones
        }
    
    var body: some View {
        let festivalIntent : FestivalIntent = FestivalIntent(viewModel: viewModel)
        let joursIntent : JoursIntent = JoursIntent(viewModel: joursVM)
        
        List {
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
                            isEditingName = true
                            editedName = viewModel.nom
                        }
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
                Section(header: Text("Jours")) {
                        ForEach(joursVM, id:\.self) { jourVM in
                            //NavigationLink(destination: JourFestivalView(viewModel: jourVM)) {
                            	JourRow(jourVM: jourVM)
                            //}
                        }
                }
                .task {
                    let joursLoaded = await joursIntent.getJoursByFestival(festivalId: viewModel._id)
                }
            } else {
                Section(header: Text("Zones")) {
                    // Display the list of zones
                    //ForEach(viewModel.zones) { zone in
                      //  ZoneRow(zone: zone)
                    //}
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .navigationTitle(viewModel.nom)
        .navigationBarItems(trailing:
            Button(action: {
                if selectedSection == .jours {
                    //viewModel.addNewDay()
                } else {
                    //viewModel.addNewZone()
                }
            }, label: {
                Image(systemName: "plus")
            })
        )
    }
}


struct JourRow: View {
    @ObservedObject var jourVM : JourViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                let formattedDate = formattedDateString(from: jourVM.date)
                Text(formattedDate)
                    .font(.headline)
                    .padding(1)
                
                Text("\(jourVM.heure_ouverture) - \(jourVM.heure_fermeture)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Text("... participants")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 10)
    }
}

struct ZoneRow: View {
    let zone: Zone
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(zone.name)
                    .font(.headline)
                
                Text("Bénévoles min. : \(zone.nbBenevolesMin)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 10)
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()


func formattedDateString(from dateString: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

    if let date = inputFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMMM yyyy"
        return outputFormatter.string(from: date)
    } else {
        return dateString
    }
}
