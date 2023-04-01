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
    case benevolesDocLoaded([BenevoleDocDTO])
    case processingAffectations
    case processingAffectationsSuccess(String)
    case processingAffectationsFailure(APIRequestError)
    case error
    
    var description: String {
        switch self {
        case .ready:
            return "ready"
        case .loading:
            return "loading"
        case .processingAffectations:
            return "Processing affectations..."
        case .processingAffectationsSuccess(let msg):
            return msg
        case .processingAffectationsFailure(let error):
            return error.description
        case .benevolesLoaded:
            return "Benevoles Loaded Successfully"
        case .benevolesLoadingFailed(let apiRequestError):
            return apiRequestError.localizedDescription
        case .benevolesDocLoaded:
            return "Benevoles Loaded Successfully"
        case .error:
            return "error"
        }
    }
}
