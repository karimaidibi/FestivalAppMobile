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
    func setzoneViewModelArray(zoneViewModelArray : [ZoneViewModel]){
        self.zoneViewModelArray = zoneViewModelArray
        // register as a observer of all the track model views in the array
        for zvm in zoneViewModelArray{
            zvm.register(obs: self)
        }
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
