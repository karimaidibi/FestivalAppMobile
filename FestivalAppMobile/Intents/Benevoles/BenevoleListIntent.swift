//
//  BenevoleListIntent.swift
//  FestivalAppMobile
//
//  Created by m1 on 31/03/2023.
//

import Foundation

import SwiftUI

struct BenevolesIntent {
    @ObservedObject private var viewModel: BenevoleListViewModel
    private var benevoleService : BenevoleService = BenevoleService()
    
    init(viewModel: BenevoleListViewModel) {
        self.viewModel = viewModel
    }
    
    func getBenevoles() async -> Bool{
        
        viewModel.state = .loading
        let result = await benevoleService.getBenevoles()
        switch result{
        case .success(let benevoleDTOs):
            viewModel.state = .benevolesLoaded(benevoleDTOs!)
            return true
        case .failure(let error as APIRequestError):
            viewModel.state = .benevolesLoadingFailed(error)
            return false
        default:
            viewModel.state = .error
            return false
        }
        
    }
    
}
