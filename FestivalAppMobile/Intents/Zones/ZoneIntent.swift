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
        
    func updateZone(id : String, nom: String, nbre_ben_necessaires : Int) async -> Bool{
        let zoneDTO : ZoneDTO = ZoneDTO(zoneVM: viewModel)
        // what are we editing ?
        guard !nom.isEmpty else{
            viewModel.state = .zoneUpdatingFailed(.CustomError("Nom must not be empty !"))
            return false
        }
        zoneDTO.nom = nom
        
        guard nbre_ben_necessaires >= 0 else {
            viewModel.state = .zoneUpdatingFailed(.CustomError("nombres de bénévoles must not be negative"))
            return false
        }
        zoneDTO.nombre_benevoles_necessaires = nbre_ben_necessaires
 
        
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
    
    func getNbreBenevolesInZone(creneauId : String, benevolesDocVM : BenevoleListViewModel) -> Int{
        viewModel.state = .loading
        let zoneId = viewModel._id

        let filteredBenevoles : [BenevoleViewModel] = benevolesDocVM.benevoleViewModels.filter { benevoleVM in
            benevoleVM.affectationDocuments.contains { affectationDoc in
                (affectationDoc.idCreneau._id  == creneauId)
                &&
                (affectationDoc.idZone._id == zoneId)
            }
        }
        viewModel.state = .zoneBenevolesInscritsComputed(filteredBenevoles.count)

        return filteredBenevoles.count
    }
}
