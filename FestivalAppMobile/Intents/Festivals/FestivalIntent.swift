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
    
    func updateFestival(id : String, editedProperty : Any, editing : String) async -> Bool {
        let festivalDTO : FestivalDTO = FestivalDTO(festivalVM: viewModel)

        // what are we editing?
        switch editing {
        case "nom":
            let nom = editedProperty as! String
            if nom.isEmpty {
                viewModel.state = .festivalUpdatingFailed(.CustomError("Nom cannot be empty"))
                return false
            }
            festivalDTO.nom = nom
        case "annee":
            let anneeString = editedProperty as! String
            guard let annee = Int(anneeString), "\(annee)".count == 4, annee >= 2023 else {
                viewModel.state = .festivalUpdatingFailed(.CustomError("Anne must be a 4-digit number and >= 2023"))
                return false
            }
            festivalDTO.annee = annee
        case "estCloture":
            festivalDTO.estCloture = editedProperty as! Bool
        default:
            return false
        }
        
        viewModel.state = .loading
        let result = await festivalService.updateFestival(id: id, festivalDTO: festivalDTO)
        switch result {
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

    
    func getNbreBenevolesDocInFestival(benevolesDocVM: BenevoleListViewModel) -> Int{
        // given the array in parameters, create a new one filtered with only the
        // BenevoleViewModel objects that have an _id of idFestival equal to self.viewModel._id
        // in their idZone.idFestival object in their affectationDocuments array
        let festivalId = self.viewModel._id

        let filteredBenevoles : [BenevoleViewModel] = benevolesDocVM.benevoleViewModels.filter { benevoleVM in
            benevoleVM.affectationDocuments.contains { affectationDoc in
                affectationDoc.idZone.idFestival?._id ?? "" == festivalId
            }
        }
        viewModel.state = .benevolesDocUpdated
        return filteredBenevoles.count
    }

}
