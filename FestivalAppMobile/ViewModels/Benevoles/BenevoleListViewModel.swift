//
//  BenevoleListViewModel.swift
//  FestivalAppMobile
//
//  Created by etud on 24/03/2023.
//

import Foundation

class BenevoleListViewModel: ObservableObject, ViewModelObserver, RandomAccessCollection, IteratorProtocol {
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

    func filteredBenevoles(searchText: String) -> [BenevoleViewModel] {
        let filteredBenevoles = benevoleViewModels.filter { benevole in
            let searchTerm = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            return searchTerm.isEmpty ||
                benevole.nom.lowercased().contains(searchTerm) ||
                benevole.prenom.lowercased().contains(searchTerm) ||
                benevole.email.lowercased().contains(searchTerm)
        }
        return filteredBenevoles
    }
    
    // functions to make the use of this class easier
    subscript(index: Int) -> BenevoleViewModel {
        get {
            return benevoleViewModels[index]
        }
        set(newValue) {
            benevoleViewModels[index] = newValue
        }
    }

    // iteratorProtocol
    private var current : Int = 0
    func next() -> BenevoleViewModel?{
        guard current < self.benevoleViewModels.count else { return nil }
        defer {current += 1}
        return self.benevoleViewModels[current]
    }
    
    // RandomAccessCollection
    var startIndex: Int {return benevoleViewModels.startIndex}
    var endIndex: Int {return benevoleViewModels.endIndex}
    func index(after i: Int) -> Int { return benevoleViewModels.index(after: i)}
}
