//
//  CreneauListView.swift
//  FestivalAppMobile
//
//  Created by m1 on 30/03/2023.
//

import Foundation
import SwiftUI

struct CreneauListView : View{
    @ObservedObject var jourVM : JourViewModel
    @ObservedObject var benevolesVM : BenevoleListViewModel
    @StateObject var creneauxVM : CreneauListViewModel = CreneauListViewModel(creneauViewModelArray: [])
    @ObservedObject var zonesVM : ZoneListViewModel
    // for popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    var body: some View{
        
        let creneauListIntent : CreneauListIntent = CreneauListIntent(viewModel: creneauxVM)
        
        Section(header: Text("Creneaux du jour")) {
                    ForEach(creneauxVM) { creneauVM in
                        NavigationLink(destination: SubscribeZoneListView(creneauVM : creneauVM, zonesVM: zonesVM)) {
                            CreneauRowView(creneauVM: creneauVM, benevolesVM : benevolesVM, zonesVM: zonesVM)
                            Divider() // comme sur angular mat
                        }
                    }
                .padding(.horizontal, 20)
                .padding(.top, 20)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .task {
            let creneauxLoaded = await creneauListIntent.getCreneauxByJour(jourId: jourVM._id)
            if !creneauxLoaded{
                // afficher erreur popup
                alertMessage = creneauxVM.errorMessage
                alertTitle = "Error"
                showAlert = true
            }
        }
        
    }
    
    
}
