//
//  HomeView.swift
//  FestivalAppMobile
//
//  Created by etud on 16/03/2023.
//

import Foundation

import SwiftUI
struct HomeView: View {
    
    @EnvironmentObject var viewsManager : ViewsManager
    @EnvironmentObject var authManager : AuthManager
    
    var body: some View {
        VStack {
            NavigationView{
                // if signed in
                if let _ =  authManager.benevoleId{
                    SignedInView().environmentObject(viewsManager).environmentObject(authManager)
                }else{
                    // if visitor
                    VisitorView().environmentObject(viewsManager)
                }
            }
        }
    }
}
