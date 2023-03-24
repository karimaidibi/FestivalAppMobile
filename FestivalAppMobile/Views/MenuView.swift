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

    enum Tab {
        case compte
        case visiteur
        case festivals
        case creneaux
        case gestion
    }
    
    
    var body: some View {
        TabView() {
            FestivalsView(festivals: fakeFestivals)
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Festivals")
                }
                .tag(Tab.festivals)
            if (authManager.benevoleId != nil) {
                CreneauxView()
                    .tabItem {
                        Image(systemName: "timer")
                        Text("Mes créneaux")
                    }
                    .tag(Tab.creneaux)
            }
            if (authManager.isAdmin == true) {
                BenevoleListView(viewModel: BVMS)
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
    }
}
