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
    
    func addFestival(nom: String, annee: Int, estCloture: Bool) async -> FestivalDTO? {
        // create data
        let festivalDTO = FestivalDTO(nom: nom, annee: annee, estCloture: estCloture)
        
        viewModel.state = .loading
        let result = await festivalService.addFestival(festivalDTO: festivalDTO)
        switch result{
        case .success(let festivalDTO):
            viewModel.state = .festivalAdded(festivalDTO!)
            return festivalDTO
        case .failure(let error as APIRequestError):
            viewModel.state = .festivalAddingFailed(error)
            return nil
        default:
            viewModel.state = .error
            return nil
        }
    }
    
    func removeFestival(id : String) async -> Bool{
        viewModel.state = .loading
        let result = await festivalService.removeFestival(id: id)
        switch result{
        case .success(let  msg):
            viewModel.state = .festivalDeleted(msg!)
            return true
        case .failure(let error as APIRequestError):
            viewModel.state = .festivalDeletingFailed(error)
            return false
        default:
            viewModel.state = .error
            return false
        }
    }
    
}
