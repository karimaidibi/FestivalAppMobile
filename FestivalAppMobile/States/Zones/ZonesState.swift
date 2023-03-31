//
//  ZonesState.swift
//  FestivalAppMobile
//
//  Created by etud on 30/03/2023.
//

import Foundation

enum ZonesState: CustomStringConvertible, Equatable {    
    case ready
    case loading
    case zonesLoaded([ZoneDTO])
    case zonesLoadingFailed(APIRequestError)
    case zoneAdded(String)
    case zoneAddingFailed(APIRequestError)
    case zoneDeleted(String)
    case zoneDeletingFailed(APIRequestError)
    case error
    
    var description: String {
        switch self {
        case .ready:
            return "ready"
        case .loading:
            return "loading"
        case .zonesLoaded:
            return "Zones Loaded Successfully"
        case .zonesLoadingFailed(let apiRequestError):
            return apiRequestError.localizedDescription
        case .zoneAdded(let msg):
            return msg
        case .zoneAddingFailed(let error):
            return error.localizedDescription
        case .zoneDeleted(let msg):
            return msg
        case .zoneDeletingFailed(let error):
            return error.localizedDescription
        case .error:
            return "error"
        }
    }
}
