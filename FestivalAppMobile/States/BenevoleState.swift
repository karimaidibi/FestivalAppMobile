//
//  BenevoleState.swift
//  FestivalAppMobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation
import SwiftUI

enum BenevoleState: CustomStringConvertible, Equatable {
    case ready
    case loggedOut
    case loggedIn(String)
    case loading
    case logInFailed(LoginError)
    case emailNotValid
    case tooShortPassword
    case error(BenevoleIntentError)
    
    var description: String {
        switch self {
        case .ready:
            return "Benevole ready"
        case .loggedOut:
            return " Benevole logged out"
        case .loggedIn(let email):
            return "Benevole \(email) Logged in"
        case .loading:
            return "Benevole loading"
        case .tooShortPassword:
            return "Password must be at least 5 characters !"
        case .emailNotValid:
            return "Please verify your email format and try again !"
        case .logInFailed(let error):
            return "Error : \(error)"
        case .error(let error):
            return "error(\(error.localizedDescription))"
        }
    }
}
