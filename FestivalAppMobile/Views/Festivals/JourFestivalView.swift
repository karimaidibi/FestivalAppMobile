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
            
            List(jour.creneaux) { creneau in
                CreneauRow(creneau: creneau)
            }
        }
        .navigationTitle("Jour")
    }
}

struct CreneauRow: View {
    let creneau: Creneau
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(creneau.startingTime) - \(creneau.endingTime)")
                    .font(.headline)
                
                Text(creneau.area)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(.vertical, 10)
    }
}
