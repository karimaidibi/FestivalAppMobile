//
//  MenuView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct MenuView: View {
    //@State private var selection: Tab = .home
    //@State private var visitor : Bool
    @EnvironmentObject var authManager : AuthManager
    @EnvironmentObject var viewsManager : ViewsManager
    @StateObject var benevoleVM : BenevoleViewModel = BenevoleViewModel()

    enum Tab {
        case compte
        case visiteur
        case festivals
        case creneaux
        case gestion
    }
    
    
    var body: some View {
        
        let benevoleIntent : BenevoleIntent = BenevoleIntent(benevole: benevoleVM)
        
        TabView() {
            FestivalListView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Festivals")
                }
                .tag(Tab.festivals)
            if (authManager.benevoleId != nil) {
                AffectationsView(benevoleVM: benevoleVM, isAdminGestion: false)
                    .tabItem {
                        Image(systemName: "timer")
                        Text("Mes créneaux")
                    }
                    .tag(Tab.creneaux)
            }
            if (authManager.isAdmin == true) {
                BenevoleListView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Gestion")
                    }
                    .tag(Tab.gestion)
            }
            HomeView().environmentObject(viewsManager).environmentObject(authManager)
            .tabItem {
                Image(systemName: "person")
                Text("Compte")
            }
            .tag(Tab.compte)
        }
        .onAppear(perform: {
            Task {
                if let benevoleId = authManager.benevoleId{
                    let _ = await benevoleIntent.getBenevoleById(benevoleId: benevoleId)
                }
            }
        })
    }
}

