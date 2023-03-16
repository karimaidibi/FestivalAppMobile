//
//  ContentView.swift
//  FestivalAppMobile
//
//  Created by m1 on 16/03/2023.
//


import SwiftUI

struct ContentView: View {
    
    @State private var selection: Tab = .home

    enum Tab {
        case home
        case festivals
        case benevoles
        case zones
        case creneaux
    }
    
    var body: some View {
        
        TabView(selection: $selection) {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                        .tag(Tab.home)
                    FestivalsView()
                        .tabItem {
                            Image(systemName: "info.circle")
                            Text("Festivals")
                        }
                        .tag(Tab.festivals)
                    BenevolesView()
                        .tabItem {
                            Image(systemName: "person")
                            Text("Bénévoles")
                        }
                        .tag(Tab.benevoles)
                    ZonesView()
                        .tabItem {
                            Image(systemName: "mappin.and.ellipse")
                            Text("Zones")
                        }
                        .tag(Tab.zones)
                    CreneauxView()
                        .tabItem {
                            Image(systemName: "timer")
                            Text("Creneaux")
                        }
                        .tag(Tab.creneaux)
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
