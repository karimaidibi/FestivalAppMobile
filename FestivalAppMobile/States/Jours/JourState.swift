//
//  JourState.swift
//  FestivalAppMobile
//
//  Created by m1 on 27/03/2023.
//

import Foundation

enum JourState: CustomStringConvertible, Equatable {
    case ready
    case loading
    case jourUpdated(JourDTO)
    case jourUpdatingFailed(APIRequestError)
    case error
    
    var description: String {
        switch self {
        case .ready:
            return "ready"
        case .loading:
            return "loading"
        case .jourUpdated(_):
            return "Jour Loaded Successfully"
        case .jourUpdatingFailed(_):
            return "error"
        case .error:
            return "error"
        }
    }
}
