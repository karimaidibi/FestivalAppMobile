//
//  BenevoleListView.swift
//  FestivalAppMobile
//
//  Created by etud on 24/03/2023.
//

import Foundation

import SwiftUI

import Combine

struct BenevoleListView: View {
    @StateObject var viewModel: BenevoleListViewModel = BenevoleListViewModel(benevoleViewModels: [])
    
    @State private var searchText = ""
    @State private var filteredBenevoles: [BenevoleViewModel] = []
    
    
    var body: some View {
        
        
        VStack {
            SearchBar(text: $searchText, placeholder: "Rechercher par nom, prénom ou email")
            
            List(filteredBenevoles, id: \._id) { benevoleVM in
                NavigationLink(destination: BenevoleView(benevoleVM: benevoleVM)) {
                    BenevoleRow(viewModel: benevoleVM)
                }
            }
        }
        .onReceive(Just(searchText)) { searchText in
            if searchText.isEmpty {
                filteredBenevoles = viewModel.benevoleViewModels
            } else {
                filteredBenevoles = viewModel.benevoleViewModels.filter { benevole in
                    benevole.nom.localizedCaseInsensitiveContains(searchText) ||
                    benevole.prenom.localizedCaseInsensitiveContains(searchText) ||
                    benevole.email.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
    }
}

struct BenevoleRow: View {
    @ObservedObject var viewModel: BenevoleViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(viewModel.prenom) \(viewModel.nom)")
                    .font(.headline)
                
                Text(viewModel.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 10)
    }
}

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField(placeholder, text: $text)
                .foregroundColor(.primary)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
