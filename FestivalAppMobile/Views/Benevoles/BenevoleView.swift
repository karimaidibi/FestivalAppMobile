//
//  BenevoleView.swift
//  FestivalAppMobile
//
//  Created by etud on 24/03/2023.
//

import Foundation

import SwiftUI

struct BenevoleView: View {
    let benevoleVM: BenevoleViewModel
    
    @State private var selection = 0
    
    var body: some View {
        VStack {            
            Picker(selection: $selection, label: Text("Sélectionner une option")) {
                Text("Festivals").tag(0)
                Text("Créneaux").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if selection == 0 {
                FestivalsView(festivals: fakeFestivals)
            } else {
                AffectationsView()
            }
        }
        .navigationTitle("Gestion de \(benevoleVM.nom)")
    }
}
