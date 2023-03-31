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
        
        VStack {
            // Form to update a zone festival
            // Hstack principale
            HStack{
                
                // Vtack des text libellé
                VStack{
                    Text("Nom de la zone : ")
                    Text("Nombre de bénévoles nécessaires : ")
                }
                .padding()
                // vstack des textField
                VStack{
                    TextField(zoneNom, text : self.$zoneNom)
                    Stepper(value: $zoneNbBenevoles, in: 0...100, step: 1) {
                        Text("\(zoneNbBenevoles)")
                    }
                }
                .padding()
            }
            .padding()
            
            // Create button
            Button(action: {
                Task {
                    // Créer le festival
        
                    // Handle error case
                }
            }) {
                Text("valider")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .padding(.top, 50)
            .disabled(!formIsValid()) // disable button if form is not valid
        }
        .padding()
        .navigationTitle("Modifier Une Zone")
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
