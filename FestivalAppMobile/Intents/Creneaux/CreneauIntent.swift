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

    func getBenevolesDocInCreneau(benevolesDocVM: [BenevoleViewModel]) -> [BenevoleViewModel]{
        // given the array in parameters, create a new one filtered with only the
        // BenevoleViewModel objects that have an _id of idCreneau equal to self.viewModel._id
        // in their idCreneau object in their affectationDocuments array
        let creneauId = self.viewModel._id

        let filteredBenevoles : [BenevoleViewModel] = benevolesDocVM.filter { benevoleVM in
            benevoleVM.affectationDocuments.contains { affectationDoc in
                affectationDoc.idCreneau._id  == creneauId
            }
        }

        return filteredBenevoles
    }
}
