//
//  JourIntent.swift
//  FestivalAppMobile
//
//  Created by m1 on 24/03/2023.
//

import Foundation

import SwiftUI

struct JoursIntent {
    
    @ObservedObject private var viewModel: JourListViewModel
    private var jourService : JourService = JourService()
    
    init(viewModel: JourListViewModel) {
        self.viewModel = viewModel
    }
    
    func getJoursByFestival(festivalId : String) async -> Bool{
        
        viewModel.state = .loading
        let result = await jourService.getJoursByFestival(festivalId: festivalId)
        switch result{
        case .success(let jourDTOs):
            viewModel.state = .joursLoaded(jourDTOs!)
            return true
        case .failure(let error as APIRequestError):
            viewModel.state = .joursLoadingFailed(error)
            return false
        default:
            viewModel.state = .error
            return false
        }
    }
}
