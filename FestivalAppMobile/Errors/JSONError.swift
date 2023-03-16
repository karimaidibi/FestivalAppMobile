import SwiftUI
import Foundation

enum JSONError : Error, CustomStringConvertible{
    case DataLoadingFailed(String)
    case JsonDecodingFailed
    case JsonEncodingFailed
    case initDataFailed
    case unknown
    
    var description: String{
        switch self {
        case .DataLoadingFailed(let source): return "Data could not be loaded from : \(source)"
        case .JsonDecodingFailed: return "JSON decoding failed"
        case.JsonEncodingFailed: return "JSON encoding failed"
        case .initDataFailed: return "Bad data format: initialization of data failed"
        case .unknown: return "unknown error"
        }
    }
}
