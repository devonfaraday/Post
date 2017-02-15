//
//  Keys.swift
//  Post
//
//  Created by Christian McMullin on 2/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]

struct Keys {
    
    // MARK: - Model Keys
    static let baseURL = URL(string: "https://devmtn-post.firebaseio.com/posts")
    
    
    static let usernameKey = "username"
    static let textKey = "text"
    static let timestampKey = "timestamp"
    
    
}

