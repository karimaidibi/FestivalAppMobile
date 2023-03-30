//
//  CreneauListView.swift
//  FestivalAppMobile
//
//  Created by etud on 30/03/2023.
//

import Foundation

import SwiftUI

struct CreneauListView: View {
    let creneaux: [Creneau]
    let CreneauViewModels : [CreneauViewModel]
        
        var body: some View {
            List {
                ForEach(CreneauViewModels) { creneau in
                    NavigationLink(destination: CreneauView(creneauVM: creneau)) {
                        CreneauRow(creneau: creneau)
                    }
                }
            }
            .navigationTitle("Liste des créneaux")
        }
    
}
