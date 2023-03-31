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
                EmptyView()
                //ForEach(CreneauViewModels) { creneauVM in
                    //NavigationLink(destination: CreneauView(viewModel: creneauVM)) {
                        //CreneauRow(creneau: creneauVM)
                    //}
                //}
            }
            .navigationTitle("Liste des créneaux")
        }
    
}
