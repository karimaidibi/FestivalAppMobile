//
//  CreneauxView.swift
//  FestivalAppMobile
//
//  Created by etud on 16/03/2023.
//

import Foundation

import SwiftUI

struct AffectationsView: View {
    @ObservedObject var benevoleVM : BenevoleViewModel
    @StateObject var authManager : AuthManager = AuthManager()
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""

    var isAdminGestion : Bool
    
    var body: some View {
        
        let benevoleIntent : BenevoleIntent = BenevoleIntent(benevole: benevoleVM)
        
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
                                        HStack{
                                            Text(affectationDoc.idCreneau.heure_debut)
                                                .font(.headline)
                                            Text("- \(affectationDoc.idCreneau.heure_fin)")
                                                .font(.headline)
                                        }
                                        Text("Zone : \(affectationDoc.idZone.nom)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        if let jour = affectationDoc.idCreneau.idJour{
                                            Text("Jour : \(jour.nom) - \(UtilityHelper.formattedDateString(from: jour.date))")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        if let festival = affectationDoc.idZone.idFestival{
                                            Text("Festival : \(festival.nom) - \(String(festival.annee))")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    Spacer()
                                    Button(action: {
                                        // Handle the delete action here by removing the `Slot` from the list
                                        // You can use an alert or a confirmation sheet to ask the user to confirm the delete action
                                        Task{
                                            if let _ = authManager.benevoleId{
                                                let deletedAffectation = await benevoleIntent.removeAffectation(id: benevoleVM._id, idZone:affectationDoc.idZone._id , idCreneau: affectationDoc.idCreneau._id)
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
                .navigationBarHidden(isAdminGestion)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear(perform: {
            Task{
                if let _ = authManager.benevoleId{
                    let affectationsLoaded = await benevoleIntent.getBenevoleAffectation(id: benevoleVM._id)
                }
            }
        })
    }
}
