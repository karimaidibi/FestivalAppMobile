//
//  AddJourView.swift
//  FestivalAppMobile
//
//  Created by etud on 30/03/2023.
//

import Foundation

import SwiftUI

struct AddJourView: View {
    @ObservedObject var joursVM: JourListViewModel
    @ObservedObject var festivalsVM: FestivalsViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    // Gestion popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    @State private var nom: String = ""
    @State private var date: String = ""
    @State private var heureOuverture: String = ""
    @State private var heureFermeture: String = ""
    
    var body: some View {
        let joursIntent : JoursIntent = JoursIntent(viewModel: joursVM)
        
        NavigationView {
            Form {
                Section(header: Text("Jour")) {
                    // Nom
                    TextField("Nom", text: $nom)
                    // Date
                    DatePicker("Date", selection: Binding<Date>(
                        get: { // convert the string to a Date
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd" // use the same format as your string date
                            return formatter.date(from: self.date) ?? Date()
                        },
                        set: { // convert the Date to a string
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd" // use the same format as your string date
                            self.date = formatter.string(from: $0)
                        }
                    ), displayedComponents: [.date])
                    .datePickerStyle(.wheel)
                    // Heure d'ouverture
                    TextField("Heure d'ouverture", text: $heureOuverture)
                        .keyboardType(.numbersAndPunctuation)
                    // Heure de fermeture
                    TextField("Heure de fermeture", text: $heureFermeture)
                        .keyboardType(.numbersAndPunctuation)
                }
            }
            .navigationTitle("Ajouter un jour")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Créer") {
                        Task {
                            // Créer le jour
                            let addedJour = await joursIntent.addJour(date: date, nom: nom, heure_ouverture: heureOuverture, heure_fermeture: heureFermeture, idFestival: festivalsVM.getCurrent()._id)
                            if addedJour {
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                // Handle error case
                                showAlert = true
                                alertTitle = "Error"
                                alertMessage = joursVM.errorMessage
                            }
                        }
                    }
                    .disabled(nom.isEmpty || date.isEmpty || heureOuverture.isEmpty || heureFermeture.isEmpty)
                }
            }
        }
    }
}
