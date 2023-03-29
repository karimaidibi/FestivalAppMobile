//
//  FestivalListState.swift
//  FestivalAppMobile
//
//  Created by m1 on 25/03/2023.
//

import Foundation

enum FestivalsState: CustomStringConvertible, Equatable {
    case ready
    case loading
    case festivalsLoaded([FestivalDTO])
    case festivalsLoadingFailed(APIRequestError)
    case festivalAdded(FestivalDTO)
    case festivalAddingFailed(APIRequestError)
    case festivalDeleted(String)
    case festivalDeletingFailed(APIRequestError)
    case error
    
    var description: String {
        switch self {
        case .ready:
            return "ready"
        case .loading:
            return "loading"
        case .festivalsLoaded:
            return "Festivals Loaded Successfully"
        case .festivalsLoadingFailed(let apiRequestError):
            return apiRequestError.localizedDescription
        case .festivalAdded:
            return "success"
        case .festivalAddingFailed(let error):
            return error.localizedDescription
        case .festivalDeleted(let msg):
            return msg
        case .festivalDeletingFailed(let error):
            return error.localizedDescription
        case .error:
            return "error"
        }
    }
}
