//
//  PostDetailViewController.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/13/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import UIKit
import TTTAttributedLabel

protocol PostDetailView {
    
    var presenter: PostPresenter? { get set }
    
    func showPost(post: Post)
    func onPostNotAvailable()
    func setAuthor(user: User?)
    func onAuthorNotAvailable()
    func setComments(comments: [Comment])
    func setNoComment()
}

class PostDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: TTTAttributedLabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet var postView: UIView!
    @IBOutlet weak var commentTable: UITableView!
    
    var comments = [Comment]()
    
    var presenter: PostPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Post Details"
        commentTable.dataSource = self
        let commentNib = UINib(nibName: "CommentView", bundle: nil)
        commentTable.register(commentNib, forCellReuseIdentifier: "CommentView")
        commentTable.estimatedRowHeight = 90.0
        authorLabel.enabledTextCheckingTypes = NSTextCheckingAllTypes
        authorLabel.delegate = self
        presenter?.loadPostData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PostDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentView", for: indexPath) as?CommentView else {
            fatalError("Invalid index path")
        }
        cell.comment = comments[indexPath.row]
        return cell
    }
}

extension PostDetailViewController: TTTAttributedLabelDelegate {
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        presenter?.navigateToAuthor()
    }
}

extension PostDetailViewController: PostDetailView {
    
    func showPost(post: Post) {
        titleLabel.text = post.title
        content.text = post.body
        titleLabel.sizeToFit()
        content.sizeToFit()
        postView.frame.size.height = content.frame.maxY + (self.navigationController?.navigationBar.frame.size.height)! + 40.0
        postView.layoutIfNeeded()
        commentTable.tableHeaderView = postView
    }
    
    func onPostNotAvailable() {
        let alert = UIAlertController(title: "Post not available", message: "Post doesn't exist or failed to load", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.navigationController?.popViewController(animated: true)})
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func setAuthor(user: User?) {
        if let user = user {
            let linkAttributes = [NSForegroundColorAttributeName : UIColor.green]
            authorLabel.linkAttributes = linkAttributes
            authorLabel.activeLinkAttributes = linkAttributes
            let nameText = "by \(user.name!)"
            authorLabel.text = nameText
            let nsString = (nameText as NSString).range(of: nameText)
            let url = URL(string: "action://users/\(user.name!)")
            authorLabel.addLink(to: url, with: nsString)
        }
    }
    
    func onAuthorNotAvailable() {
        setAuthor(user: nil)
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
