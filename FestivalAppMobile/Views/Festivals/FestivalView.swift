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
    @State private var selectedSection : FestivalSection = .jours // par défaut
    
    enum FestivalSection {
            case jours
            case zones
        }
    
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
            Picker(selection: $selectedSection, label: Text("")) {
                Text("Jours").tag(FestivalSection.jours)
                Text("Zones").tag(FestivalSection.zones)
            }
            .pickerStyle(SegmentedPickerStyle())
            .listRowBackground(Color.white)
            
            // affichage de la section
            if selectedSection == .jours {
                Section(header: Text("Jours")) {
                    ForEach(viewModel.days) { jour in
                        NavigationLink(destination: JourFestivalView(jour: jour)) {
                            JourRow(jour: jour)
                        }
                    }
                }
            } else {
                Section(header: Text("Zones")) {
                    // Display the list of zones
                    ForEach(viewModel.zones) { zone in
                        ZoneRow(zone: zone)
                    }
                }
            }
        }
        .navigationTitle(viewModel.name)
        .navigationBarItems(trailing:
            Button(action: {
                if selectedSection == .jours {
                    viewModel.addNewDay()
                } else {
                    viewModel.addNewZone()
                }
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

struct ZoneRow: View {
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

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()

