//
//  CreneauxState.swift
//  FestivalAppMobile
//
//  Created by m1 on 30/03/2023.
//

import Foundation

enum CreneauState: CustomStringConvertible, Equatable {
    case ready
    case loading
    case nbreBeneveolesMaxCalculated(Int)
    case error
    
    var description: String {
        switch self {
        case .ready:
            return "CreneauViewModel: ready state"
        case .nbreBeneveolesMaxCalculated(_):
            return "CreneauViewModel : benevolesMax calulcated state"
        case .loading:
            return "CreneauViewModel: loading state"
        case .error:
            return "CreneauViewModel: error state"
        }
    }
}
