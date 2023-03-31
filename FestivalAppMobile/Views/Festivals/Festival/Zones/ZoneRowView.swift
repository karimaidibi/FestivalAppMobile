//
//  ZoneView.swift
//  FestivalAppMobile
//
//  Created by m1 on 29/03/2023.
//

import Foundation
import SwiftUI


struct ZoneRowView: View {
    @ObservedObject var zoneVM : ZoneViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(zoneVM.nom)
                    .font(.headline)
                
                Text("Bénévoles min. : \(zoneVM.nombre_benevoles_necessaires)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 10)
    }
}


