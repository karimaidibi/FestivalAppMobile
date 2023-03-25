//
//  JoursState.swift
//  FestivalAppMobile
//
//  Created by m1 on 25/03/2023.
//

import Foundation

enum JoursState: CustomStringConvertible, Equatable {
    case ready
    case loading
    case joursLoaded([JourDTO])
    case joursLoadingFailed(APIRequestError)
    case error
    
    var description: String {
        switch self {
        case .ready:
            return "ready"
        case .loading:
            return "loading"
        case .joursLoaded:
            return "Festivals Loaded Successfully"
        case .joursLoadingFailed(let apiRequestError):
            return apiRequestError.localizedDescription
        case .error:
            return "error"
        }
    }
}
