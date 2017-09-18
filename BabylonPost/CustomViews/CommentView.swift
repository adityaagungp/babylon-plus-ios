//
//  CommentView.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/13/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import UIKit

class CommentView: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var separator: UIView!
    
    var comment: Comment! {
        didSet {
            if let comment = comment {
                nameLabel.text = comment.name
                emailLabel.text = comment.email
                commentLabel.text = comment.body
                nameLabel.sizeToFit()
                emailLabel.sizeToFit()
                commentLabel.sizeToFit()
            }
        }
    }
}
