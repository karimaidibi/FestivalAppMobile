//
//  CreneauService.swift
//  FestivalAppMobile
//
//  Created by m1 on 25/03/2023.
//

import Foundation
import Combine

class CreneauService {
    
    var api : String
    
    init(){
        // define the url
        if let apiUrl = EnvironmentHelper.getEnvironmentValue(forKey: "API") {
            self.api = apiUrl
        }else{
            self.api = ""
        }
    }
    
    func getCreneauxByJour(jourId : String) async -> Result<[CreneauDTO]?, Error>{
        // definir url
        guard let url = URL(string: "\(self.api)/creneaux/jour/\(jourId)") else {
            return .failure(APIRequestError.unknown)
        }
        // faire la requete get
        do{
            let (data, response) = try await URLSession.shared.data(from : url)
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                // si tout se passe bien
                if statusCode == 200 {
                    // recuperer query result
                    guard let decoded : QueryResult<CreneauDTO> = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si on a reussi a decoder le query result
                    let creneauDTOs : [CreneauDTO] = decoded.result
                    return .success(creneauDTOs)
                }else{
                    // si le status est autre que 200
                    // sinon recuperer query bad result
                    guard let queryBadResult : QueryResultMSG = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si bad result
                    return .failure(APIRequestError.getRequestError("\(queryBadResult.status) : \(queryBadResult.message)"))
                }
            }else{
                // gerer le cas ou on a pas de reponse de type HTTPURLResponse
                return .failure(APIRequestError.invalidHTTPResponse("getCreneauxByJour"))
            }
        }
        // handle any error
        catch{
            return .failure(APIRequestError.unknown)
        }
        
    }
}
