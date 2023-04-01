//
//  JourFestivalView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct JourView: View {
    @ObservedObject var viewModel: JourViewModel
    @StateObject var benevolesVM : BenevoleListViewModel = BenevoleListViewModel(benevoleViewModels: [])
    @ObservedObject var festivalVM : FestivalViewModel
    @StateObject var zonesVM : ZoneListViewModel = ZoneListViewModel(zoneViewModelArray: [])
    @State var nbre_participants = 0

    // for popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    var body: some View {
        
        let benevolesIntent : BenevolesIntent = BenevolesIntent(viewModel: benevolesVM)
        let festivalIntent : FestivalIntent = FestivalIntent(viewModel: festivalVM)
        let zonesIntent : ZonesIntent = ZonesIntent(viewModel: zonesVM)
        
        List {
            if benevolesVM.loading || zonesVM.loading{
                ProgressView("Loading Jour ...")
            }else{
                let formattedDate = UtilityHelper.formattedDateString(from: viewModel.date)
                Section(header: Text("Date")) {
                    Text(formattedDate)
                        .font(.title)
                }
                
                Section(header: Text("Nom")) {
                    Text(viewModel.nom)
                        .font(.headline)
                }
                
                Section(header: Text("Heure ouverture - Heure fermeture")) {
                    Text("\(viewModel.heure_ouverture) - \(viewModel.heure_fermeture)")
                        .font(.body)
                }
                
                Section(header: Text("Participants")) {
                    Text("Nombre de participants : \(nbre_participants)")
                        .font(.body)
                }
                
                CreneauListView(jourVM: viewModel, benevolesVM : benevolesVM, zonesVM: zonesVM)
            }
        }
        .navigationTitle("Jour")
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .task {
            // load the list of benevoles with their nested affectations
            let benevolesDocLoaded = await benevolesIntent.getBenevolesNested()
            if benevolesDocLoaded{
                nbre_participants = festivalIntent.getNbreBenevolesDocInFestival(benevolesDocVM: benevolesVM)
            }
 
            let zonesLoaded = await zonesIntent.getZonesByFestival(festivalId: festivalVM._id)
            if !zonesLoaded{
                alertMessage = zonesVM.errorMessage
                alertTitle = "Error"
                showAlert = true
            }
        }
    }
}


