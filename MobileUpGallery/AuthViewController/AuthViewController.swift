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
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        authService = SceneDelegate.shared().authService
        button.layer.cornerRadius = 10
        
    }
    @IBAction func enterButton(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    

}

