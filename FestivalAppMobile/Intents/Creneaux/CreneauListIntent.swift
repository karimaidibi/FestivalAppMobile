//
//  CreneauxIntent.swift
//  FestivalAppMobile
//
//  Created by m1 on 30/03/2023.
//

import Foundation
import SwiftUI

struct CreneauListIntent {
    
    @ObservedObject private var viewModel: CreneauListViewModel
    private var creneauService : CreneauService = CreneauService()
    
    init(viewModel: CreneauListViewModel) {
        self.viewModel = viewModel
    }
    
    func getCreneauxByJour(jourId : String) async -> Bool{
        
        viewModel.state = .loading
        let result = await creneauService.getCreneauxByJour(jourId: jourId)
        switch result{
        case .success(let creneauDTOs):
            viewModel.state = .creneauxLoaded(creneauDTOs!)
            return true
        case .failure(let error as APIRequestError):
            viewModel.state = .creneauxLoadingFailed(error)
            return false
        default:
            viewModel.state = .error
            return false
        }
    }
}
