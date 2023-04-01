//
//  ZoneListView.swift
//  FestivalAppMobile
//
//  Created by m1 on 29/03/2023.
//

import Foundation
import SwiftUI

struct ZoneListView : View {
    
    
    @StateObject var zonesVM : ZoneListViewModel = ZoneListViewModel(zoneViewModelArray: [])
    @ObservedObject var festivalVM : FestivalViewModel
    @StateObject var authManager : AuthManager = AuthManager()
    // for popup
    @State private var showAlert = false // popup on success deleting
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    var body: some View{
        
        let zonesIntent : ZonesIntent = ZonesIntent(viewModel: zonesVM)
        
        Section(header: Text("zones")) {
            if let isAdmin = authManager.isAdmin{
                if isAdmin{
                    ForEach(zonesVM, id:\.self) { zoneVM in
                        NavigationLink(destination: ZoneView(viewModel: zoneVM)) {
                            ZoneRowView(zoneVM: zoneVM)
                        }
                    }
                }else{
                    ForEach(zonesVM, id:\.self) { zoneVM in
                        ZoneRowView(zoneVM: zoneVM)
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .task {
            let zonesLoaded = await zonesIntent.getZonesByFestival(festivalId: festivalVM._id)
            if !zonesLoaded{
                alertMessage = zonesVM.errorMessage
                alertTitle = "Error"
                showAlert = true
            }else{
                festivalVM.zoneListViewModels = zonesVM
            }
        }
        
        
    }
    
    
}
