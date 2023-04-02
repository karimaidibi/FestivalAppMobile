//
//  ZoneListView.swift
//  FestivalAppMobile
//
//  Created by m1 on 29/03/2023.
//

import Foundation
import SwiftUI

struct ZoneListView : View {
    
    
    @ObservedObject var zonesVM : ZoneListViewModel
    @ObservedObject var festivalVM : FestivalViewModel
    @StateObject var authManager : AuthManager = AuthManager()
    
    var body: some View{
        
        let zonesIntent : ZonesIntent = ZonesIntent(viewModel: zonesVM)
        
        Section(header: customHeaderView()) {
            if let isAdmin = authManager.isAdmin{
                if isAdmin{
                    ForEach(zonesVM, id:\.self) { zoneVM in
                        NavigationLink(destination: ZoneView(viewModel: zoneVM)) {
                            ZoneRowView(zoneVM: zoneVM)
                        }
                    }
                    .onDelete { indexSet in
                        Task {
                            let zone = zonesVM[indexSet.first!]
                            let zoneDeleted = await zonesIntent.removeZone(id: zone._id)
                            if zoneDeleted{
                                zonesVM.remove(atOffsets: indexSet)
                            }
                        }
                    }
                    
                }else{
                    ForEach(zonesVM, id:\.self) { zoneVM in
                        ZoneRowView(zoneVM: zoneVM)
                    }
                }
            }
        }
    }
    
    
    private func customHeaderView() -> some View {
        HStack {
            Text("Zones")
            if let isAdmin = authManager.isAdmin{
                if isAdmin{
                    Spacer()
                    NavigationLink(destination: AddZoneView(zonesVM: zonesVM, festivalVM: festivalVM)) {
                        Image(systemName: "plus")
                    }
                    .padding(.trailing, 1)
                    CustomEditButton()
                }
            }
        }
    }
}
