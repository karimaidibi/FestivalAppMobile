//
//  BenevoleListState.swift
//  FestivalAppMobile
//
//  Created by m1 on 31/03/2023.
//

import Foundation

enum BenevoleListState: CustomStringConvertible, Equatable {
    case ready
    case loading
    case benevolesLoaded([BenevoleDTO])
    case benevolesLoadingFailed(APIRequestError)
    case error
    
    var description: String {
        switch self {
        case .ready:
            return "ready"
        case .loading:
            return "loading"
        case .benevolesLoaded:
            return "Benevoles Loaded Successfully"
        case .benevolesLoadingFailed(let apiRequestError):
            return apiRequestError.localizedDescription
        case .error:
            return "error"
        }
    }
}
