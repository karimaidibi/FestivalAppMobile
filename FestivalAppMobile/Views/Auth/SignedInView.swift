//
//  SignedInView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct SignedInView: View {
    let username: String
    @StateObject var benevoleVM : BenevoleViewModel = BenevoleViewModel()
    @EnvironmentObject var viewsManager : ViewsManager
    @EnvironmentObject var authManager : AuthManager
    @State private var navigateToHome = false
    
    var body: some View {
        
        let benevoleIntent : BenevoleIntent = BenevoleIntent(benevole: benevoleVM, authManager: authManager)
        
        VStack(spacing: 40) {
            Text("Bienvenue \(username) !")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Button(action: {
                // Implement log out functionality here
                benevoleIntent.logout()
                viewsManager.land = true
                self.navigateToHome = true
                }) {
                Text("Déconnexion")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            NavigationLink("", destination: HomeView(), isActive: $navigateToHome)
                  .hidden()
        }
        .padding()
    }
}
