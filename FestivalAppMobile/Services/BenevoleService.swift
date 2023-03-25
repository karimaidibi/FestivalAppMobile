//
//  BenevoleAPIService.swift
//  FestivalAppMobile
//
//  Created by m1 on 20/03/2023.
//

// BenevoleAPIService.swift
import Foundation
import Combine

class BenevoleService {
    
    var api : String
    
    init(){
        // define the url
        if let apiUrl = EnvironmentHelper.getEnvironmentValue(forKey: "API") {
            self.api = apiUrl
        }else{
            self.api = ""
        }
    }
    
    func getBenevoleById(id: String) async -> Result<BenevoleDTO, Error>{
        // definir url
        guard let url = URL(string: "\(self.api)/benevoles/\(id)") else {
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
                    guard let decoded : QueryResultGetOne<BenevoleDTO> = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si on a reussi a decoder le query result
                    let benevoleDTO : BenevoleDTO = decoded.result
                    return .success(benevoleDTO)
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
                return .failure(APIRequestError.invalidHTTPResponse("ge benevole by id"))
            }
        }
        // handle any error
        catch{
            return .failure(APIRequestError.unknown)
        }
    
    }
    
    // get all affectations of the benevole
    func getBenevoleAffectations(id: String) async -> Result<[AffectationDocDTO]?, Error>{
        // definir url
        guard let url = URL(string: "\(self.api)/benevoles/\(id)/affectations") else {
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
                    guard let decoded : QueryResult<AffectationDocDTO> = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si on a reussi a decoder le query result
                    let affectations : [AffectationDocDTO] = decoded.result
                    return .success(affectations)
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
                return .failure(APIRequestError.invalidHTTPResponse("ge benevole affectations"))
            }
        }
        // handle any error
        catch{
            return .failure(APIRequestError.unknown)
        }
    
    }
    
    func removeAffectation(id: String, affectation : AffectationDTO) async -> Result<String?, Error>{
        // definir url
        guard let url = URL(string: "\(self.api)/benevoles/\(id)/removeAffectation") else {
            return .failure(APIRequestError.unknown)
        }
        
        // define the put request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // encode the affectationDTO data
        guard let encoded : Data = await JSONHelper.encode(data: affectation) else {
            return .failure(JSONError.JsonEncodingFailed)
        }
        
        // faire la requete get
        do{
            let (data, response) = try await URLSession.shared.upload(for : request, from: encoded)
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                // si tout se passe bien
                if statusCode == 204 {
                    return .success("Affectation deleted successfully.")
                }else{
                    // si le status est autre que 204
                    // sinon recuperer query bad result
                    guard let queryBadResult : QueryResultMSG = await JSONHelper.decodeOne(data: data) else{
                        return .failure(JSONError.JsonDecodingFailed)
                    }
                    // si bad result
                    return .failure(APIRequestError.UploadError("\(queryBadResult.status) : \(queryBadResult.message)"))
                }
            }else{
                // gerer le cas ou on a pas de reponse de type HTTPURLResponse
                return .failure(APIRequestError.invalidHTTPResponse("removeAffectations"))
            }
        }
        // handle any error
        catch{
            return .failure(APIRequestError.unknown)
        }
    
    }

}
