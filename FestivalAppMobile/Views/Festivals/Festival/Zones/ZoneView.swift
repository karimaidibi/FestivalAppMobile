//
//  ZoneView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct ZoneView: View {
    @ObservedObject var viewModel: ZoneViewModel
    @State private var zoneNom : String = ""
    @State private var zoneNbBenevoles : Int = 0

    // Gestion popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    @State private var isEditingName = false
    @State private var editedName = ""
    @State private var isEditingNbBenevoles = false
    @State private var editedNbBenevoles : Int = 0
    
    var body: some View {
        let zoneIntent = ZoneIntent(viewModel: viewModel)
        
        List {
            Section(header: Text("Nom de la zone")) {
                if isEditingName {
                    TextField("Nom", text: $editedName,
                      onCommit: {
                        Task{
                            let zoneUpdated = await zoneIntent.updateZone(id: viewModel._id, editedProperty: editedName, editing: "nom")
                            if zoneUpdated{
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
                        .foregroundColor(.blue)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            isEditingName.toggle()
                            editedName = viewModel.nom
                        }
                }
            
            }
            Section(header: Text("Nombre de bénévoles nécessaires")) {
                if isEditingNbBenevoles {
                    Stepper(value: $viewModel.nombre_benevoles_necessaires, in: 0...100, step: 1) {
                        Text("\(viewModel.nombre_benevoles_necessaires)")
                    }
                } else {
                    Text("\(viewModel.nombre_benevoles_necessaires)")
                        .foregroundColor(.blue)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            isEditingNbBenevoles.toggle()
                            editedNbBenevoles = viewModel.nombre_benevoles_necessaires
                        }
                }
            
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Modifier Une Zone")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear(perform:{
            self.zoneNom = viewModel.nom
            self.zoneNbBenevoles = viewModel.nombre_benevoles_necessaires
        })
    }
    
    // Check if form is valid
    private func formIsValid() -> Bool {
        if self.zoneNom.isEmpty {
            return false
        }
        return true
    }
}
