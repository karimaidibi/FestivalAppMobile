//
//  APIRequestError.swift
//  FestivalAppMobile
//
//  Created by m1 on 20/03/2023.
//

import SwiftUI
import Foundation

enum APIRequestError : Error, CustomStringConvertible{
    case UploadError(String)
    case unknown
    
    var description: String{
        switch self {
        case .UploadError(let service): return "Data could not be uploaded in : \(service)"
        case .unknown: return "unknown error"
        }
    }
}

