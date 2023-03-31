//
//  BenevoleRowView.swift
//  FestivalAppMobile
//
//  Created by m1 on 31/03/2023.
//

import Foundation
import SwiftUI

struct BenevoleRowView: View {
    @ObservedObject var viewModel: BenevoleViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(viewModel.prenom) \(viewModel.nom)")
                    .font(.headline)
                
                Text(viewModel.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 10)
    }
}
