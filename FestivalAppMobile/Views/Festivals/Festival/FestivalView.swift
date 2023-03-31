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
        
    enum FestivalSection {
            case jours
            case zones
        }
    
    var body: some View {
        let festivalIntent : FestivalIntent = FestivalIntent(viewModel: viewModel)
        
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
                    Text("\(viewModel.annee)")
                        .font(.headline)
                        .onTapGesture {
                            isEditingYear = true
                            editedYear = "\(viewModel.annee)"
                        }
                }
            }
            
            Section(header: Text("Est clôturé")) {
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
            }
            
            Picker(selection: $selectedSection, label: Text("")) {
                Text("Jours").tag(FestivalSection.jours)
                Text("Zones").tag(FestivalSection.zones)
            }
            .pickerStyle(SegmentedPickerStyle())
            .listRowBackground(Color.white)
            
            // affichage de la section
            if selectedSection == .jours {
				JourListView(festivalVM: viewModel)
            } else {
                Section(header: Text("Zones")) {
                    // Display the list of zones
                    //ForEach(viewModel.zones) { zone in
                      //  ZoneRowView(zone: zone)
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
                Task {
                    let added = await festivalsIntent.addFestival(nom: "", annee : 1, estCloture: true)
                }
                //viewModel.addNewDay()
            } else {
                //viewModel.addNewZone()
            }
        }) {
            Image(systemName: "plus")
        })
    }
}
