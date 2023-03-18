//
//  FestivalsView.swift
//  FestivalAppMobile
//
//  Created by etud on 16/03/2023.
//

import Foundation

import SwiftUI

struct FestivalsView: View {
    let festivals: [Festival]
    
    init(festivals: [Festival]) {
        self.festivals = festivals
    }
    
    var body: some View {
        NavigationView {
            List(festivals.sorted { $0.isActive && !$1.isActive }) { festival in
                NavigationLink(destination: FestivalView(festival: festival)) {
                    FestivalRow(festival: festival)
                }
            }
            .navigationTitle("Liste des Festivals")
            .navigationBarTitleDisplayMode(.inline)
            .font(.system(size: 18))
        }
    }
}

struct FestivalRow: View {
    let festival: Festival
    
    var body: some View {
        HStack {
            Text(festival.name)
                .font(.headline)
            
            Spacer()
            
            Text("\(festival.days.count) Jours")
                .font(.subheadline)
            
            if festival.isActive {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            } else {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(festival.isActive ? Color.green.opacity(0.1) : Color.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

struct Festival: Identifiable {
    let id: Int
    let name: String
    let days: [Jour]
    let isActive: Bool
}

struct Jour: Identifiable {
    let id: Int
    let date: Date
    let startingTime: String
    let endingTime: String
    let participantCount: Int
    let creneaux: [Creneau]
}

struct Creneau: Identifiable {
    let id: Int
    let startingTime: String
    let endingTime: String
    let area: String
}
