//
//  PostDetailViewController.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/13/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class PostDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: TTTAttributedLabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet var postView: UIView!
    @IBOutlet weak var commentTable: UITableView!
    
    var post: Post?
    var author: User?
    var comments = [Comment]()
    var presenter: PostDetailPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Post Details"
        commentTable.dataSource = self
        presenter = PostDetailPresenter(self)
        let commentNib = UINib(nibName: "CommentView", bundle: nil)
        commentTable.register(commentNib, forCellReuseIdentifier: "CommentView")
        commentTable.estimatedRowHeight = 90.0
        authorLabel.enabledTextCheckingTypes = NSTextCheckingAllTypes
        authorLabel.delegate = self
        loadPostData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadPostData(){
        if let post = post {
            titleLabel.text = post.title
            content.text = post.body
            titleLabel.sizeToFit()
            content.sizeToFit()
            postView.frame.size.height = content.frame.maxY + (self.navigationController?.navigationBar.frame.size.height)! + 40.0
            postView.layoutIfNeeded()
            commentTable.tableHeaderView = postView
            presenter?.requestAuthor(userId: post.userId!)
            presenter?.requestComment(postId: post.id!)
        } else {
            
        }
    }
    
    fileprivate func navigateToAuthorDetails(){
        let userDetailVC = UserDetailViewController()
        userDetailVC.user = author
        self.navigationController?.pushViewController(userDetailVC, animated: true)
    }
}

extension PostDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentView", for: indexPath) as! CommentView
        cell.comment = comments[indexPath.row]
        return cell
    }
}

extension PostDetailViewController: TTTAttributedLabelDelegate {
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        navigateToAuthorDetails()
    }
}

extension PostDetailViewController: PostDetailView {
    
    func setAuthor(user: User?) {
        if let user = user {
            let linkAttributes = [NSForegroundColorAttributeName : UIColor.green]
            authorLabel.linkAttributes = linkAttributes
            authorLabel.activeLinkAttributes = linkAttributes
            author = user
            let nameText = "by \(user.name!)"
            authorLabel.text = nameText
            let nsString = (nameText as NSString).range(of: nameText)
            let url = URL(string: "action://users/\(user.name!)")
            authorLabel.addLink(to: url, with: nsString)
        }
    }
    
    func setComments(comments: [Comment]) {
        self.comments = comments
        commentTable.reloadData()
    }
    
    func setNoComment() {
        comments.removeAll()
        commentTable.reloadData()
    }
}