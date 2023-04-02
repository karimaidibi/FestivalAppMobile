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
    case jourAdded(JourDTO)
    case jourAddingFailed(APIRequestError)
    case jourDeleted(String)
    case jourDeletingFailed(APIRequestError)
    case error
    
    var description: String {
        switch self {
        case .ready:
            return "ready"
        case .loading:
            return "loading"
        case .joursLoaded:
            return "Jours Loaded Successfully"
        case .joursLoadingFailed(let apiRequestError):
            return apiRequestError.description
        case .jourAdded:
            return "success"
        case .jourAddingFailed(let error):
            return error.description
        case .jourDeleted(let msg):
            return msg
        case .jourDeletingFailed(let error):
            return error.description
        case .error:
            return "error"
        }
    }
}
