//
//  ZoneListViewModel.swift
//  FestivalAppMobile
//
//  Created by m1 on 15/03/2023.
//

import Foundation


class ZoneListViewModel : ObservableObject, ViewModelObserver, RandomAccessCollection, IteratorProtocol{
    
    //The model views array
    @Published var ZoneViewModelArray : [ZoneViewModel] = []
    
    // constructor
    init(ZoneViewModelArray : [ZoneViewModel]){
        self.ZoneViewModelArray = ZoneViewModelArray
        // register as a observer of all the track model views in the array
        for tmv in ZoneViewModelArray{
            tmv.register(obs: self)
        }
    }
    
    // functions that update this listt view model when the view model is changed
    func viewModelUpdated(){
        self.objectWillChange.send()
    }
    
    // functions to make the use of this class easier
    subscript(index: Int) -> ZoneViewModel {
        get {
            return ZoneViewModelArray[index]
        }
        set(newValue) {
            ZoneViewModelArray[index] = newValue
        }
    }

    // iteratorProtocol
    private var current : Int = 0
    func next() -> ZoneViewModel?{
        guard current < self.ZoneViewModelArray.count else { return nil }
        defer {current += 1}
        return self.ZoneViewModelArray[current]
    }
    
    // RandomAccessCollection
    var startIndex: Int {return ZoneViewModelArray.startIndex}
    var endIndex: Int {return ZoneViewModelArray.endIndex}
    func index(after i: Int) -> Int { return ZoneViewModelArray.index(after: i)}
    
    func remove(atOffsets : IndexSet)
    {ZoneViewModelArray.remove(atOffsets: atOffsets)}
    
    func move(fromOffsets: IndexSet, toOffset: Index){
        ZoneViewModelArray.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    
}
