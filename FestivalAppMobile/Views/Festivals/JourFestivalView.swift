//
//  JourFestivalView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct JourFestivalView: View {
    let jour: Jour

    var body: some View {
        VStack {
            Text(jour.date, formatter: dateFormatter)
                .font(.title)
                .padding(.top, 20)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(jour.creneaux) { creneau in
                        Divider() // comme sur angular mat
                        CreneauRow(creneau: creneau)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            }

            Spacer()
        }
        .navigationTitle("Jour")
    }
}

struct CreneauRow: View {
    let creneau: Creneau
    
    var totalVolunteers: Int {
        creneau.areas.reduce(0) { $0 + $1.nbBenevolesMin }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("\(creneau.startingTime) - \(creneau.endingTime)")
                    .font(.headline)
                
                Spacer()
                
                Text("\(totalVolunteers) bénévoles")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            ForEach(creneau.areas) { zone in
                HStack {
                    Text(zone.name)
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text("\(zone.nbBenevolesMin) bénévoles")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
