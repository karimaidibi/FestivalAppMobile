//
//  FestivalIntent.swift
//  FestivalAppMobile
//
//  Created by etud on 20/03/2023.
//

import Foundation

import SwiftUI

struct FestivalsIntent {
    @ObservedObject private var viewModel: FestivalsViewModel
    private var festivalService : FestivalService = FestivalService()
    
    init(viewModel: FestivalsViewModel) {
        self.viewModel = viewModel
    }
    
    func getFestivals() async -> Bool{
        
        viewModel.state = .loading
        let result = await festivalService.getFestivals()
        switch result{
        case .success(let festivalDTOs):
            viewModel.state = .festivalsLoaded(festivalDTOs!)
            return true
        case .failure(let error as APIRequestError):
            viewModel.state = .festivalsLoadingFailed(error)
            return false
        default:
            viewModel.state = .error
            return false
        }
    }
}
