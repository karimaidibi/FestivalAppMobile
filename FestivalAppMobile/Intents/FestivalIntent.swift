//
//  FestivalIntent.swift
//  FestivalAppMobile
//
//  Created by etud on 20/03/2023.
//

import Foundation

import SwiftUI

struct FestivalIntent {
    @ObservedObject private var viewModel: FestivalViewModel
    
    init(viewModel: FestivalViewModel) {
        self.viewModel = viewModel
    }
}
