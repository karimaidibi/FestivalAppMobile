//
//  LandingPageView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI
struct LandingPageView: View {
    var body: some View {
        VStack(spacing: 40) {
            Text("Welcome to Festival App")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Button(action: {
                // Navigate to SigninView
            }) {
                Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Button(action: {
                // Navigate to SignupView
            }) {
                Text("Sign up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            
            Button(action: {
                // Navigate to HomeView for visitors
            }) {
                Text("Continue as a visitor")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }
}

