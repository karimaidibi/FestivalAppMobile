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
    case loggedIn(BenevoleViewModel)
    case loading
    case error(BenevoleIntentError)
    
    var description: String {
        switch self {
        case .ready:
            return "Benevole ready"
        case .loggedOut:
            return " Benevole logged out"
        case .loggedIn(let benevole):
            return "Benevole \(benevole.email) Logged in"
        case .loading:
            return "Benevole loading"
        case .error(let error):
            return "error(\(error.localizedDescription))"
        }
    }
}
