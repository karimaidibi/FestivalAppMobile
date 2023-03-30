//
//  AddJourView.swift
//  FestivalAppMobile
//
//  Created by etud on 30/03/2023.
//

import Foundation

import SwiftUI

struct AddJourView: View {
    @EnvironmentObject var viewModel: JoursViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var nom: String = ""
    @State private var date: String = ""
    @State private var heureOuverture: String = ""
    @State private var heureFermeture: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Jour")) {
                    TextField("Nom", text: $nom)
                    DatePicker("Date", selection: $date, displayedComponents: [.date])
                        .datePickerStyle(.wheel)
                    TextField("Heure d'ouverture", text: $heureOuverture)
                        .keyboardType(.numbersAndPunctuation)
                    TextField("Heure de fermeture", text: $heureFermeture)
                        .keyboardType(.numbersAndPunctuation)
                }
            }
            .navigationTitle("Ajouter un jour")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Créer") {
                        // Créer
                        let newJour = JourDTO(_id: "", date: date, nom: nom, heure_ouverture: heureOuverture, heure_fermeture: heureFermeture, idFestival: viewModel.currentFestival._id)
                        viewModel.addJour(jour: newJour)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(nom.isEmpty || date.isEmpty || heureOuverture.isEmpty || heureFermeture.isEmpty)
                }
            }
        }
    }
}
