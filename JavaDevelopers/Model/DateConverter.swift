//
//  DateConverter.swift
//  JavaDevelopers
//
//  Created by Gaini on 3/15/18.
//  Copyright © 2018 Gaini. All rights reserved.
//

import Foundation

private let dateFormatter = DateFormatter()

func convertGitHubDate(dateString: String) -> String {
    
    //convert dateString to Date format
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let date = dateFormatter.date(from: dateString)
    
    //convert it back to string with readable format
    dateFormatter.dateFormat = "dd.MM.yyyy"
    let result = dateFormatter.string(from: date!)
    
    return result
}


