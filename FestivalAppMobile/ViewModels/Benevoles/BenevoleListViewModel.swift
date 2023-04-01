//
//  BenevoleListViewModel.swift
//  BenevoleAppMobile
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
    
    func setBenevoleViewModels(benevoleViewModels: [BenevoleViewModel]){
        self.benevoleViewModels = benevoleViewModels
        // register as a observer of all the benevole view model in the array
        for fmv in benevoleViewModels{
            fmv.register(obs: self)
        }
    }
    
    @Published var loading : Bool = false
    @Published var errorMessage : String = ""
    @Published var successMessage : String = ""
    
    // State Intent management
    @Published var state: BenevoleListState = .ready {
        didSet {
            switch state {
            case .ready:
                print("BenevoleListViewModel: ready state")
                debugPrint("-------------------------------")
                self.loading = false
                self.errorMessage = ""
                self.successMessage = ""
            case .loading:
                print("BenevoleListViewModel: loading state")
                debugPrint("-------------------------------")
                self.loading = true
            case.benevolesLoaded(let benevoleDTOs):
                let newList : [BenevoleViewModel] = BenevoleListViewModel.fromDTOs(benevoleDTOs : benevoleDTOs)
                self.setBenevoleViewModels(benevoleViewModels: newList)
                print("BenevoleListViewModel: loaded state")
                debugPrint("-------------------------------")
                self.loading = false
            case.benevolesLoadingFailed(let apiRequestError):
                print("BenevoleListViewModel: loading failed state")
                debugPrint("-------------------------------")
                self.errorMessage = apiRequestError.description
                self.loading = false
            case.benevolesDocLoaded(let benevoleDocDTOs):
                let newList : [BenevoleViewModel] = BenevoleListViewModel.fromDocDTOs(benevoleDocDTOs : benevoleDocDTOs)
                self.setBenevoleViewModels(benevoleViewModels: newList)
                print("BenevoleListViewModel: loaded with docs state")
                debugPrint("-------------------------------")
                self.loading = false
            case .processingAffectations:
                print("BenevoleListViewModel : processing affectations")
                debugPrint("-------------------------------")
                self.loading = true
            case .processingAffectationsSuccess(_):
                print("BenevoleListViewModel : processing affectations success")
                debugPrint("-------------------------------")
                self.loading = false
            case .processingAffectationsFailure(let apiRequestError):
                print("BenevoleListViewModel : processing affectations failed")
                debugPrint("-------------------------------")
                self.errorMessage = apiRequestError.description
                self.loading = false
            case .error:
                print("BenevoleListViewModel: error state")
                debugPrint("-------------------------------")
                self.loading = false
            default:
                self.loading = false
            }
        }
    }
    
    static func fromDTOs(benevoleDTOs: [BenevoleDTO]) -> [BenevoleViewModel] {
        return benevoleDTOs.map { benevoleDTO in
            BenevoleViewModel(benevoleDTO : benevoleDTO)
        }
    }
    
    static func fromDocDTOs(benevoleDocDTOs: [BenevoleDocDTO]) -> [BenevoleViewModel] {
        return benevoleDocDTOs.map { benevoleDocDTO in
            BenevoleViewModel(benevoleDocDTO : benevoleDocDTO)
        }
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
    
    
    func remove(atOffsets : IndexSet)
    {benevoleViewModels.remove(atOffsets: atOffsets)}
    
    func move(fromOffsets: IndexSet, toOffset: Index){
        benevoleViewModels.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
}
