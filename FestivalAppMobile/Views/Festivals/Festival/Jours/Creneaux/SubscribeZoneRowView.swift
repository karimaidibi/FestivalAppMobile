//
//  SubscribeZoneRow.swift
//  FestivalAppMobile
//
//  Created by m1 on 01/04/2023.
//

import Foundation
import SwiftUI


struct SubscribeZoneRowView: View {
    @ObservedObject var zoneVM : ZoneViewModel
    @ObservedObject var creneauVM : CreneauViewModel
    @ObservedObject var benevoleVM : BenevoleViewModel
    @ObservedObject var benevolesVM : BenevoleListViewModel
    @ObservedObject var festivalVM : FestivalViewModel
    @StateObject var authManager : AuthManager = AuthManager()
    
    // for popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    var body: some View {
        
        let benevoleIntent : BenevoleIntent = BenevoleIntent(benevole: benevoleVM)
        let zoneIntent : ZoneIntent = ZoneIntent(viewModel: zoneVM)
        
        HStack {
            if zoneVM.loading{
                ProgressView("Loading ...")
            }else{
                VStack(alignment: .leading) {
                    Text(zoneVM.nom)
                        .font(.headline)
                        .padding(.bottom, 1)
                    
                    Text("Bénévoles min. : \(zoneVM.nombre_benevoles_necessaires)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 1)
                    
                    Text("Bénévoles inscrits. : \(zoneVM.nbre_benevoles_inscrits)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    
                    
                    // subscribe button
                    if authManager.isAdmin! {
                        NavigationLink(destination: SubscribeBenevolesView(zoneVM : zoneVM, creneauVM : creneauVM)) {
                            Text("Inscrire des bénévoles")
                        }
                    } else {
                        Button(action: {
                            guard zoneVM.nbre_benevoles_inscrits < zoneVM.nombre_benevoles_necessaires else{
                                alertMessage = "Le nombre maximal de bénévoles est atteint pour ce creneau"
                                alertTitle = "Choisissez un autre creneau"
                                showAlert = true
                                return
                            }
                            Task {
                                let affectationAdded = await benevoleIntent.addAffectation(benevoleId: benevoleVM._id, idZone: zoneVM._id, idCreneau: creneauVM._id)
                                if affectationAdded{
                                    alertMessage = "Le benevole est affecté avec succes !"
                                    alertTitle = "Success"
                                    showAlert = true
                                } else {
                                    alertMessage = benevoleVM.errorMessage
                                    alertTitle = "Error"
                                    showAlert = true
                                }
                            }
                        }) {
                            Text("M'inscrire")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 150, height: 20)
                                .background(festivalVM.estCloture ? Color.gray : Color.green)
                                .cornerRadius(15.0)
                        }
                        .disabled(festivalVM.estCloture)
                    }
                }
                Spacer()
            }
        }
        .padding(.vertical, 10)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear(perform: {
            let _ = zoneIntent.getNbreBenevolesInZone(creneauId: creneauVM._id, benevolesDocVM: benevolesVM)
        })
    }
}


