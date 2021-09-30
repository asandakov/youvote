//
//  Dictionary + queryString.swift
//  driver
//
//  Created by Алексей on 22.01.2021.
//

import Foundation


extension Dictionary {
     var queryString: String {
        
        return self.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
        
     }
  }
