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
        case home
        case visiteur
        case festivals
        case creneaux
        case zones
    }
    
    
    var body: some View {
        TabView() {

            HomeView().environmentObject(viewsManager).environmentObject(authManager)
            .tabItem {
                Image(systemName: "house.fill")
                Text("Accueil")
            }
            .tag(Tab.home)
                
            FestivalsView(festivals: fakeFestivals)
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Festivals")
                }
                .tag(Tab.festivals)
            CreneauxView()
                .tabItem {
                    Image(systemName: "timer")
                    Text("Mes créneaux")
                }
                .tag(Tab.creneaux)
            ZonesView()
                .tabItem {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Zones")
                }
                .tag(Tab.zones)
        }
    }
}
