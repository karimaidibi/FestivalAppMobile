//
//  AddZoneView.swift
//  FestivalAppMobile
//
//  Created by etud on 30/03/2023.
//

import Foundation

import SwiftUI

struct AddZoneView: View {
    // View models observés
    @ObservedObject var zonesVM: ZoneListViewModel
    @ObservedObject var festivalsVM: FestivalsViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    // Gestion popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    // Propiétés
    @State private var nom = ""
    @State private var nombre_benevoles_necessaires = ""
    
    var body: some View {
        let zonesIntent : ZonesIntent = ZonesIntent(viewModel: zonesVM)
        
        NavigationView {
            Form {
                Section(header: Text("Zone")) {
                    // Zone Name
                    TextField("Nom de la zone", text: $nom)
                    // Number of Volunteers
                    TextField("Nombre minimum de bénévoles", text: $nombre_benevoles_necessaires)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Ajouter une zone")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Créer") {
                        Task {
                            // Create Zone
                            let addedZone = await zonesIntent.addZone(nom: nom, nombre_benevoles_necessaires: Int(nombre_benevoles_necessaires) ?? 0, idFestival: festivalsVM.getCurrent()._id)
                            
                            if addedZone {
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                // Handle error case
                                showAlert = true
                                alertTitle = "Error"
                                alertMessage = zonesVM.errorMessage
                            }
                        }
                    }
                    .disabled(nom.isEmpty || nombre_benevoles_necessaires.isEmpty)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}
