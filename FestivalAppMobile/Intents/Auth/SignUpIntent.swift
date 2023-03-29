//
//  SignUpIntent.swift
//  FestivalAppMobile
//
//  Created by m1 on 24/03/2023.
//

import Foundation
import SwiftUI

struct SignUpIntent{
    @ObservedObject private var model : BenevoleViewModel
    private var signUpService : SignUpService

    init(benevole : BenevoleViewModel){
        self.model = benevole
        self.signUpService = SignUpService()
    }
    
    // signup and change the state of the model to signedUp
    func signUp(email : String, password: String) async -> Bool{
        // set email to lower case :
        
        let lowercasedEmail = email.lowercased()
        
        // Verify the email
         if !validateEmail(lowercasedEmail) {
             // If email is not valid, change the state to emailNotValid
             model.state = .emailNotValid
             return false
         }
         
         // Verify the password
         if password.count < 4 { // Assuming the minimum password length is 8 characters
             // If password is short, change the state to tooShortPassword
             model.state = .tooShortPassword
             return false
         }
        
        // if ok send loggin and change the state to loading
        model.state = .loading
        let result = await self.signUpService.signup(email: lowercasedEmail, password: password)
        switch result {
            case .success(let msg) :
                model.state = .signedUp(msg!)
                return true
            case .failure(let error as AuthError):
                model.state = .authFailed(error)
                return false
        	default:
            	model.state = .error
                return false
        }
    }
    
    // Validate email function
    private func validateEmail(_ email: String) -> Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return emailPredicate.evaluate(with: email)
    }
}
