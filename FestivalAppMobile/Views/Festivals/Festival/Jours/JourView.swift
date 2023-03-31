//
//  JourFestivalView.swift
//  FestivalAppMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

import SwiftUI

struct JourView: View {
    @StateObject var viewModel: JourViewModel

    var body: some View {
        VStack {
            Text(viewModel.date)
                .font(.title)
                .padding(.top, 20)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    //ForEach(viewModel) { creneau in
                        //NavigationLink(destination: CreneauListView(viewModel: creneau)) {
                            //CreneauRow(creneau: creneau)
                        //}
                    //}
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            }

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


