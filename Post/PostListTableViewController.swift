//
//  PostListTableViewController.swift
//  Post
//
//  Created by Christian McMullin on 2/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController, PostControllerDelegate {
    
    let postController = PostController()
    
    func postsWereUpdatedTo(posts: [Post], on postController: PostController) {
        tableView.reloadData()
    }
    @IBAction func refreshControl(_ sender: Any) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        postController.fetchPosts { (posts) in
           
            self.postController.posts = posts
        }
        refreshControl?.endRefreshing()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        
        PostController.shared.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.shared.posts.count
    
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        let post = PostController.shared.posts[indexPath.row]
        
        cell.textLabel?.text = post.text
        cell.detailTextLabel?.text = "\(post.username) \(post.timestamp) \(indexPath.row)"
        
        return cell
    }
    
}
