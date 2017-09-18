//
//  UserDetailViewController.swift
//  BabylonPost
//
//  Created by Aditya Agung Putra on 9/14/17.
//  Copyright © 2017 Aditya Agung Putra. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showUserData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showUserData(){
        if let user = user {
            title = user.name
            nameLabel.text = user.name
            emailLabel.text = user.email
            if let address = user.address {
                addressLabel.text = "\(address.street ?? "") \(address.suite ?? "")\n\(address.city ?? "")"
            }
            if let company = user.company {
                companyLabel.text = "\(company.name ?? "") (\(company.bs ?? ""))"
            }
        } else {
            title = "User Details"
            let alert = UIAlertController(title: "User not available", message: "User doesn't exist or failed to retrieve user's details", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.navigationController?.popViewController(animated: true)})
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
