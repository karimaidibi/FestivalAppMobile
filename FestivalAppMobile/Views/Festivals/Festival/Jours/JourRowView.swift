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
                let formattedDate = formattedDateString(from: jourVM.date)
                Text(formattedDate)
                    .font(.headline)
                    .padding(1)
                
                Text("\(jourVM.heure_ouverture) - \(jourVM.heure_fermeture)")
                    .font(.subheadline)
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


func formattedDateString(from dateString: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

    if let date = inputFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMMM yyyy"
        return outputFormatter.string(from: date)
    } else {
        return dateString
    }
}

