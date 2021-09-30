//
//  CoreRequestNetwork.swift
//  florewsbbbb
//
//  Created by Алексей on 18.12.2020.
//

import Foundation
typealias JSONTypeEncodable = Encodable
typealias JSONTypeAny = [String: Any]
typealias JSONType = [String: String]
typealias JSONArrayType = [String:[String: String]]

struct RequestNetworkCore {

    var url = ""
    var method: HttpMethod = .GET
    var encoding: Encoding = .methodDependent
    var headers: [String: String]?
    var parameters: JSONParameters?
    var queue = DispatchQueue.global(qos: .userInteractive)
    
    enum HttpMethod {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    enum Encoding {
        case methodDependent
        case queryString
        case httpBody
        case json
    }
    
    
    enum JSONParameters {
        case dictionary(JSONType)
        case array(JSONArrayType)     
    }
    
}





