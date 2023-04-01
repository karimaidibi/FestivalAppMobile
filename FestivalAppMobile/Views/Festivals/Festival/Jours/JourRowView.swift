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
    @ObservedObject var benevolesVM : BenevoleListViewModel
    
    @State var nbre_participants = 0
    
    var body: some View {
        
        let jourIntent : JourIntent = JourIntent(viewModel: jourVM)
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
            
            Text("\(nbre_participants) participants")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 10)
        .onAppear(perform : {
            let benevolesFiltered = jourIntent.getBenevolesDocInJour(benevolesDocVM: benevolesVM)
            nbre_participants = benevolesFiltered.count
        })
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()
