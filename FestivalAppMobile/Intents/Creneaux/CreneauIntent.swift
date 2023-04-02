//
//  CreneauIntent.swift
//  FestivalAppMobile
//
//  Created by m1 on 01/04/2023.
//

import Foundation
import SwiftUI

struct CreneauIntent{
    @ObservedObject private var viewModel : CreneauViewModel
    
    init(viewModel : CreneauViewModel){
        self.viewModel = viewModel
    }

    func getNbreInscriptionsInCreneau(benevolesDocVM: BenevoleListViewModel) async -> Int{
        let creneauId = self.viewModel._id

        let filteredBenevoles : [BenevoleViewModel] = benevolesDocVM.benevoleViewModels.filter { benevoleVM in
            benevoleVM.affectationDocuments.contains { affectationDoc in
                affectationDoc.idCreneau._id  == creneauId
            }
        }
        
        var count : Int = 0
        for benevoleVM in filteredBenevoles{
            for affectationDoc in benevoleVM.affectationDocuments{
                if affectationDoc.idCreneau._id == creneauId {
                    count += 1
                }
            }
        }

        return count
    }
    
    func getNbreBenevolesMax(zonesVM : ZoneListViewModel) -> Int{
        
        viewModel.state = .loading
        let nbreMax : Int = zonesVM.zoneViewModelArray.reduce(0) { sum, zone in
            sum + zone.nombre_benevoles_necessaires
        }
        viewModel.state = .nbreBeneveolesMaxCalculated(nbreMax)
        return nbreMax
    }
}
