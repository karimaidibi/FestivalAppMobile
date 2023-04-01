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
    
    @StateObject var authManager : AuthManager = AuthManager()
    
    // for popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""

    var body: some View{
        
        let creneauListIntent : CreneauListIntent = CreneauListIntent(viewModel: creneauxVM)
        
        Section(header: Text("Creneaux du jour")) {
            if creneauxVM.loading{
                ProgressView("Loading Creneaux...")
            }else{
                if let _ = authManager.benevoleId{
                    ForEach(creneauxVM) { creneauVM in
                        NavigationLink(destination: SubscribeZoneListView(benevolesVM : benevolesVM,creneauVM : creneauVM, zonesVM: zonesVM)) {
                            CreneauRowView(creneauVM: creneauVM, benevolesVM : benevolesVM, zonesVM : zonesVM)
                            Divider() // comme sur angular mat
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }else{
                    ForEach(creneauxVM) { creneauVM in
                            CreneauRowView(creneauVM: creneauVM, benevolesVM : benevolesVM, zonesVM : zonesVM)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
            }
        }
        .task {
            let creneauxLoaded = await creneauListIntent.getCreneauxByJour(jourId: jourVM._id)
            if !creneauxLoaded{
                // afficher erreur popup
                //alertMessage = creneauxVM.errorMessage
                //alertTitle = "Error"
                //showAlert = true
            }
        }
        
    }
    
    
}
