//
//  CreneauxView.swift
//  FestivalAppMobile
//
//  Created by etud on 16/03/2023.
//

import Foundation

import SwiftUI

// fake data
let slots: [Slot] = [
    Slot(id: 1, StartingTime: "09:00 AM", EndingTime: "10:00 AM", zone: "Zone A"),
    Slot(id: 2, StartingTime: "11:00 AM", EndingTime: "12:00 PM", zone: "Zone B"),
    Slot(id: 3, StartingTime: "01:00 PM", EndingTime: "02:00 PM", zone: "Zone C"),
    Slot(id: 4, StartingTime: "03:00 PM", EndingTime: "04:00 PM", zone: "Zone D"),
]

struct AffectationsView: View {
    @State private var bookedSlots: [Slot] = []
    @StateObject var benevoleVM : BenevoleViewModel = BenevoleViewModel()
    @StateObject var authManager : AuthManager = AuthManager()
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""

    
    var body: some View {
        
        var benevoleIntent : BenevoleIntent = BenevoleIntent(benevole: benevoleVM)
        
        NavigationView{
            if benevoleVM.loadingAffectations{
                ProgressView("Loading Affectations ...")
            }else{
                VStack {
                    if benevoleVM.affectationDocuments.isEmpty {
                        Text("No booked time slots.")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        List{
                            ForEach(benevoleVM.affectationDocuments, id: \.self){
                                affectationDoc in
                                HStack {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(affectationDoc.idCreneau.heure_debut)
                                            .font(.headline)
                                            .foregroundColor(.gray)
                                        Text(affectationDoc.idCreneau.heure_fin)
                                            .font(.headline)
                                        Text(affectationDoc.idZone.nom)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Button(action: {
                                        // Handle the delete action here by removing the `Slot` from the list
                                        // You can use an alert or a confirmation sheet to ask the user to confirm the delete action
                                        Task{
                                            if let id = authManager.benevoleId{
                                                let deletedAffectation = await benevoleIntent.removeAffectation(id: id, idZone:affectationDoc.idZone._id , idCreneau: affectationDoc.idCreneau._id)
                                                if deletedAffectation{
                                                    // delete the affectation from the list of affectation if benevoleVM
                                                    // Find the index of the affectationDoc in the list
                                                    if let index = benevoleVM.affectationDocuments.firstIndex(where: { $0.idCreneau._id == affectationDoc.idCreneau._id && $0.idZone._id == affectationDoc.idZone._id }) {
                                                        // Remove the affectation from the list at the found index
                                                        benevoleVM.affectationDocuments.remove(at: index)
                                                    }
                                                    // Show the delete success alert
                                                    alertMessage = "Affectation has been successfully deleted."
                                                    alertTitle = "Success"
                                                    showAlert = true
                                                }else{
                                                    // Show the delete error alert
                                                    alertMessage = "Affectation coud not be removed, please try again."
                                                    alertTitle = "Error"
                                                    showAlert = true
                                                }
                                            }
                                        }
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                            }
                            .onDelete{
                                indexSet in benevoleVM.affectationDocuments.remove(atOffsets: indexSet)
                            }
                            .onMove{
                                IndexSet, index in benevoleVM.affectationDocuments.move(fromOffsets: IndexSet, toOffset: index)
                            }
                        }
                    }
                }
                .navigationTitle("Mes créneaux")
                .navigationBarTitleDisplayMode(.inline)
                .font(.system(size: 18))
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .task{
            //bookedSlots = slots
            if let id = authManager.benevoleId{
                let affectationsLoaded = await benevoleIntent.getBenevoleAffectation(id: id)
                if !affectationsLoaded{
                    alertMessage = benevoleVM.errorMessage
                    alertTitle = "Error"
                    showAlert = true
                }
            }

        }
    }
}

struct CardView: View {
    var slot: Slot
    
    var body: some View {
        VStack {
            Text(slot.StartingTime)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            
            Text(slot.EndingTime)
                .font(.headline)
                .padding(.bottom, 10)
            
            Text(slot.zone)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

struct Slot: Identifiable {
    let id: Int
    let StartingTime: String
    let EndingTime: String
    let zone: String
}
