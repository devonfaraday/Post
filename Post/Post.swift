//
//  Post.swift
//  Post
//
//  Created by Christian McMullin on 2/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation


struct Post {
    
    let username: String
    let text: String
    let timestamp: TimeInterval
    let identifier: UUID
    
    init(username: String, text: String, timestamp: TimeInterval = Date().timeIntervalSince1970, identifier: UUID = UUID()) {
    self.username = username
    self.text = text
    self.timestamp = timestamp
    self.identifier = identifier
    
    }
    
    init?(dictioanry: [String: Any], identifier: String) {
        guard let username = dictioanry[Keys.usernameKey] as? String,
            let text = dictioanry[Keys.textKey] as? String,
            let timestamp = dictioanry[Keys.timestampKey] as? TimeInterval,
            let identifier =  UUID(uuidString: identifier) else { return nil }
        self.username = username
        self.text = text
        self.timestamp = timestamp
        self.identifier = identifier
    }
    
    
}

