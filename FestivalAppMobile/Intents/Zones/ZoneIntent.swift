//
//  ZoneIntent.swift
//  FestivalAppMobile
//
//  Created by m1 on 15/03/2023.
//

import Foundation
import SwiftUI

struct ZoneIntent{
    @ObservedObject private var viewModel : ZoneViewModel
    private var zoneService : ZoneService = ZoneService()
    
    init(viewModel : ZoneViewModel){
        self.viewModel = viewModel
    }
        
    func updateZone(id : String, editedProperty : Any, editing : String) async -> Bool{
        let zoneDTO : ZoneDTO = ZoneDTO(zoneVM: viewModel)
        // what are we editing ?
        switch editing{
            case "nom":
                zoneDTO.nom = editedProperty as! String
            case "nombre_benevoles_necessaires":
                zoneDTO.nombre_benevoles_necessaires = editedProperty as! Int
            case "idFestival":
                zoneDTO.idFestival = editedProperty as! String
            default:
                return false
        }
        
        viewModel.state = .loading
        let result = await zoneService.updateZone(id: id, zoneDTO: zoneDTO)
        switch result{
        case .success(_):
            viewModel.state = .zoneUpdated(zoneDTO)
            return true
        case .failure(let error as APIRequestError):
            viewModel.state = .zoneUpdatingFailed(error)
            return false
        default:
            viewModel.state = .error
            viewModel.state = .ready
            return false
        }
    }
}
