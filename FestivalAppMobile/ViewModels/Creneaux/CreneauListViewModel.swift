//
//  ListCreneauxViewModel.swift
//  FestivalAppMobile
//
//  Created by m1 on 24/03/2023.
//

import Foundation

class CreneauListViewModel : ObservableObject, ViewModelObserver, RandomAccessCollection, IteratorProtocol{
    
    //The model views array
    @Published var creneauViewModelArray : [CreneauViewModel] = []
    
    // constructor
    init(creneauViewModelArray : [CreneauViewModel]){
        self.creneauViewModelArray = creneauViewModelArray
        // register as a observer of all the track model views in the array
        for tmv in creneauViewModelArray{
            tmv.register(obs: self)
        }
    }
    
    
    // set
    func setCreneauViewModelArray(creneauViewModelArray : [CreneauViewModel]){
        self.creneauViewModelArray = creneauViewModelArray
        // register as a observer of all the track model views in the array
        for zvm in creneauViewModelArray{
            zvm.register(obs: self)
        }
    }
    
    
    @Published var loading : Bool = false
    @Published var errorMessage : String = ""
    
    // State Intent management
    @Published var state: CreneauListState = .ready {
        didSet {
            switch state {
            case .ready:
                print(state.description)
                debugPrint("-------------------------------")
                self.loading = false
            case .loading:
                print(state.description)
                debugPrint("-------------------------------")
                self.loading = true
            case.creneauxLoaded(let creneauDTOs):
                let newList : [CreneauViewModel] = CreneauListViewModel.fromDTOs(creneauDTOs : creneauDTOs)
                self.setCreneauViewModelArray(creneauViewModelArray: newList)
                print(state.description)
                debugPrint("-------------------------------")
                self.loading = false
            case.creneauxLoadingFailed(let apiRequestError):
                print(state.description)
                debugPrint("-------------------------------")
                self.errorMessage = apiRequestError.localizedDescription
                self.loading = false
            case .error:
                print(state.description)
                debugPrint("-------------------------------")
                self.loading = false
            default:
                self.loading = false
            }
        }
    }
    
    static func fromDTOs(creneauDTOs: [CreneauDTO]) -> [CreneauViewModel] {
        return creneauDTOs.map { creneauDTO in
            CreneauViewModel(creneauDTO : creneauDTO)
        }
    }
    
    
    // functions that update this listt view model when the view model is changed
    func viewModelUpdated(){
        self.objectWillChange.send()
    }
    
    // functions to make the use of this class easier
    subscript(index: Int) -> CreneauViewModel {
        get {
            return creneauViewModelArray[index]
        }
        set(newValue) {
            creneauViewModelArray[index] = newValue
        }
    }

    // iteratorProtocol
    private var current : Int = 0
    func next() -> CreneauViewModel?{
        guard current < self.creneauViewModelArray.count else { return nil }
        defer {current += 1}
        return self.creneauViewModelArray[current]
    }
    
    // RandomAccessCollection
    var startIndex: Int {return creneauViewModelArray.startIndex}
    var endIndex: Int {return creneauViewModelArray.endIndex}
    func index(after i: Int) -> Int { return creneauViewModelArray.index(after: i)}
    
    func remove(atOffsets : IndexSet)
    {creneauViewModelArray.remove(atOffsets: atOffsets)}
    
    func move(fromOffsets: IndexSet, toOffset: Index){
        creneauViewModelArray.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    
}
