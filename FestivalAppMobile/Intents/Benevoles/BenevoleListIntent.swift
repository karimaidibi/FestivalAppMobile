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
    
    func addAffectationOfBenevoles(benevoleIds: [String], idZone: String, idCreneau: String) async -> Bool {
        viewModel.state = .processingAffectations
        let affectationDTO: AffectationDTO = AffectationDTO(idZone: idZone, idCreneau: idCreneau)
        var allSucceeded = true
        for benevoleId in benevoleIds {
            let result = await benevoleService.addAffectation(benevoleId: benevoleId, affectationDTO: affectationDTO)
            switch result {
            // en cas de success on fait rien (allSucceeded est à true par défaut)
            case .success(let msg):
                viewModel.state = .processingAffectationsSuccess(msg)
            case .failure(let error as APIRequestError):
                viewModel.state = .processingAffectationsFailure(error)
                allSucceeded = false
            default:
                // cas ou il n'y a pas eu d'erreur
                viewModel.state = .error
                allSucceeded = false
            }
        }
        return allSucceeded
    }
    
    func benevoleIds(benevoleVMs: [BenevoleViewModel]) -> [String] {
        return benevoleVMs.map { benevoleVM in
            return benevoleVM._id
        }
    }
    
    func getBenevolesNested() async -> Bool{
        
        viewModel.state = .loading
        let result = await benevoleService.getBenevolesNested()
        switch result{
        case .success(let benevoleDocDTOs):
            viewModel.state = .benevolesDocLoaded(benevoleDocDTOs!)
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
