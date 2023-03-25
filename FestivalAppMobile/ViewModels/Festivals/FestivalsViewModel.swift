//
//  FestivalsViewModel.swift
//  FestivalAppMobile
//
//  Created by etud on 20/03/2023.
//

import Foundation

class FestivalsViewModel : ObservableObject, ViewModelObserver, RandomAccessCollection, IteratorProtocol {
    
    // The model views array
   @Published var festivalViewModels: [FestivalViewModel] = []
   
    // constructor
    init(festivalViewModels: [FestivalViewModel]){
        self.festivalViewModels = festivalViewModels
        // register as a observer of all the festival view model in the array
        for fmv in festivalViewModels{
            fmv.register(obs: self)
        }
    }
    
    // constructor
    func setFestivalViewModels(festivalViewModels: [FestivalViewModel]){
        self.festivalViewModels = festivalViewModels
        // register as a observer of all the festival view model in the array
        for fmv in festivalViewModels{
            fmv.register(obs: self)
        }
    }
    
    @Published var loading : Bool = false
    @Published var errorMessage : String = ""
    @Published var successMessage : String = ""
    
    // State Intent management
    @Published var state: FestivalsState = .ready {
        didSet {
            switch state {
            case .ready:
                print("FestivalsViewModel: ready state")
                debugPrint("-------------------------------")
                self.loading = false
                self.errorMessage = ""
                self.successMessage = ""
            case .loading:
                print("FestivalsViewModel: loading state")
                debugPrint("-------------------------------")
                self.loading = true
            case.festivalsLoaded(let festivalDTOs):
                let newList : [FestivalViewModel] = FestivalsViewModel.fromDTOs(festivalDTOs : festivalDTOs)
                self.setFestivalViewModels(festivalViewModels: newList)
                print("FestivalsViewModel: loaded state")
                debugPrint("-------------------------------")
                self.loading = false
            case.festivalsLoadingFailed(let apiRequestError):
                print("FestivalsViewModel: loading failed state")
                debugPrint("-------------------------------")
                self.errorMessage = apiRequestError.localizedDescription
                self.loading = false
            case.festivalAdded(let festivalDTO):
                print("FestivalsViewModel: festival Added state")
                debugPrint("-------------------------------")
                self.addNewFestival(festival: festivalDTO)
                self.loading = false
            case.festivalAddingFailed(let error):
                print("FestivalsViewModel: festival Adding failed state")
                debugPrint("-------------------------------")
                self.errorMessage = error.description
                self.loading = false
            case.festivalDeleted(let msg):
                print("FestivalsViewModel: festival Deleted state")
                debugPrint("-------------------------------")
                self.successMessage = msg
                self.loading = false
            case .error:
                print("FestivalsViewModel: error state")
                debugPrint("-------------------------------")
                self.loading = false
            default:
                self.loading = false
            }
        }
    }
    
    static func fromDTOs(festivalDTOs: [FestivalDTO]) -> [FestivalViewModel] {
        return festivalDTOs.map { festivalDTO in
            FestivalViewModel(festivalDTO : festivalDTO)
        }
    }
    
   // fake data function
   func addNewFestival(festival: FestivalDTO){
       let festivalVM = FestivalViewModel(festivalDTO: festival)
       self.festivalViewModels.append(festivalVM)
       festivalVM.register(obs: self)
   }
    
    // functions that update this listt view model when the view model is changed
    func viewModelUpdated(){
        self.objectWillChange.send()
    }

    
    // functions to make the use of this class easier
    subscript(index: Int) -> FestivalViewModel {
        get {
            return festivalViewModels[index]
        }
        set(newValue) {
            festivalViewModels[index] = newValue
        }
    }

    // iteratorProtocol
    private var current : Int = 0
    func next() -> FestivalViewModel?{
        guard current < self.festivalViewModels.count else { return nil }
        defer {current += 1}
        return self.festivalViewModels[current]
    }
    
    // RandomAccessCollection
    var startIndex: Int {return festivalViewModels.startIndex}
    var endIndex: Int {return festivalViewModels.endIndex}
    func index(after i: Int) -> Int { return festivalViewModels.index(after: i)}
    
    func remove(atOffsets : IndexSet)
    {festivalViewModels.remove(atOffsets: atOffsets)}
    
    func move(fromOffsets: IndexSet, toOffset: Index){
        festivalViewModels.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    
}
