//
//  FestivalState.swift
//  FestivalAppMobile
//
//  Created by etud on 20/03/2023.
//

import Foundation

enum FestivalState: CustomStringConvertible, Equatable {
    case ready
    case error(FestivalIntentError)
    
    var description: String {
        switch self {
        case .ready:
            return "ready"
        case .error(let error):
            return "error(\(error.localizedDescription))"
        }
    }
}
