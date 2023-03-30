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
    
    var body: some View {
            VStack {
                AffectationsView(benevoleVM: benevoleVM, isAdminGestion: true)
            }
            .navigationTitle("Affectations de \(benevoleVM.nom)")
        }
}
