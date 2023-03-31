//
//  ZonesIntent.swift
//  FestivalAppMobile
//
//  Created by etud on 30/03/2023.
//

import Foundation

import SwiftUI

struct ZonesIntent {
    @ObservedObject private var viewModel: ZoneListViewModel
    private var zoneService : ZoneService = ZoneService()
    
    init(viewModel: ZoneListViewModel) {
        self.viewModel = viewModel
    }
    
    func getZones() async -> Bool{
        viewModel.state = .loading
        let result = await zoneService.getZones()
        switch result{
        case .success(let zoneDTOs):
            viewModel.state = .zonesLoaded(zoneDTOs!)
            return true
        case .failure(let error as APIRequestError):
            viewModel.state = .zonesLoadingFailed(error)
            return false
        default:
            viewModel.state = .error
            return false
        }
    }
    
    func addZone(nom : String, nombre_benevoles_necessaires: Int, idFestival : String) async -> Bool {
        // create data
        // false zone (zone libre)
        let zoneDTO = ZoneDTO(nom: nom, nombre_benevoles_necessaires: nombre_benevoles_necessaires, idFestival: idFestival)
        
        viewModel.state = .loading
        let result = await zoneService.addZone(zoneDTO: zoneDTO)
        switch result{
        case .success(let msg):
            viewModel.state = .zoneAdded(msg!)
            return true
        case .failure(let error as APIRequestError):
            viewModel.state = .zoneAddingFailed(error)
            return false
        default:
            viewModel.state = .error
            return false
        }
    }
    
    func removeZone(id : String) async -> Bool{
        viewModel.state = .loading
        let result = await zoneService.removeZone(id: id)
        switch result{
        case .success(let  msg):
            viewModel.state = .zoneDeleted(msg!)
            return true
        case .failure(let error as APIRequestError):
            viewModel.state = .zoneDeletingFailed(error)
            return false
        default:
            viewModel.state = .error
            return false
        }
    }
    
}
