//
//  Server.swift
//  JavaDevelopers
//
//  Created by Gaini on 3/14/18.
//  Copyright © 2018 Gaini. All rights reserved.
//

import Alamofire
import AlamofireImage
import CodableAlamofire

class Server {
    static let baseUrl = "https://api.github.com"
    
    static func getJavaDevelopers(fromPage page: Int, completion: @escaping ([User]?) -> Void)
    {
        let url = getUrl("/search/users?")
        let parameters = SearchUserParameters(q: "language:java", page: page, per_page: 10).dictionary
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString).responseDecodableObject {
            (response: DataResponse<SearchResult>) in
            
            var users:[User] = []
            if let result = response.result.value?.items {
                for user in result {
                    getUserByURL(userURL: user.url, completion: {
                        user in
                        users.append(user)
                        
                        if users.count == result.count {
                            completion(users)
                        }
                    })
                }
            }
            
        }
    }
    
    static func getUserByURL(userURL: URL, completion: @escaping (User) -> Void) {
        Alamofire.request(userURL, method: .get).responseDecodableObject { (response: DataResponse<User>) in
            guard var user = response.result.value else { return }
            
            user.date = convertGitHubDate(dateString: user.date)
            completion(user)
        }
    }
    
    static func getUserAvatar(_ user: User, completion: @escaping (UIImage?) -> Void) {
        
        if let url = user.avatar_url {
            Alamofire.request(url).responseImage {
                response in
                
                completion(response.result.value)
            }
        }
    }
    
    private static func getUrl(_ path: String) -> String {
        return baseUrl + path
    }
}


