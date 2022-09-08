//
//  APIServiceCall.swift
//  NewsApp
//
//  Created by Madawi Ahmed on 11/02/1444 AH.
//
import Foundation
import Alamofire

class APIService: NSObject{
    
    
   // MARK: Call setUp
    
    var headers = HTTPHeaders()
    var method: HTTPMethod!
    var parameters: Parameters?
    var url :String! = Secrets.baseUrl
    var encoding: ParameterEncoding! = JSONEncoding.default
    
    init(data: [String:Any]? = nil,
         headers: [String:String] = [:],
         url :String?,
         service :Services? = nil,
         method: HTTPMethod,
         isJSONRequest: Bool = true){
        
        super.init()
        if method == .get {
            parameters = nil
        } else {
            data?.forEach{parameters?.updateValue($0.value, forKey: $0.key)}
        }
        
        headers.forEach({self.headers.add(name: $0.key, value: $0.value)})
        
        if url == nil, service != nil{
            self.url += service!.endPoint
        }else{
            self.url = url
        }
        
        if !isJSONRequest{
            encoding = URLEncoding.default
        }
        
        self.method = method
        
        print("Call Initiated with \n- Service: \(service?.endPoint ?? self.url ?? "") \n- data: \(String(describing: parameters))")
    }
    
    // MARK: Call execution
    
    func executeCall<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        
        guard NetworkConnectivity.isConnectedToInternet else {
            completion(.failure(APIErrors.lostConnection))
            return }
        
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers).responseData(completionHandler: { response in
            
            switch response.result{
                
            case .success(let data):
                if let code = response.response?.statusCode{
                    switch code {
                    case 200...299:
                        do {
                            completion(.success(try JSONDecoder().decode(T.self, from: data)))
                        } catch let e {
                            print("Response Data as a String:\n\(String(data: data, encoding: .utf8) ?? "No data received!")") /// for debugging
                            completion(.failure(APIErrors.error(description: e.localizedDescription)))
                        }
                        
                    case 401:
                        completion(.failure(APIErrors.unauthorizedUser))
                        
                    case 403:
                        completion(.failure(APIErrors.forbidden))
                        
                    case 404:
                        completion(.failure(APIErrors.pageNotFound))
                        
                    case 429:
                        completion(.failure(APIErrors.tooManyRequests))
                        
                    default:
                        let error = NSError(domain: response.debugDescription, code: code)
                        
                        completion(.failure(APIErrors.error(description:error.localizedDescription, statusCode: error.code)))
                    }
                }
            case .failure(let error):
                completion(.failure(APIErrors.error(description: error.localizedDescription)))
            }
        })
    }
}
