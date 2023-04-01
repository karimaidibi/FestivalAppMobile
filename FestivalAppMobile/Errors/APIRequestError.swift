//
//  APIRequestError.swift
//  FestivalAppMobile
//
//  Created by m1 on 20/03/2023.
//

import SwiftUI
import Foundation

enum APIRequestError : Error, CustomStringConvertible, Equatable{
    case UploadError(String)
    case CustomError(String)
    case invalidURLRequest(String)
    case getRequestError(String)
    case invalidHTTPResponse(String)
    case unknown
    
    var description: String{
        switch self {
        case .UploadError(let service): return "APIRequestError [UploadError] : Data could not be uploaded in : \(service)"
        case .invalidURLRequest(let service): return "APIRequestError [invalidURLRequest] invalid URL in \(service)"
        case .getRequestError(let message):
            return "get request : \(message)"
        case .invalidHTTPResponse(let string):
            return("APIRequestError [invalidHTTPResponse] in : \(string)")
        case .CustomError(let message) : return message
        case .unknown: return "APIRequestError [unknown]"
        }
    }
}

