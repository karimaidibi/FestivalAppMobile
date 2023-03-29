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
