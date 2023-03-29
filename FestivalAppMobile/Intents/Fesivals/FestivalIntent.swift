//
//  FestivalIntent.swift
//  FestivalAppMobile
//
//  Created by m1 on 25/03/2023.
//

import Foundation
import SwiftUI

struct FestivalIntent {
    @ObservedObject private var viewModel: FestivalViewModel
    private var festivalService : FestivalService = FestivalService()
    
    init(viewModel: FestivalViewModel) {
        self.viewModel = viewModel
    }
    
    func updateFestival(id : String, editedProperty : Any, editing : String) async -> Bool{
        let festivalDTO : FestivalDTO = FestivalDTO(festivalVM: viewModel)
        // what are we editing ?
        switch editing{
            case "nom":
                festivalDTO.nom = editedProperty as! String
        	case "annee":
            	festivalDTO.annee = editedProperty as! Int
            case "estCloture":
            	festivalDTO.estCloture = editedProperty as! Bool
            default:
                return false
        }
        
        viewModel.state = .loading
        let result = await festivalService.updateFestival(id: id, festivalDTO: festivalDTO)
        switch result{
        case .success(_):
            viewModel.state = .festivalUpdated(festivalDTO)
            return true
        case .failure(let error as APIRequestError):
            viewModel.state = .festivalUpdatingFailed(error)
            return false
        default:
            viewModel.state = .error
            viewModel.state = .ready
            return false
        }
    }
}
