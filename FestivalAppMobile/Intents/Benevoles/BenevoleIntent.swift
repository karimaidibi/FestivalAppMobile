//
//  BenevoleIntent.swift
//  FestivalAppMobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation
import SwiftUI

struct BenevoleIntent{
    @ObservedObject private var model : BenevoleViewModel
    private var benevoleService : BenevoleService = BenevoleService()
    
    init(benevole : BenevoleViewModel){
        self.model = benevole
    }
    
    func getBenevoleAffectation(id : String) async -> Bool{
        model.state = .loadingAffectations
        let result = await benevoleService.getBenevoleAffectations(id: id)
        switch result{
            case .success(let affectations):
            	model.state = .affectationsLoadedSuccess(affectations!)
            	return true
        	case .failure(let error as APIRequestError):
            	model.state = .affectationsLoadingFailure(error)
            	return false
            default:
            	model.state = .error
                debugPrint("state description :  \(model.state.description)")
            return false
        }
    }
    
    func removeAffectation(id : String, idZone : String, idCreneau : String) async -> Bool{
        model.state = .loadingAffectations
        let affectationDTO : AffectationDTO = AffectationDTO(idZone: idZone, idCreneau: idCreneau)
        let result = await benevoleService.removeAffectation(id: id, affectation: affectationDTO)
        switch result{
            case .success(let msg):
                model.state =  .affectationDeletedSuccess(msg!)
                return true
            case .failure(let error as APIRequestError):
                model.state = .affectationsLoadingFailure(error)
                return false
            default:
                model.state = .error
            	return false
        }
    }
    

}
