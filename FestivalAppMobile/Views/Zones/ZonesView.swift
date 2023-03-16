//
//  ZonesView.swift
//  FestivalAppMobile
//
//  Created by m1 on 16/03/2023.
//

import Foundation
import SwiftUI

// the data from the url of apple
var queryResult : QueryResult<ZoneDTO>?

// the data of zones from url
var zonesData : Data?

// the zone models DTO decoded from the zonesDatafromJson
var zoneDTOs : [ZoneDTO]?

// initialise the array of ZoneViewModel to be filled by the array of ZoneViewModelsDTOs later
var ZoneViewModels : [ZoneViewModel]?

// List of items
var items : [ZoneViewModel] = []

var isLoading : Bool = false

struct ZonesView: View {
    
    @StateObject var zoneListVM : ZoneListViewModel = ZoneListViewModel(zoneViewModelArray: [])
    
    var body: some View {
        NavigationStack{
            GeometryReader{ geometry in
                ZStack(alignment: .top) {
                    List{
                        if isLoading{
                            ProgressView()
                        }else{
                            ForEach(zoneListVM.zoneViewModelArray, id: \.self){
                                item in
                                Text("zone Name : \(item.nom)")
                            }
                        }
                    }
                    .padding(.top, geometry.safeAreaInsets.top + 60) // Ajustez cette valeur en fonction de la hauteur de votre message fixe
                    
                    Text("Liste des Zones")
                        .font(.headline)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, geometry.safeAreaInsets.top)
                }
            }
        }
        .padding()
        .task {
            // get the json data from apple web site
            do{
                guard let url = URL(string: "https://projetawiapi.onrender.com/api/zones") else{
                    debugPrint("invalid url")
                    return
                }
                
                isLoading = true
                let (data, _) = try await URLSession.shared.data(from: url)
                isLoading = false

                // do something with data
                zonesData = data
            }catch{
                debugPrint("failed to get data from url")
            }
            // decode the data
            if let zonesData = zonesData{
                // Decode the data using a JSONDecoder object
                let decoder = JSONDecoder()
                do {
                    queryResult = try decoder.decode(QueryResult.self, from: zonesData)
                } catch {
                    print("Error: \(error)")
                }
                // decode the data into zone DTOs
                if let queryResult = queryResult {
                    zoneDTOs = queryResult.result
                    if let zoneDTOs = zoneDTOs{
                        ZoneViewModels = ZoneDTO.convertZoneDTOsToDisplay(zoneDTOs: zoneDTOs)
                    }
                }
            }
            
            // create the items from the decoded data
            if let zoneViewModels = ZoneViewModels {
                items = zoneViewModels
            }
            
            // update the array of data in the zoneListVM
            zoneListVM.setzoneViewModelArray(zoneViewModelArray: items)
        }
    }
}
