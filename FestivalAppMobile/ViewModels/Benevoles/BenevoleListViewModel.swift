//
//  BenevoleListViewModel.swift
//  FestivalAppMobile
//
//  Created by etud on 24/03/2023.
//

import Foundation

class BenevoleListViewModel: ObservableObject, ViewModelObserver {
    @Published var benevoleViewModels: [BenevoleViewModel] = []
    @Published var searchText: String = ""

    // constructor
    init(benevoleViewModels : [BenevoleViewModel]){
        self.benevoleViewModels = benevoleViewModels
        // register as a observer of all the track model views in the array
        for tmv in benevoleViewModels{
            tmv.register(obs: self)
        }
    }
    
    init(benevoles: [BenevoleDTO]) {
        self.benevoleViewModels = BenevoleDTO.convertBenevoleDTOsToDisplay(benevolesDTOs: benevoles)
    }
    
    func viewModelUpdated() {
        self.objectWillChange.send()
    }

    func filterBenevoles() -> [BenevoleViewModel] {
        if searchText.isEmpty {
            return benevoleViewModels
        } else {
            return benevoleViewModels.filter { benevole in
                benevole.nom.lowercased().contains(searchText.lowercased()) ||
                benevole.prenom.lowercased().contains(searchText.lowercased()) ||
                benevole.email.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
