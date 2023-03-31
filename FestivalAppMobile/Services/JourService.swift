//
//  JourService.swift
//  FestivalAppMobile
//
//  Created by m1 on 25/03/2023.
//

import Foundation
import Combine

class JourService {
    
    var api : String
    
    init(){
        // define the url
        if let apiUrl = EnvironmentHelper.getEnvironmentValue(forKey: "API") {
            self.api = apiUrl
        }else{
            self.api = ""
        }
    }
    
    func getJoursByFestival(festivalId : String) async -> Result<[JourDTO]?, Error>{
        // definir url
        guard let url = URL(string: "\(self.api)/jours/festival/\(festivalId)") else {
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
                    guard let decoded : QueryResult<JourDTO> = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si on a reussi a decoder le query result
                    let jourDTOs : [JourDTO] = decoded.result
                    return .success(jourDTOs)
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
                return .failure(APIRequestError.invalidHTTPResponse("getJourByFestival"))
            }
        }
        // handle any error
        catch{
            return .failure(APIRequestError.unknown)
        }
        
    }
    
    func addJour(jourDTO : JourDTO) async -> Result<JourDTO?, Error> {

        guard let url = URL(string: "\(self.api)/jours") else {
            return .failure(APIRequestError.unknown)
        }
        // define the post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // encode the log in data
        guard let encoded : Data = await JSONHelper.encode(data: jourDTO) else {
            return .failure(JSONError.JsonEncodingFailed)
        }
        // send the request
        do {
            let(data, response) = try await URLSession.shared.upload(for : request, from: encoded)
            let httpresponse = response as! HTTPURLResponse // le bon type
            // si tout se passe bien
            if httpresponse.statusCode == 201{
                // recuperer query result
                guard let decoded : QueryResultGetOne<JourDTO> = await JSONHelper.decodeOne(data: data) else{
                    return .failure(JSONError.JsonDecodingFailed)
                }
                let zoneDTO = decoded.result
                return .success(jourDTO)
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
            return .failure(APIRequestError.UploadError("addJour"))
        }

    }
    
    func removeJour(id: String) async -> Result<String?, Error> {
        // Define URL
        guard let url = URL(string: "\(self.api)/jours/\(id)") else {
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
                    return .success("Jour deleted successfully.")
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
                return .failure(APIRequestError.invalidHTTPResponse("removeJour"))
            }
        }
        // Handle any error
        catch {
            return .failure(APIRequestError.unknown)
        }
    }
    
    func updateJour(id: String, jourDTO : JourDTO) async -> Result<String?, Error> {

        guard let url = URL(string: "\(self.api)/jours/\(id)") else {
            return .failure(APIRequestError.unknown)
        }
        // define the post request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // encode the log in data
        guard let encoded : Data = await JSONHelper.encode(data: jourDTO) else {
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
            return .failure(APIRequestError.UploadError("update Jour"))
        }

    }
    
}
