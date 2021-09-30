//
//  CoreNetwork.swift
//  florews
//  
//  Created by Алексей on 18.12.2020.
//

import Foundation
import Alamofire

protocol NetworkCoreProtocol {
   func request (request:RequestNetworkCore, completion: @escaping (Result<[String: Any], ErrorNetworkCore>) -> () ) -> DataRequest
   func cansel(data:DataRequest) -> ()
}


class NetworkCoreAlamofire:NetworkCoreProtocol {
          
     public static let `default` = NetworkCoreAlamofire()
    
     private let manager: Session
    
     init(configuration: URLSessionConfiguration = URLSessionConfiguration.af.default) {
        configuration.timeoutIntervalForRequest = 5
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.manager = Session(configuration: configuration)
     }

 
     public func request(request: RequestNetworkCore, completion: @escaping  (Result<[String: Any],ErrorNetworkCore>) -> ()) -> DataRequest {
   
           
        var Data:DataRequest
        
        switch request.parameters {
        
              case let .dictionary(dictionary):
                  
                    Data = self.manager.request(request.url,
                                      method: request.methodToAlamofire(),
                                      parameters: dictionary,
                                      encoder: request.encodingToAlamofire(),
                                      headers: request.headersToAlamofire()
                    );
        
                case let .array(dictionary):
     
                    Data = self.manager.request(request.url,
                                      method: request.methodToAlamofire(),
                                      parameters: dictionary,
                                      encoder: request.encodingToAlamofire(),
                                      headers: request.headersToAlamofire()
                    );
                    
                default:
                    Data = self.manager.request(request.url,
                                      method: request.methodToAlamofire(),
                                      headers: request.headersToAlamofire()
                    );
                break
        }
                   
        
       Data.responseJSON(queue:request.queue) { response in
            
            if let httpStatusCode = response.response?.statusCode {
                let range = 200..<300
                if (!range.contains(httpStatusCode)){
                    let errorMsg = self.handleCodeError(code: httpStatusCode)
                    completion(.failure(errorMsg))
                    return
                }
            }
         
            switch response.result {
            
                case let .success(value):
                   
                    guard let responseJSON = value as? JSONTypeAny else {
                        completion(.failure(.network(description: "Не верный тип данных от сервера")))
                        return
                     }
                                        
                    
                    if let error = self.isApiError(dict: responseJSON) {
                        completion(.failure(error))
                        return
                    }
                    
                    guard let distJSON = responseJSON["RESPONSE"] as? JSONTypeAny else {
                        completion(.failure(.network(description: "Не верный формат данных")))
                        return
                     }
                    
                    
                    completion(.success(distJSON))
                    
                case let .failure(error):
                    let errorMsg = self.handleErrorResponse(error: error)
                    completion(.failure(errorMsg))
             }
       }
        return Data
    }
    
    public func cansel(data:DataRequest)  -> () {
        data.cancel()
    }
    
    func isApiError(dict: JSONTypeAny) -> ErrorNetworkCore? {
               
        if let error = dict["ERROR"] as? JSONTypeAny, let message = error["TEXT"] as? String,let code = error["CODE"] as? String {
            guard (message.isEmpty == false) else {
                return nil
            }
           return .api(description:message,code:code)
        }
        
        return nil
     }
    
    
     func handleErrorResponse(error: Error) -> ErrorNetworkCore {

        var errorMsg = ""
        if let error = error as? AFError {
           switch error {
           case .invalidURL(let url):
                 errorMsg = "Invalid URL: \(url)"
           case .parameterEncodingFailed( _):
                errorMsg = "Parameter encoding failed" //\(error.localizedDescription)
           case .multipartEncodingFailed( _):
                errorMsg = "Multipart encoding failed"
           case .responseValidationFailed( _):
               errorMsg = "Response validation failed:"
           case .responseSerializationFailed( _):
               errorMsg = "Response serialization failed"
           case .sessionTaskFailed( _):
               errorMsg = "Не удалось выполнить задачу сеанса"
           default:
               errorMsg = "Не удалось выполнить запрос. Пожалуйста, попробуйте позже."
           }
        }else if let error = error as? URLError {
            errorMsg = "URLError occurred: \(error)"
        } else {
            errorMsg = "Не удалось выполнить запрос. Пожалуйста, попробуйте позже."
        }
        
        if error.localizedDescription == "The Internet connection appears to be offline." {
            errorMsg = "Подключение к интернету отключено."
        }

        return .network(description: errorMsg)
    }
    
     func handleCodeError(code: Int) -> ErrorNetworkCore {
        switch code {
            case 500:
               return .network(description: "Сервис временно недоступен. Пожалуйста, попробуйте позже.")
            case 400:
               return .network(description: "Не удалось выполнить запрос. Пожалуйста, попробуйте позже.")
            case 404:
                return .network(description: "Не удалось выполнить запрос. Пожалуйста, попробуйте позже.")
            default:
                return .network(description: "Не удалось выполнить запрос. Пожалуйста, попробуйте позже.")
        }
    }
}




fileprivate extension RequestNetworkCore {
    func methodToAlamofire() -> Alamofire.HTTPMethod {
        switch method {
        case .GET:
            return .get
        case .POST:
            return .post
        case .PUT:
            return .put
        case .DELETE:
            return .delete
        }
    }
    
    
    func encodingToAlamofire() -> Alamofire.ParameterEncoder {
        switch encoding {
        case .methodDependent:        
            return URLEncodedFormParameterEncoder(destination: .methodDependent)
        case .queryString:
            return URLEncodedFormParameterEncoder(destination: .queryString)
        case .httpBody:
            return URLEncodedFormParameterEncoder(destination: .httpBody)
        case .json:
            if let parameters = parameters {
             
                switch parameters {   
                default:
                    
                    return JSONParameterEncoder.default
                }
            }
            return JSONParameterEncoder.default
        }
        
        
    }
     
    
    func headersToAlamofire() -> Alamofire.HTTPHeaders?{
        if let headers = headers {
            return HTTPHeaders.init(headers)
        }             
        return nil
    }
    
    
}
