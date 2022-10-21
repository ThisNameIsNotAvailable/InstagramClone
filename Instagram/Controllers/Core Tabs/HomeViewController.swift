//
//  ViewController.swift
//  Instagram
//
//  Created by Alex on 21/10/2022.
//

import UIKit
import FirebaseAuth

class HomeViewController: InitialViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }

    func handleNotAuthenticated() {
        // Check auth status
        if FirebaseAuth.Auth.auth().currentUser == nil {
            // Show log in VC
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }

}

