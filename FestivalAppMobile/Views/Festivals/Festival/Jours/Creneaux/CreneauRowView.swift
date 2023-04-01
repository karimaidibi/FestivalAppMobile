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
            if creneauVM.loading{
                ProgressView("loading creneau...")
            }else{
                HStack {
                    Text("\(creneauVM.heure_debut) - \(creneauVM.heure_fin)")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("\($nbre_benevoles_inscrits.wrappedValue) bénévoles / \(creneauVM.nbreBenevolesMax)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
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
            let _  = creneauIntent.getNbreBenevolesMax(zonesVM: zonesVM)
        })
        .task {
            nbre_benevoles_inscrits = await creneauIntent.getNbreBenevolesDocInCreneau(benevolesDocVM: benevolesVM)
        }
 
    }
}
