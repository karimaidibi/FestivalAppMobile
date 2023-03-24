//
//  JourFestivalView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct JourFestivalView: View {
    @StateObject var viewModel: JourViewModel

    var body: some View {
        VStack {
            Text(viewModel.jour.date, formatter: dateFormatter)
                .font(.title)
                .padding(.top, 20)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(viewModel.jour.creneaux) { creneau in
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
        .navigationBarItems(trailing:
            Button(action: {
            viewModel.addNewCreneau()
            }, label: {
                Image(systemName: "plus")
            })
        )
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
