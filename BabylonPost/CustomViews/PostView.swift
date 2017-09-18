//
//  PostView.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/12/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import UIKit

class PostView: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var separator: UIView!
    
    var post: Post!{
        didSet {
            if let post = post {
                lblTitle.text = post.title
                lblTitle.sizeToFit()
            }
        }
    }
}
