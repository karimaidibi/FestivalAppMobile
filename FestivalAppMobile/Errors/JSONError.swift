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
        case .DataLoadingFailed(let source): return "JSONError [DataLoadingFailed] Data could not be loaded from : \(source)"
        case .JsonDecodingFailed: return "JSONError [JsonDecodingFailed]"
        case.JsonEncodingFailed: return "JSONError [JsonEncodingFailed]"
        case .initDataFailed: return "JSONError [initDataFailed] Bad data format"
        case .unknown: return "JSONError [unknown error]"
        }
    }
}
