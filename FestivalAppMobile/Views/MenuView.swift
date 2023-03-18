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
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
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
                    Text("Mes creneaux")
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
