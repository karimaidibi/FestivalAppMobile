//
//  ZoneState.swift
//  FestivalAppMobile
//
//  Created by m1 on 15/03/2023.
//

import Foundation

enum ZoneState: CustomStringConvertible, Equatable {
    // Define the different states a ZoneViewModel can be in
    case ready // The ViewModel is ready
    case loading // The ViewModel is loading
    case error // There was an error
    case zoneUpdated(ZoneDTO) // The zoneDTO was updated
    case zoneUpdatingFailed(APIRequestError) // The zoneDTO failed to update
    case zoneBenevolesInscritsComputed(Int)
    
    // Provide a description for each state
    var description: String {
        switch self {
        case .ready:
            return "ZoneViewModel: ready state"
        case .loading:
            return "ZoneViewModel: loading state"
        case .zoneUpdated(_):
            return "ZoneViewModel: zoneUpdated state"
        case .zoneUpdatingFailed(_):
            return "ZoneViewModel: zoneUpdatingFailed state"
        case .zoneBenevolesInscritsComputed(_):
            return "ZoneViewModel: zoneBenevolesComputed state"
        case .error:
            return "ZoneViewModel: error state"
        }
    }
}

