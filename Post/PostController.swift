//
//  PostController.swift
//  Post
//
//  Created by Christian McMullin on 2/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation

class PostController {
    
    static let shared = PostController()
    var posts = [Post]() {
        didSet{
         delegate?.postsWereUpdatedTo(posts: posts, on: self)
        }
    }
    weak var delegate: PostControllerDelegate?
    
    init() {
        fetchPosts { (posts) in
            self.posts = posts
        }
    }
    
     let getterEndpoint = Keys.baseURL?.appendingPathExtension("json")
     func fetchPosts(completion: @escaping(_ posts: [Post]) -> Void) {
        guard let url = getterEndpoint else { return }
        NetworkController.performRequest(for: url, httpMethod: .get) { (data, error) in
            if let error = error {
                fatalError("\(error.localizedDescription)")
            }
            guard let data = data,
                let responseData = String(data: data, encoding: .utf8) else
            {
                print("data is wrong bisk")
                completion([])
                return
            }
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data)) as? [String: JSONDictionary]
                 else {
                print("\(responseData)")
                return
            }
            
            
            let posts = jsonDictionary.flatMap { Post(dictioanry: $0.value, identifier: $0.key) }
            let sortedPosts = posts.sorted(by: { $0.0.timestamp > $0.1.timestamp} )
            self.posts = sortedPosts
            DispatchQueue.main.async {
                completion(sortedPosts)
            }
            
        }
        
        
    }
    
}

protocol PostControllerDelegate: class {
    func postsWereUpdatedTo(posts: [Post], on postController: PostController )
}
