//
//  SubscribeBenevolesView.swift
//  FestivalAppMobile
//
//  Created by etud on 30/03/2023.
//

import Foundation

import SwiftUI


//fake DTO
struct Benevole: Identifiable {
    var id : String
    var nom : String
    var prenom : String
    var email : String
    var password : String
    var isAdmin : Bool
}

//fake data
let benevoles: [Benevole] = [
    Benevole(id: "1", nom: "Dupont", prenom: "Jean", email: "jean.dupont@example.com", password: "password", isAdmin: false),
    Benevole(id: "2", nom: "Durand", prenom: "Pierre", email: "pierre.durand@example.com", password: "password", isAdmin: true),
    Benevole(id: "3", nom: "Martin", prenom: "Marie", email: "marie.martin@example.com", password: "password", isAdmin: false),
    Benevole(id: "4", nom: "Bernard", prenom: "Sophie", email: "sophie.bernard@example.com", password: "password", isAdmin: false),
    Benevole(id: "5", nom: "Petit", prenom: "Paul", email: "paul.petit@example.com", password: "password", isAdmin: false),
    Benevole(id: "6", nom: "Robert", prenom: "Lucie", email: "lucie.robert@example.com", password: "password", isAdmin: false),
    Benevole(id: "7", nom: "Richard", prenom: "Julie", email: "julie.richard@example.com", password: "password", isAdmin: false),
    Benevole(id: "8", nom: "Dumont", prenom: "Nicolas", email: "nicolas.dumont@example.com", password: "password", isAdmin: false),
    Benevole(id: "9", nom: "Moreau", prenom: "Céline", email: "celine.moreau@example.com", password: "password", isAdmin: false),
    Benevole(id: "10", nom: "Dubois", prenom: "Marcel", email: "marcel.dubois@example.com", password: "password", isAdmin: false)
]


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
                        HStack {
                            Text(benevoleVM.nom)
                            Spacer()
                            if selectedBenevoles.contains(benevoleVM) {
                                Image(systemName: "checkmark")
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if selectedBenevoles.contains(benevoleVM) {
                                selectedBenevoles.remove(benevoleVM)
                            } else {
                                selectedBenevoles.insert(benevoleVM)
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
                let benevolesLoaded = await benevoleListIntent.getBenevolesNested()
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
