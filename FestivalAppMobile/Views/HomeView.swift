//
//  HomeView.swift
//  FestivalAppMobile
//
//  Created by etud on 16/03/2023.
//

import Foundation

import SwiftUI
struct HomeView: View {
    @State private var isShowingSignup = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Bienvenue dans Festival App!")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
                .background(
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [.orange, .yellow]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    }
                )
            
            Spacer()
            
            SigninView(onSigninSuccess: {})
                .padding(.bottom, 20)
            
            Button(action: {
                // Set the `isShowingSignup` variable to true to display the `SignupView`
                self.isShowingSignup = true
            }) {
                Text("Pas encore de compte? Inscrivez vous!")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            .sheet(isPresented: $isShowingSignup) {
                SignupView(onSignupSuccess: {
                    // If the signup is successful, dismiss the `SignupView` and show a success message to the user
                    self.isShowingSignup = false
                    // Show a success message to the user using an alert or a toast
                })
            }
        }
    }
}
