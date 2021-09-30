//
//  Settings.swift
//  YouVote
//
//
//  Created by Алексей on 29.05.2021.
//

import Foundation

struct Settings {

    static var siteURL = "url какой то"
    static var policyURL = "url какой то"
    static var apiURL = "url какой то"
    static var accessTokenApi = "код какой то"

    static func getApiUrl() -> URL? {
        guard let url = URL(string: self.apiURL)  else {
            return  nil
        }
        return url
    }

}
