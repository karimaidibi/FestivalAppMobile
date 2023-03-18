//
//  FestivalView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct FestivalView: View {
    let festival: Festival
    
    var body: some View {
        List {
            Section(header: Text("Nom")) {
                Text(festival.name)
            }
            
            Section(header: Text("Jours")) {
                ForEach(festival.days) { jour in
                       NavigationLink(destination: JourFestivalView(jour: jour)) {
                           JourRow(jour: jour)
                       }
                   }
            }
        }
        .navigationTitle(festival.name)
    }
}

struct JourRow: View {
    let jour: Jour
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(jour.date, formatter: dateFormatter)
                    .font(.headline)
                
                Text("\(jour.startingTime) - \(jour.endingTime)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("\(jour.participantCount) participants")
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
