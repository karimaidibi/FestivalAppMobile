//
//  JourIntent.swift
//  FestivalAppMobile
//
//  Created by etud on 31/03/2023.
//

import Foundation
import SwiftUI

struct JourIntent{
    @ObservedObject private var viewModel : JourViewModel
    private var jourService : JourService = JourService()
    
    init(viewModel : JourViewModel){
        self.viewModel = viewModel
    }
        
    func updateJour(id : String, editedProperty : Any, editing : String) async -> Bool{
        let jourDTO : JourDTO = JourDTO(jourVM: viewModel)
        // what are we editing ?
        switch editing{
        case "date":
            jourDTO.date = editedProperty as! String
        case "nom":
            jourDTO.nom = editedProperty as! String
        case "heure_ouverture":
            jourDTO.heure_ouverture = editedProperty as! String
        case "heure_fermeture":
            jourDTO.heure_fermeture = editedProperty as! String
        case "idFestival":
            jourDTO.idFestival = editedProperty as! String
        default:
            return false
        }
        
        viewModel.state = .loading
        let result = await jourService.updateJour(id: id, jourDTO: jourDTO)
        switch result{
        case .success(_):
            viewModel.state = .jourUpdated(jourDTO)
            return true
        case .failure(let error as APIRequestError):
            viewModel.state = .jourUpdatingFailed(error)
            return false
        default:
            viewModel.state = .error
            viewModel.state = .ready
            return false
        }
    }
}
