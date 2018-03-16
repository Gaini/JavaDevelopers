//
//  User.swift
//  JavaDevelopers
//
//  Created by Gaini on 3/14/18.
//  Copyright © 2018 Gaini. All rights reserved.
//

import Foundation
import UIKit

struct SearchResult: Decodable {
    var items: [UserURL]
    
    struct UserURL: Decodable {
        var url: URL
    }
}

struct User: Decodable {
    var login: String
    var email: String?
    var followers: Int
    var avatar_url: String?
    var date: String
    var avatar: UIImage? = nil
    
    private enum CodingKeys: String, CodingKey {
        case login
        case email
        case followers
        case avatar_url
        case date = "created_at"
    }
    
}

struct SearchUserParameters: Codable {
    var q: String
    var page: Int
    var per_page: Int
}



