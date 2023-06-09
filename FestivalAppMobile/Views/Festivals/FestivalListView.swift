//
//  FestivalsView.swift
//  FestivalAppMobile
//
//  Created by etud on 16/03/2023.
//

import Foundation

import SwiftUI


struct FestivalListView: View {
    
    @StateObject var festivalsVM: FestivalsViewModel = FestivalsViewModel(festivalViewModels: [])
    @EnvironmentObject var authManager : AuthManager
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    var body: some View {
        
        let festivalsIntent : FestivalsIntent = FestivalsIntent(viewModel: festivalsVM)
        
        NavigationView {
            if festivalsVM.loading{
                ProgressView("Loading Festivals ...")
            }else{
                List {
                    ForEach(festivalsVM.sorted { !$0.estCloture && $1.estCloture }, id: \.self){
                        festival in
                        NavigationLink(destination: FestivalView(festivalsVM: festivalsVM, viewModel: festival)) {
                            FestivalRow(viewModel: festival)
                        }
                    }
                    .onDelete { indexSet in
                        Task {
                            let festival = festivalsVM[indexSet.first!]
                            let deletedFestival = await festivalsIntent.removeFestival(id: festival._id)
                            if deletedFestival {
                                alertMessage = festivalsVM.successMessage
                                alertTitle = "Success"
                                showAlert = true
                                festivalsVM.remove(atOffsets: indexSet)
                            }else{
                                alertMessage = festivalsVM.errorMessage
                                alertTitle = "Error"
                                showAlert = true
                            }
                        }
                    }
                    .onMove{
                        IndexSet, index in festivalsVM.move(fromOffsets: IndexSet, toOffset: index)
                    }
                }
                .navigationTitle("Liste des Festivals")
                .navigationBarTitleDisplayMode(.inline)
                .font(.system(size: 18))
                .navigationBarItems(trailing:
                    HStack {
                        if let isAdmin = authManager.isAdmin{
                            if isAdmin{
                                // First button
                                Button(action: {
                                }) {
                                    // envoie le user vers la page de création du festival
                                    NavigationLink(destination: AddFestivalView(festivalsVM: festivalsVM)) {
                                        Image(systemName: "plus")
                                    }
                                }
                                // Second button
                                Button(action: {}) {
                                    CustomEditButton()
                                }
                            }
                        }
                    }
                )

            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .task {
            // call the intent to fetch data
            let festivalLoaded = await festivalsIntent.getFestivals()
            if !festivalLoaded{
                alertMessage = festivalsVM.errorMessage
                alertTitle = "Error"
                showAlert = true
            }
        }
    }
}

struct FestivalRow: View {
    @ObservedObject var viewModel: FestivalViewModel
    @StateObject var joursVM : JourListViewModel = JourListViewModel(jourViewModels: [])
    
    var body: some View {
        let joursIntent : JoursIntent = JoursIntent(viewModel: joursVM)
        
        HStack {
            Text(viewModel.nom)
                .font(.headline)
            
            Spacer()
            
            Text(String(viewModel.annee))
                .font(.subheadline)
            
            Spacer()
            
            if joursVM.loading{
                ProgressView("...")
            }else{
                Text("\(viewModel.jourListViewModels.count) Jours")
                    .font(.body)
            }
            
            if !viewModel.estCloture {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            } else {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(!viewModel.estCloture ? Color.green.opacity(0.1) : Color.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
        .task {
            // get la liste des jours
            let joursLoaded = await joursIntent.getJoursByFestival(festivalId: viewModel._id)
            if(joursLoaded){
                // set the list of jours of the festival view model
                viewModel.jourListViewModels = joursVM // on sait que le joursVM a ete deja mis a jour par son intent
            }
        }
    }
}
