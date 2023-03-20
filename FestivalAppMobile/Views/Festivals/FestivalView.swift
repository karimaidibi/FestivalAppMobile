//
//  FestivalView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct FestivalView: View {
    @StateObject var viewModel: FestivalViewModel
    @State private var isEditingName = false
    @State private var editedName = ""
    
    var body: some View {
        List {
            Section(header: Text("Nom")) {
                if isEditingName {
                    TextField("Nom du Festival", text: $editedName, onCommit: {
                        isEditingName = false
                        viewModel.updateFestivalName(name: editedName)
                    })
                } else {
                    Text(viewModel.name)
                        .font(.headline)
                        .onTapGesture {
                            isEditingName = true
                            editedName = viewModel.name
                        }
                }
            }
            Section(header: Text("Jours")) {
                ForEach(viewModel.days) { jour in
                    NavigationLink(destination: JourFestivalView(jour: jour)) {
                        JourRow(jour: jour)
                    }
                }
            }
        }
        .navigationTitle(viewModel.name)
        .navigationBarItems(trailing:
            Button(action: {
                viewModel.addNewDay()
            }, label: {
                Image(systemName: "plus")
            })
        )
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
