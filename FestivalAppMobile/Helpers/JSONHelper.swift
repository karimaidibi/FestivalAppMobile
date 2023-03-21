import SwiftUI
import Foundation

struct JSONHelper{
    
    
    //décode les données au format json. Cette fx est générique pour décoder n'importe quel type de données
    static func decodeMany<T: Decodable>(data: Data) async -> [T]?{
        let decoder = JSONDecoder() // création d'un décodeur
        if let decoded = try? decoder.decode([T].self, from: data){
            return decoded
        }else{
            debugPrint("json could not be decoded from data")
        }
        return nil
    }
    
    //décode les données au format json. Cette fx est générique pour décoder n'importe quel type de données
    static func decodeOne<T: Decodable>(data: Data) async -> T?{
        let decoder = JSONDecoder() // création d'un décodeur
        if let decoded = try? decoder.decode(T.self, from: data){
            return decoded
        }else{
            debugPrint("json could not be decoded from data")
        }
        return nil
    }
    
    // encode les données
    static func encode<T : Encodable>(data : T) async -> Data?{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let jsonData = try? encoder.encode(data) else {
            debugPrint(JSONError.JsonEncodingFailed)
            return nil
        }
        return jsonData
    }
    
    
}
