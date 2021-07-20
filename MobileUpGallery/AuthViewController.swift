//
//  ViewController.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 20.07.2021.
//

import UIKit
import VK_ios_sdk


class AuthViewController: UIViewController {
    
    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        authService = SceneDelegate.shared().authService
        
    }
    @IBAction func enterButton(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    

}

