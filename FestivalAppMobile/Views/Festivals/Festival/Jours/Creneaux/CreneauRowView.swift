//
//  CreneauRowView.swift
//  FestivalAppMobile
//
//  Created by m1 on 29/03/2023.
//

import Foundation
import SwiftUI

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
