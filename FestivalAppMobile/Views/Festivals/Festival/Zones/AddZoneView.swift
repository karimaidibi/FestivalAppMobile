//
//  AddZoneView.swift
//  FestivalAppMobile
//
//  Created by etud on 30/03/2023.
//

import Foundation

import SwiftUI

struct AddZoneView: View {
    // @ObservedObject var viewModel: AddZoneViewModel
    @ObservedObject var festivalVM: FestivalViewModel
    let zoneIntent : ZoneIntent
    @State private var zoneName = ""
    @State private var nbBenevolesMin = ""
    
    var body: some View {
        Form {
            Section(header: Text("Infos de la zone")) {
                TextField("Nom", text: zoneName)
                Stepper("Nombre de bénévoles nécessaires: \(nbBenevolesMin)", value: $nbBenevolesMin, in: 1...100)
            }
            
            Section {
                Button(action: {
                    zoneIntent.addZone(nom: zoneName, nombre_benevoles_necessaires: nbBenevolesMin, idFestival: festivalVM._id)
                }) {
                    Text("Créer")
                }
            }
        }
        .navigationTitle("Ajouter une zone")
    }
}
