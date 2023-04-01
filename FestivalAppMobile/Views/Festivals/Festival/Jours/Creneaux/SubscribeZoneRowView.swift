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
    
    // for popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    var body: some View {
        
        let benevoleIntent : BenevoleIntent = BenevoleIntent(benevole: benevoleVM)
        
        HStack {
            VStack(alignment: .leading) {
                Text(zoneVM.nom)
                    .font(.headline)
                
                Text("Bénévoles min. : \(zoneVM.nombre_benevoles_necessaires)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // subscribe button
                Button(action: {
                    Task {
                        let affectationAdded = await benevoleIntent.addAffectation(benevoleId: benevoleVM._id, idZone: zoneVM._id, idCreneau: creneauVM._id)
                        if affectationAdded{
                            alertMessage = "Le benevole est affecté avec succes !"
                            alertTitle = "Success"
                            showAlert = true
                        }else{
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
                        .background(Color.green)
                        .cornerRadius(15.0)
                }
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}


