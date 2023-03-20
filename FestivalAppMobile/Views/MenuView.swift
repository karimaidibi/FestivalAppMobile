//
//  MenuView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct MenuView: View {
    @State private var selection: Tab = .home
    @State private var visitor : Bool

    enum Tab {
        case home
        case visiteur
        case festivals
        case creneaux
        case zones
    }
    
    init(selection: Tab, visitor : Bool) {
        self.selection = selection
        self.visitor = visitor
    }
    
    var body: some View {
        TabView(selection: $selection) {
            if (!visitor) {
                HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Accueil")
                }
                .tag(Tab.home)
            }
            //else {
            //    VisitorView(land : true)
            //    .tabItem {
            //        Image(systemName: "house.fill")
            //        Text("Accueil")
            //    }
            //    .tag(Tab.visiteur)
            //
            //}
                
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
