//
//  LandingPageView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct LandingPageView: View {
    @State private var isSigninViewPresented = false
    @State private var isSignupViewPresented = false
    @Binding var land: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Festival App")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.vertical, 20)
            
            Button(action: {
                isSigninViewPresented = true
            }) {
                Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .fullScreenCover(isPresented: $isSigninViewPresented) {
                SigninView(onSigninSuccess: {
                    self.land = false
                }, land: $land, isSigninViewPresented: $isSigninViewPresented)
            }
            
            Button(action: {
                // Navigate to SignupView
                isSignupViewPresented = true
            }) {
                Text("Sign up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .fullScreenCover(isPresented: $isSignupViewPresented) {
                SignupView(onSignupSuccess: {
                    self.isSignupViewPresented = false
                }, isSignupViewPresented: $isSignupViewPresented)
            }
            
            Button(action: {
                // Navigate to HomeView for visitors
                self.land = false
            }) {
                Text("Continue as a visitor")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }
}
