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
    
    func addJour(date : String, nom : String, heure_ouverture : String, heure_fermeture : String, idFestival : String) async -> Bool {
        // create data
        let jourDTO = JourDTO(date : date, nom: nom , heure_ouverture : heure_ouverture, heure_fermeture : heure_fermeture, idFestival: idFestival)
        
        viewModel.state = .loading
        let result = await jourService.addJour(jourDTO: jourDTO)
        switch result{
        case .success(let jourDTO):
            viewModel.state = .jourAdded(jourDTO!)
            return true
        case .failure(let error as APIRequestError):
            viewModel.state = .jourAddingFailed(error)
            return false
        default:
            viewModel.state = .error
            return false
        }
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
    
    func removeJour(id : String) async -> Bool{
        viewModel.state = .loading
        let result = await jourService.removeJour(id: id)
        switch result{
        case .success(let  msg):
            viewModel.state = .jourDeleted(msg!)
            return true
        case .failure(let error as APIRequestError):
            viewModel.state = .jourDeletingFailed(error)
            return false
        default:
            viewModel.state = .error
            return false
        }
    }
}
