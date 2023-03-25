//
//  FestivalsView.swift
//  FestivalAppMobile
//
//  Created by etud on 16/03/2023.
//

import Foundation

import SwiftUI

struct FestivalsView: View {
    @State private var festivals: [Festival]
    @ObservedObject var festivalsVM: FakeFestivalsViewModel
    
    init(festivals: [Festival]) {
        self.festivals = festivals
        self.festivalsVM = FakeFestivalsViewModel(festivals: festivals)
    }
    
    var body: some View {
        NavigationView {
            List(festivals.sorted { $0.isActive && !$1.isActive }) { festival in
                NavigationLink(destination: FestivalView(viewModel: festivalsVM.getFestivalViewModel(for: festival)!)) {
                    FestivalRow(viewModel: festivalsVM.getFestivalViewModel(for: festival)!)
                }
            }
            .navigationTitle("Liste des Festivals")
            .navigationBarTitleDisplayMode(.inline)
            .font(.system(size: 18))
            .navigationBarItems(trailing:
                Button(action: {
                    festivals = festivalsVM.addNewFestival(festivals: festivals)
                }, label: {
                    Image(systemName: "plus")
                })
            )
        }
    }
}

struct FestivalRow: View {
    @ObservedObject var viewModel: FakeFestivalViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.name)
                .font(.headline)
            
            Spacer()
            
            Text("\(viewModel.jourListViewModel.jourViewModels.count) Jours")
                .font(.subheadline)
            
            if viewModel.isActive {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            } else {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(viewModel.isActive ? Color.green.opacity(0.1) : Color.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}

struct Festival: Identifiable {
    var id: Int
    var name: String
    var days: [Jour]
    var zones : [Zone]
    var isActive: Bool
}

struct Jour: Identifiable {
    var id: Int
    var date: Date
    var startingTime: String
    var endingTime: String
    var participantCount: Int
    var creneaux: [Creneau]
}

struct Creneau: Identifiable {
    var id: Int
    var startingTime: String
    var endingTime: String
    var areas: [Zone]
}

struct Zone: Identifiable {
    var id: Int
    var name: String
    var nbBenevolesMin : Int
}
