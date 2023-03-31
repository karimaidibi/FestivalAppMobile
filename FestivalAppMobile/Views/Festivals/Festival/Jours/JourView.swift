//
//  JourFestivalView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct JourView: View {
    @ObservedObject var viewModel: JourViewModel

    var body: some View {
        VStack {
            let formattedDate = UtilityHelper.formattedDateString(from: viewModel.date)
            Text(formattedDate)
                .font(.title)
                .padding(.top, 20)
            
            CreneauListView(jourVM: viewModel)

            Spacer()
        }
        .navigationTitle("Jour")
        .navigationBarItems(trailing:
            Button(action: {
            //viewModel.addNewCreneau()
            }, label: {
                Image(systemName: "plus")
            })
        )
    }
}


