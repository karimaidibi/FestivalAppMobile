//
//  CreneauRowView.swift
//  FestivalAppMobile
//
//  Created by m1 on 29/03/2023.
//

import Foundation
import SwiftUI

struct CreneauRowView: View {
    
    @ObservedObject var creneauVM: CreneauViewModel
    @ObservedObject var benevolesVM : BenevoleListViewModel
    @ObservedObject var zonesVM : ZoneListViewModel
    
    @State var nbre_benevoles_inscrits = 0
    
    var body: some View {
        
        let creneauIntent : CreneauIntent = CreneauIntent(viewModel : creneauVM)
        
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("\(creneauVM.heure_debut) - \(creneauVM.heure_fin)")
                    .font(.headline)
                
                Spacer()
                
                Text("\(nbre_benevoles_inscrits) bénévoles / \(zonesVM.count)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            //ForEach(creneau.areas) { zone in
              //  HStack {
                //    Text(zone.name)
                  //      .font(.subheadline)
                    
                   // Spacer()
                    
                   // Text("\(zone.nbBenevolesMin) bénévoles")
                     //   .font(.subheadline)
                       // .foregroundColor(.gray)
        }
        .onAppear(perform: {
            let benevolesFiltered = creneauIntent.getBenevolesDocInCreneau(benevolesDocVM: benevolesVM.benevoleViewModels)
            self.nbre_benevoles_inscrits = benevolesFiltered.count
        })
    }
}
