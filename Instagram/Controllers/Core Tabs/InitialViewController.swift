//
//  InitialViewController.swift
//  Instagram
//
//  Created by Alex on 21/10/2022.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [
                .foregroundColor : UIColor.label]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            tabBarController?.tabBar.standardAppearance = appearance
            tabBarController?.tabBar.scrollEdgeAppearance = appearance
        }
    }
}
