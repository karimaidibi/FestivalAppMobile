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
    @ObservedObject var festivalVM: FestivalViewModel
    
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
        
        // Constants for the year 2023
        let festivalYear: Int = festivalVM.annee
          let startOfYear = Calendar.current.date(from: DateComponents(year: festivalYear, month: 1, day: 1))!
          let endOfYear = Calendar.current.date(from: DateComponents(year: festivalYear, month: 12, day: 31))!

        
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
                    ), in: startOfYear...endOfYear, displayedComponents: [.date])
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
                            let addedJour = await joursIntent.addJour(date: date, nom: nom, heure_ouverture: heureOuverture, heure_fermeture: heureFermeture, idFestival: festivalVM._id)
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}
