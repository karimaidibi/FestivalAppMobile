//
//  SignedInView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct SignedInView: View {
    @StateObject var benevoleVM : BenevoleViewModel = BenevoleViewModel()
    @EnvironmentObject var viewsManager : ViewsManager
    @EnvironmentObject var authManager : AuthManager
    @State private var navigateToHome = false
    
    var body: some View {
        
        let authIntent : AuthIntent = AuthIntent(benevole: benevoleVM, authManager: authManager)
        
        VStack(spacing: 40) {
            Text("Bienvenue \(benevoleVM.prenom) \(benevoleVM.nom) !")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Button(action: {
                // Implement log out functionality here
                authIntent.logout()
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
