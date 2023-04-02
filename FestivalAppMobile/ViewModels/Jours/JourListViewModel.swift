//
//  JourListViewModel.swift
//  JourAppMobile
//
//  Created by etud on 23/03/2023.
//

import Foundation

class JourListViewModel : ObservableObject, ViewModelObserver, RandomAccessCollection, IteratorProtocol {
    
    // The model views array
   @Published var jourViewModels: [JourViewModel] = []
   
    // constructor
    init(jourViewModels: [JourViewModel]){
        self.jourViewModels = jourViewModels
        // register as a observer of all the jour view model in the array
        for fmv in jourViewModels{
            fmv.register(obs: self)
        }
    }
    
    // constructor
    func setJourViewModels(jourViewModels: [JourViewModel]){
        self.jourViewModels = jourViewModels
        // register as a observer of all the jour view model in the array
        for fmv in jourViewModels{
            fmv.register(obs: self)
        }
    }
    
    @Published var loading : Bool = false
    @Published var errorMessage : String = ""
    
    // State Intent management
    @Published var state: JoursState = .ready {
        didSet {
            switch state {
            case .ready:
                print("JourListViewModel: ready state")
                debugPrint("-------------------------------")
                self.loading = false
            case .loading:
                print("JourListViewModel: loading state")
                debugPrint("-------------------------------")
                self.loading = true
            case.joursLoaded(let jourDTOs):
                let newList : [JourViewModel] = JourListViewModel.fromDTOs(jourDTOs : jourDTOs)
                self.setJourViewModels(jourViewModels: newList)
                print("JourListViewModel: loaded state")
                debugPrint("-------------------------------")
                self.loading = false
            case.joursLoadingFailed(let apiRequestError):
                print("JourListViewModel: loading failed state")
                debugPrint("-------------------------------")
                self.errorMessage = apiRequestError.description
                self.loading = false
            case.jourDeleted(_):
                print("JourListViewModel: jour deleted state")
                debugPrint("-------------------------------")
                self.loading = false
            case.jourDeletingFailed(let apiRequestError):
                print("JourListViewModel: jour deleting  state")
                debugPrint("-------------------------------")
                self.errorMessage = apiRequestError.description
                self.loading = false
            case .error:
                print("JourListViewModel: error state")
                debugPrint("-------------------------------")
                self.loading = false
            case .jourAdded(_):
                print("JourListViewModel: jour added state")
                debugPrint("-------------------------------")
                self.loading = false
            case .jourAddingFailed(let error):
                print("JourListViewModel: jour adding failed state")
                debugPrint("-------------------------------")
                self.errorMessage = error.description
                self.loading = false
            default:
                self.loading = false
            }
        }
    }
    
    static func fromDTOs(jourDTOs: [JourDTO]) -> [JourViewModel] {
        return jourDTOs.map { jourDTO in
            JourViewModel(jourDTO : jourDTO)
        }
    }
    
    // functions that update this listt view model when the view model is changed
    func viewModelUpdated(){
        self.objectWillChange.send()
    }

    
    // functions to make the use of this class easier
    subscript(index: Int) -> JourViewModel {
        get {
            return jourViewModels[index]
        }
        set(newValue) {
            jourViewModels[index] = newValue
        }
    }

    // iteratorProtocol
    private var current : Int = 0
    func next() -> JourViewModel?{
        guard current < self.jourViewModels.count else { return nil }
        defer {current += 1}
        return self.jourViewModels[current]
    }
    
    // RandomAccessCollection
    var startIndex: Int {return jourViewModels.startIndex}
    var endIndex: Int {return jourViewModels.endIndex}
    func index(after i: Int) -> Int { return jourViewModels.index(after: i)}
    
    func remove(atOffsets : IndexSet)
    {jourViewModels.remove(atOffsets: atOffsets)}
    
    func move(fromOffsets: IndexSet, toOffset: Index){
        jourViewModels.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    
}
