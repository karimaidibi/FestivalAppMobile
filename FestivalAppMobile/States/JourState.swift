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
    case jourLoaded
    case jourLoadingFailed
    case error
    
    var description: String {
        switch self {
        case .ready:
            return "ready"
        case .loading:
            return "loading"
        case .jourLoaded:
            return "Festivals Loaded Successfully"
        case .jourLoadingFailed:
            return "error"
        case .error:
            return "error"
        }
    }
}
