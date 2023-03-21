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
    case invalidURLRequest(String)
    case unknown
    
    var description: String{
        switch self {
        case .UploadError(let service): return "APIRequestError [UploadError] : Data could not be uploaded in : \(service)"
        case .invalidURLRequest(let service): return "APIRequestError [invalidURLRequest] invalid URL in \(service)"
        case .unknown: return "APIRequestError [unknown]"
        }
    }
}

