//
//  AddFestivalView.swift
//  FestivalAppMobile
//
//  Created by etud on 30/03/2023.
//

import Foundation

import SwiftUI

struct AddFestivalView: View {
    // ViewModel
    @ObservedObject var festivalsVM: FestivalsViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    // Gestion popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    // States
    @State private var nom: String = ""
    @State private var annee: Int = 2023
    @State private var estCloture: Bool = false
    
    // View
    var body: some View {
        let festivalsIntent : FestivalsIntent = FestivalsIntent(viewModel: festivalsVM)
        
        VStack {
            // Form to create new festival
            Form {
                Section(header: Text("Nom")) {
                    TextField("Nom du Festival", text: $nom)
                }
                Section(header: Text("Année")) {
                    Stepper(value: $annee, in: 2010...2090, step: 1) {
                        Text("\(annee)")
                    }
                }
                Section(header: Text("Cloturé")) {
                    Toggle("Cloturé", isOn: $estCloture)
                }
            }
            
            // Create button
            Button(action: {
                Task {
                    // Créer le festival
                    let addedFestival = await festivalsIntent.addFestival(nom: nom, annee: annee, estCloture: estCloture)
                    // Handle error case
                    if addedFestival {
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        // Handle error case
                        showAlert = true
                        alertTitle = "Error"
                        alertMessage = festivalsVM.errorMessage
                    }
                }
            }) {
                Text("Créer")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .padding(.top, 50)
            .disabled(!formIsValid()) // disable button if form is not valid
        }
        .navigationTitle("Ajouter un festival")
    }
    
    // Check if form is valid
    private func formIsValid() -> Bool {
        if nom.isEmpty {
            return false
        }
        return true
    }
}
