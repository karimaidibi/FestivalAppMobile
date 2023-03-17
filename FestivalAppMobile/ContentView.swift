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
        case creneaux
        case signin
        case zones
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
                    CreneauxView()
                        .tabItem {
                            Image(systemName: "timer")
                            Text("Creneaux")
                        }
                        .tag(Tab.creneaux)
                    SigninView(onSigninSuccess: {
                        // Update the `selection` variable to switch to the home screen in the `TabView`
                        self.selection = .home
                    })
                        .tabItem {
                            Image(systemName: "person")
                            Text("Connexion")
                        }
                        .tag(Tab.signin)
                    ZonesView()
                        .tabItem {
                            Image(systemName: "mappin.and.ellipse")
                            Text("Zones")
                        }
                        .tag(Tab.zones)
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
