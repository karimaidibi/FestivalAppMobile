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
    
    
    var body: some View {
        let zoneIntent = ZoneIntent(viewModel: viewModel)
        
        List {
            Section(header: Text("Nom de la zone")) {
                    TextField("Nom", text: $zoneNom)
            }
            Section(header: Text("Nombre de bénévoles nécessaires")) {
                Stepper(value: $zoneNbBenevoles, in: 0...100, step: 1) {
                    Text("\(zoneNbBenevoles)")
                }
            }
            // button here to validate changes
            Section {
                Button(action: {
                    Task{
                        let zoneUpdated = await zoneIntent.updateZone(id: viewModel._id, nom: zoneNom, nbre_ben_necessaires: zoneNbBenevoles)
                        if zoneUpdated{
                            alertMessage = viewModel.successMessage
                            alertTitle = "Success"
                            showAlert = true
                        }else{
                            alertMessage = viewModel.errorMessage
                            alertTitle = "Error"
                            showAlert = true
                        }
                    }
                }) {
                    Text("Valider les modifications")
                        .frame(maxWidth: .infinity)
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
