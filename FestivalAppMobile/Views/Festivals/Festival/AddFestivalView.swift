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
    @StateObject var zonesVM : ZoneListViewModel = ZoneListViewModel(zoneViewModelArray: [])
    @State var joursVM : JourListViewModel = JourListViewModel(jourViewModels: [])
    
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
        let zonesIntent : ZonesIntent = ZonesIntent(viewModel: zonesVM)
        let joursIntent : JoursIntent = JoursIntent(viewModel: joursVM)
        
        VStack {
            // Form to create new festival
            if festivalsVM.loading || joursVM.loading || zonesVM.loading{
                ProgressView("Please Wait ...")
            }else{
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
            }
            
            // Create button
            Button(action: {
                Task {
                    // Créer le festival
                    let addedFestival = await festivalsIntent.addFestival(nom: nom, annee: annee, estCloture: estCloture)
                    // Handle error case
                    if let addedFestival = addedFestival {
                        // create a default jour
                        let formattedDate = "\(addedFestival.annee)-01-01"
                        let heure_ouverture = "09:00"
                        let heure_fermeture = "21:00"
                        let addedJour = await joursIntent.addJour(date: formattedDate, nom: "Default Day", heure_ouverture: heure_ouverture, heure_fermeture: heure_fermeture, idFestival: addedFestival._id)
                        if addedJour{
                            // create the default zone
                            let addedZone = await zonesIntent.addZone(nom: "Libre", nombre_benevoles_necessaires: 10, idFestival: addedFestival._id)
                            if addedZone{
                                presentationMode.wrappedValue.dismiss()
                            }else{
                                // Handle error case
                                showAlert = true
                                alertTitle = "Error"
                                alertMessage = zonesVM.errorMessage
                            }
                        }else{
                            // Handle error case
                            showAlert = true
                            alertTitle = "Error"
                            alertMessage = joursVM.errorMessage
                        }
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    // Check if form is valid
    private func formIsValid() -> Bool {
        if nom.isEmpty {
            return false
        }
        return true
    }
}
