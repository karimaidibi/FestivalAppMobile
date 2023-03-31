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
    
    // popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    
    var body: some View {
        
        let benevoleListIntent : BenevolesIntent = BenevolesIntent(viewModel: viewModel)
        
        VStack {
            SearchBar(text: $searchText, placeholder: "Rechercher par nom, prénom ou email")
            
            List(filteredBenevoles, id: \._id) { benevoleVM in
                NavigationLink(destination: BenevoleView(benevoleVM: benevoleVM)) {
                    BenevoleRowView(viewModel: benevoleVM)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .task {
            // call the intent to fetch data
            let benevoleLoaded = await benevoleListIntent.getBenevoles()
            if !benevoleLoaded{
                alertMessage = viewModel.errorMessage
                alertTitle = "Error"
                showAlert = true
            }else{
                // if loaded
                self.filteredBenevoles = viewModel.benevoleViewModels
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
