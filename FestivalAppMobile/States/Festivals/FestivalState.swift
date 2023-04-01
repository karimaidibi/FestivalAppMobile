//
//  FestivalState.swift
//  FestivalAppMobile
//
//  Created by etud on 20/03/2023.
//

import Foundation

enum FestivalState: CustomStringConvertible, Equatable {
    case ready
    case loading
    case festivalUpdated(FestivalDTO)
    case festivalUpdatingFailed(APIRequestError)
    case benevolesDocUpdated
    case error
    
    var description: String {
        switch self {
        case .ready:
            return "FestivalViewModel: ready state"
        case .loading:
            return "FestivalViewModel: loading state"
        case .festivalUpdated(_):
            return "FestivalViewModel: festivalUpdated state"
        case .festivalUpdatingFailed(_):
            return "FestivalViewModel: festivalUpdatingFailed state"
        case .benevolesDocUpdated:
            return "FestivalViewModel: benevolesDocUpdated state"
        case .error:
            return "FestivalViewModel: error state"
        }
    }
}
