//
//  MainViewController.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/12/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol HomeViewProtocol {
    
    var presenter: HomePresenter? { get set }
    
    func setHomeTitle(forUsername name: String?)
    func setPosts(posts: [Post])
    func showNoPost()
}

class MainViewController: UIViewController {

    @IBOutlet weak var postTable: UITableView!
    @IBOutlet var emptyView: UIView!
    
    var presenter: HomePresenter?
    
    fileprivate var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logout))
        
        postTable.dataSource = self
        postTable.delegate = self
        let postNib = UINib(nibName: "PostView", bundle: nil)
        postTable.register(postNib, forCellReuseIdentifier: "PostView")
        postTable.estimatedRowHeight = 90.0
        
        presenter?.onSetHomeTitle()
        presenter?.loadPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func logout(){
        presenter?.onLogout()
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostView", for: indexPath) as? PostView else {
            fatalError("Invalid index path")
        }
        cell.post = posts[indexPath.row]
        cell.separator.isHidden = (indexPath.row == posts.count - 1)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.navigateToPost(post: posts[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension MainViewController: HomeViewProtocol {
    
    func setHomeTitle(forUsername name: String?) {
        var titleString = ""
        if let name = name {
            titleString += name + "'s "
        }
        titleString += "Home"
        title = titleString
    }
    
    func setPosts(posts: [Post]) {
        self.posts = posts
        self.postTable.reloadData()
    }
    
    func showNoPost() {
        self.posts.removeAll()
        self.postTable.tableFooterView = emptyView
        self.postTable.reloadData()
    }
}
