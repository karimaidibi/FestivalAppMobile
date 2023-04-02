//
//  SubscribeBenevolesView.swift
//  FestivalAppMobile
//
//  Created by etud on 30/03/2023.
//

import Foundation

import SwiftUI


struct SubscribeBenevolesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var benevolesVM: BenevoleListViewModel = BenevoleListViewModel(benevoleViewModels: [])
    @ObservedObject var zoneVM : ZoneViewModel
    @ObservedObject var creneauVM : CreneauViewModel
    
    // for popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    @State private var searchText = ""
    @State private var selectedBenevoles: Set<BenevoleViewModel> = []
    
    var body: some View {
        
        let benevoleListIntent : BenevolesIntent = BenevolesIntent(viewModel : benevolesVM)
        
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Rechercher un bénévole")
                
                List {
                    ForEach(benevolesVM.filteredBenevoles(searchText: searchText)) { benevoleVM in
                        let isDejaAffecte =  benevoleVM.affectations.contains(where: { $0.idCreneau == creneauVM._id && $0.idZone == zoneVM._id })
                        HStack {
                            Text(benevoleVM.nom)
                            // if the creneau._id and zone_id exist in the affectations of the benevoleVM
                            // mark it with "déjà affecté"
                            if isDejaAffecte {
                                  Spacer()
                                  Text("déjà affecté")
                                      .foregroundColor(.red)
                              }
                            Spacer()
                            if selectedBenevoles.contains(benevoleVM) {
                                Image(systemName: "checkmark")
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            // Only allow selection if the benevole is not "déjà affecté"
                            if !isDejaAffecte{
                                if selectedBenevoles.contains(benevoleVM) {
                                    selectedBenevoles.remove(benevoleVM)
                                } else {
                                    selectedBenevoles.insert(benevoleVM)
                                }
                            }
                        }
                    }
                }
                
                Button(action: {
                    Task {
                        let benevoleIds = benevoleListIntent.benevoleIds(benevoleVMs: Array(selectedBenevoles))
                        let addedAffectations = await benevoleListIntent.addAffectationOfBenevoles(benevoleIds: benevoleIds, idZone: zoneVM._id, idCreneau: creneauVM._id)
                        if addedAffectations {
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            // Handle error case
                            showAlert = true
                            alertTitle = "Error"
                            alertMessage = benevolesVM.errorMessage
                        }
                        
                    }
                    
                }, label: {
                    Text("Valider les inscriptions")
                        .foregroundColor(selectedBenevoles.isEmpty ? .gray : .blue)
                })
                .disabled(selectedBenevoles.isEmpty)
                .padding()
                
                Spacer()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .task {
                let benevolesLoaded = await benevoleListIntent.getBenevoles()
                if !benevolesLoaded{
                    alertMessage = benevolesVM.errorMessage
                    alertTitle = "Error"
                    showAlert = true
                }
            }
            .navigationTitle("Inscription bénévoles")
            .navigationBarTitleDisplayMode(.inline)
            .font(.system(size: 18))
        }
    }
}
