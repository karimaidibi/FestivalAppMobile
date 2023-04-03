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
    case loggedIn(BenevoleDTO)
    case loading
    case authFailed(AuthError)
    case emptyFields
    case emailNotValid
    case tooShortPassword
    case signedUp(String)
    case affectationsLoadedSuccess([AffectationDocDTO])
    case affectationsLoadingFailure(APIRequestError)
    case affectationDeletedSuccess(String)
    case loadingAffectations
    case benevoleLoadedSuccess(BenevoleDTO)
    case benevoleLoadingFailure(APIRequestError)
    case affectationAddedSuccess(String)
    case affectationAddingFailure(APIRequestError)
    case error
    
    var description: String {
        switch self {
        case .ready:
            return "Benevole ready"
        case .loggedOut:
            return " Benevole logged out"
        case .loggedIn(let email):
            return "Benevole \(email) Logged in"
        case .loading:
            return "Benevole loading..."
        case .tooShortPassword:
            return "Password must be at least 5 characters !"
        case .emailNotValid:
            return "Please verify your email format and try again !"
        case .emptyFields:
            return "Fields Must Not Be Empty !"
        case .authFailed(let error):
            return "Error : \(error.localizedDescription)"
        case .signedUp(let message):
            return message
        case .affectationsLoadedSuccess:
            return "Affectations Loaded Success"
        case .affectationsLoadingFailure(let error):
            return "\(error.description)"
        case .loadingAffectations:
            return "Loading Benevole Affectations..."
        case .affectationDeletedSuccess(let msg):
            return msg
        case .benevoleLoadedSuccess(_):
            return "Benevole loaded success"
        case .benevoleLoadingFailure(let error):
            return error.description
        case .affectationAddedSuccess:
            return "Affectation Added Success"
        case .affectationAddingFailure(let error):
            return "\(error.description)"
        case .error:
            return "error"
        }
    }
}
