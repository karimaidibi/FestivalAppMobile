//
//  ContentView.swift
//  FestivalAppMobile
//
//  Created by m1 on 16/03/2023.
//


import SwiftUI
    
struct ContentView: View {
    //@State var land: Bool = true
    //@State var visitor : Bool = false
    @StateObject private var authManager = AuthManager() // pour le status visiteur
    @StateObject private var viewsManager = ViewsManager() // pour le landing
    
    init(){
        authManager.authToken = nil
        authManager.benevoleId = nil
        authManager.isAdmin = nil
    }
        
    var body: some View {
        NavigationView {
            if viewsManager.land {
                LandingPageView().environmentObject(viewsManager).environmentObject(authManager)
           } else {
               MenuView().environmentObject(authManager)
                   .environmentObject(viewsManager)
           }
       }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
