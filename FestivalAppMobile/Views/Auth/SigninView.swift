//
//  Signin.swift
//  FestivalAppMobile
//
//  Created by m1 on 17/03/2023.
//

import Foundation
import SwiftUI

struct SigninView: View {
    @State private var email = ""
    @State private var password = ""
    @Environment(\.presentationMode) var presentationMode
    var onSigninSuccess: () -> Void
    @Binding var isSigninViewPresented: Bool
    
    @StateObject var benevoleVM : BenevoleViewModel = BenevoleViewModel()
    @EnvironmentObject var viewsManager : ViewsManager // for landing
    @EnvironmentObject var authManager : AuthManager
    
    var body: some View {
        
        let authIntent : AuthIntent = AuthIntent(benevole: benevoleVM, authManager : authManager)
        
        if benevoleVM.loading{
            ProgressView("Please wait ...")
        }else{
            
            NavigationView {
                VStack {
                    Text("Connexion")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                    
                    SecureField("Mot de passe", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    
                    Button(action : {
                        Task {
                            // Here you would implement the code to validate the user's signin credentials
                            // If the validation is successful, set `isShowingHome` to true to take the user to the home screen
                            let loggedIn : Bool = await authIntent.login(email: self.email, password: self.password)
                            if loggedIn{
                                self.onSigninSuccess()
                                //land = false
                                viewsManager.land = false
                                isSigninViewPresented = false
                            }else{
                                // pop up or something here
                                print(self.benevoleVM.authErrorMessage)
                            }
                            
                        }
                    }) {
                        Text("Se connecter")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                    
                    Button(action: {
                        // retour à la page d'avant
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Retour")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                }
            }
        }
    }
}
