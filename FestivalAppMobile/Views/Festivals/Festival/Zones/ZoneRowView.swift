//
//  ZoneView.swift
//  FestivalAppMobile
//
//  Created by m1 on 29/03/2023.
//

import Foundation
import SwiftUI


struct ZoneView: View {
    let zone: Zone
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(zone.name)
                    .font(.headline)
                
                Text("Bénévoles min. : \(zone.nbBenevolesMin)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 10)
    }
}


