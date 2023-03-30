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
    
    let festivalsIntent : FestivalsIntent = FestivalsIntent(viewModel: festivalsVM)
    
    // States
    @State private var nom: String = ""
    @State private var annee: String = ""
    @State private var estCloture: Bool = false
    
    // View
    var body: some View {
        VStack {
            // Form to create new festival
            Form {
                Section(header: Text("Nom")) {
                    TextField("Nom du Festival", text: $nom)
                }
                Section(header: Text("Année")) {
                    TextField("Année du Festival", text: $annee)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("Cloturé")) {
                    Toggle("Cloturé", isOn: $estCloture)
                }
            }
            
            // Create button
            Button(action:
                    //createFestival
                   festivalsIntent.addFestival(nom: zoneName, nombre_benevoles_necessaires: nbBenevolesMin, idFestival: festivalVM._id)
            ){
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
        if nom.isEmpty || annee.isEmpty {
            return false
        }
        if let year = Int(annee), year <= 0 {
            return false
        }
        return true
    }
}
