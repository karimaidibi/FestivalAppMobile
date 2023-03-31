//
//  JourView.swift
//  FestivalAppMobile
//
//  Created by m1 on 29/03/2023.
//

import Foundation
import SwiftUI

struct JourRowView: View {
    @ObservedObject var jourVM : JourViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                // nom festival
                Text(jourVM.nom)
                    .font(.headline)
                    .padding(1)
                // date
                let formattedDate = UtilityHelper.formattedDateString(from: jourVM.date)
                Text(formattedDate)
                    .font(.subheadline)
                    .padding(1)
                // date ouverture - date fermeture
                Text("\(jourVM.heure_ouverture) - \(jourVM.heure_fermeture)")
                    .font(.body)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Text("... participants")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 10)
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()
