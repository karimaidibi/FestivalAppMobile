//
//  ZoneService.swift
//  FestivalAppMobile
//
//  Created by etud on 30/03/2023.
//

import Foundation
import Combine

class ZoneService {
    
    var api : String
    
    init(){
        // define the url
        if let apiUrl = EnvironmentHelper.getEnvironmentValue(forKey: "API") {
            self.api = apiUrl
        }else{
            self.api = ""
        }
    }
    
    func getZones() async -> Result<[ZoneDTO]?, Error>{
        // definir url
        guard let url = URL(string: "\(self.api)/zones") else {
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
                    guard let decoded : QueryResult<ZoneDTO> = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si on a reussi a decoder le query result
                    let zoneDTOs : [ZoneDTO] = decoded.result
                    return .success(zoneDTOs)
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
                return .failure(APIRequestError.invalidHTTPResponse("getZones"))
            }
        }
        // handle any error
        catch{
            return .failure(APIRequestError.unknown)
        }
        
    }
    
    func addZone(zoneDTO : ZoneDTO) async -> Result<String?, Error> {

        guard let url = URL(string: "\(self.api)/zones") else {
            return .failure(APIRequestError.unknown)
        }
        // define the post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // encode the log in data
        guard let encoded : Data = await JSONHelper.encode(data: zoneDTO) else {
            return .failure(JSONError.JsonEncodingFailed)
        }
        // send the request
        do {
            let(data, response) = try await URLSession.shared.upload(for : request, from: encoded)
            let httpresponse = response as! HTTPURLResponse // le bon type
            // si tout se passe bien
            if httpresponse.statusCode == 201{
                // recuperer query result
                guard let decoded : QueryResultMSG = await JSONHelper.decodeOne(data: data) else{
                    return .failure(JSONError.JsonDecodingFailed)
                }
                let message = decoded.message
                return .success(message)
            }
            // sinon afficher erreur avec le status code
            else {
                // sinon recuperer query bad result
                guard let queryBadResult : QueryResultMSG = await JSONHelper.decodeOne(data: data) else{
                    return .failure(JSONError.JsonDecodingFailed)
                }
                // si bad result
                return .failure(APIRequestError.UploadError("\(queryBadResult.status) : \(queryBadResult.message)"))
            }
        }catch{
            return .failure(APIRequestError.UploadError("addZone"))
        }

    }
    
    func removeZone(id: String) async -> Result<String?, Error> {
        // Define URL
        guard let url = URL(string: "\(self.api)/zones/\(id)") else {
            return .failure(APIRequestError.unknown)
        }

        // Define the DELETE request
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let emtyBody : Data = Data()
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from : emtyBody )
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                // If everything is OK
                if statusCode == 204 {
                    return .success("Zone deleted successfully.")
                } else {
                    // If the status code is not 204
                    // Decode the query bad result
                    guard let queryBadResult: QueryResultMSG = await JSONHelper.decodeOne(data: data) else {
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // If bad result
                    return .failure(APIRequestError.UploadError("\(queryBadResult.status) : \(queryBadResult.message)"))
                }
            } else {
                // Handle the case where there is no HTTPURLResponse
                return .failure(APIRequestError.invalidHTTPResponse("removeZone"))
            }
        }
        // Handle any error
        catch {
            return .failure(APIRequestError.unknown)
        }
    }
    
    
    func updateZone(id: String, zoneDTO : ZoneDTO) async -> Result<String?, Error> {

        guard let url = URL(string: "\(self.api)/zones/\(id)") else {
            return .failure(APIRequestError.unknown)
        }
        // define the post request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // encode the log in data
        guard let encoded : Data = await JSONHelper.encode(data: zoneDTO) else {
            return .failure(JSONError.JsonEncodingFailed)
        }
        // send the request
        do {
            let(data, response) = try await URLSession.shared.upload(for : request, from: encoded)
            let httpresponse = response as! HTTPURLResponse // le bon type
            // si tout se passe bien
            if httpresponse.statusCode == 200{
                // recuperer query result
                guard let decoded : QueryResultMSG = await JSONHelper.decodeOne(data: data) else{
                    return .failure(JSONError.JsonDecodingFailed)
                }
                return .success(decoded.message)
            }
            // sinon afficher erreur avec le status code
            else {
                // sinon recuperer query bad result
                guard let queryBadResult : QueryResultMSG = await JSONHelper.decodeOne(data: data) else{
                    return .failure(JSONError.JsonDecodingFailed)
                }
                // si bad result
                return .failure(APIRequestError.UploadError("\(queryBadResult.status) : \(queryBadResult.message)"))
            }
        }catch{
            return .failure(APIRequestError.UploadError("update Zone"))
        }

    }
    
    func getZonesByFestival(festivalId : String) async -> Result<[ZoneDTO]?, Error>{
        // definir url
        guard let url = URL(string: "\(self.api)/zones/festival/\(festivalId)") else {
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
                    guard let decoded : QueryResult<ZoneDTO> = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si on a reussi a decoder le query result
                    let zoneDTOs : [ZoneDTO] = decoded.result
                    return .success(zoneDTOs)
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
                return .failure(APIRequestError.invalidHTTPResponse("getZonesByFestival"))
            }
        }
        // handle any error
        catch{
            return .failure(APIRequestError.unknown)
        }
        
    }

}
