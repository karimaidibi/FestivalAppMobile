//
//  ZoneListViewModel.swift
//  FestivalAppMobile
//
//  Created by m1 on 15/03/2023.
//

import Foundation


class ZoneListViewModel : ObservableObject, ViewModelObserver, RandomAccessCollection, IteratorProtocol{
    
    //The model views array
    @Published var zoneViewModelArray : [ZoneViewModel] = []
    
    // constructor
    init(zoneViewModelArray : [ZoneViewModel]){
        self.zoneViewModelArray = zoneViewModelArray
        // register as a observer of all the track model views in the array
        for tmv in zoneViewModelArray{
            tmv.register(obs: self)
        }
    }
    
    // set
    func setZoneViewModelArray(zoneViewModelArray : [ZoneViewModel]){
        self.zoneViewModelArray = zoneViewModelArray
        // register as a observer of all the track model views in the array
        for zvm in zoneViewModelArray{
            zvm.register(obs: self)
        }
    }
    
    @Published var loading : Bool = false
    @Published var errorMessage : String = ""
    @Published var successMessage : String = ""
    
    // State Intent management
    @Published var state: ZonesState = .ready {
        didSet {
            switch state {
            case .ready:
                print("zonesViewModel: ready state")
                debugPrint("-------------------------------")
                self.loading = false
                self.errorMessage = ""
                self.successMessage = ""
            case .loading:
                print("zonesViewModel: loading state")
                debugPrint("-------------------------------")
                self.loading = true
            case.zonesLoaded(let zoneDTOs):
                let newList : [ZoneViewModel] = ZoneListViewModel.fromDTOs(zoneDTOs : zoneDTOs)
                self.setZoneViewModelArray(zoneViewModelArray: newList)
                print("ZonesViewModel: loaded state")
                debugPrint("-------------------------------")
                self.loading = false
            case.zonesLoadingFailed(let apiRequestError):
                print("ZonesViewModel: loading failed state")
                debugPrint("-------------------------------")
                self.errorMessage = apiRequestError.description
                self.loading = false
            case.zoneAdded(let msg):
                print("ZonesViewModel: zone Added state")
                debugPrint("-------------------------------")
                self.successMessage = msg
                self.loading = false
            case.zoneAddingFailed(let error):
                print("ZonesViewModel: zone Adding failed state")
                debugPrint("-------------------------------")
                self.errorMessage = error.description
                self.loading = false
            case.zoneDeleted(let msg):
                print("ZonesViewModel: zone Deleted state")
                debugPrint("-------------------------------")
                self.successMessage = msg
                self.loading = false
            case .error:
                print("ZonesViewModel: error state")
                debugPrint("-------------------------------")
                self.loading = false
            default:
                self.loading = false
            }
        }
    }
    
    static func fromDTOs(zoneDTOs: [ZoneDTO]) -> [ZoneViewModel] {
        return zoneDTOs.map { zoneDTO in
            ZoneViewModel(zoneDTO : zoneDTO)
        }
    }
    
    // fake data function
    func addNewZone(zone: ZoneDTO){
        let zoneVM = ZoneViewModel(zoneDTO: zone)
        self.zoneViewModelArray.append(zoneVM)
        zoneVM.register(obs: self)
    }
    
    // functions that update this listt view model when the view model is changed
    func viewModelUpdated(){
        self.objectWillChange.send()
    }
    
    // functions to make the use of this class easier
    subscript(index: Int) -> ZoneViewModel {
        get {
            return zoneViewModelArray[index]
        }
        set(newValue) {
            zoneViewModelArray[index] = newValue
        }
    }

    // iteratorProtocol
    private var current : Int = 0
    func next() -> ZoneViewModel?{
        guard current < self.zoneViewModelArray.count else { return nil }
        defer {current += 1}
        return self.zoneViewModelArray[current]
    }
    
    // RandomAccessCollection
    var startIndex: Int {return zoneViewModelArray.startIndex}
    var endIndex: Int {return zoneViewModelArray.endIndex}
    func index(after i: Int) -> Int { return zoneViewModelArray.index(after: i)}
    
    func remove(atOffsets : IndexSet)
    {zoneViewModelArray.remove(atOffsets: atOffsets)}
    
    func move(fromOffsets: IndexSet, toOffset: Index){
        zoneViewModelArray.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    
}
