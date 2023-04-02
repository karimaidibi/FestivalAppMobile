//
//  CreneauxState.swift
//  FestivalAppMobile
//
//  Created by m1 on 30/03/2023.
//

import Foundation

enum CreneauListState: CustomStringConvertible, Equatable {
    case ready
    case loading
    case creneauxLoaded([CreneauDTO])
    case creneauxLoadingFailed(APIRequestError)
    case error
    
    var description: String {
        switch self {
        case .ready:
            return "CreneauListViewModel: ready state"
        case .loading:
            return "CreneauListViewModel: loading state"
        case .creneauxLoaded:
            return "CreneauListViewModel: loaded state"
        case .creneauxLoadingFailed(let apiRequestError):
            return "CreneauListViewModel: loading failed state -  \(apiRequestError.description)"
        case .error:
            return "CreneauListViewModelViewModel: error state"
        }
    }
}
