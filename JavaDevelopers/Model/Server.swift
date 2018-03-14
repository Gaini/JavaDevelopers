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
    
    static func getJavaDevelopers(completion: @escaping ([User]?) -> Void)
    {
        Alamofire.request("https://api.github.com/search/users?per_page=10", method: .get, parameters: ["q": "language:java"], encoding: URLEncoding.queryString).responseDecodableObject {
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
            
            completion(response.result.value!)
        }
    }
    
    static func getUserAvatar(_ user: User, completion: @escaping (UIImage?) -> Void) {
        
        if let url = user.avatar_url {
            Alamofire.request(url).responseImage {
                response in
                
                print(response.response)
                
                completion(response.result.value)
            }
        }
    }
}


