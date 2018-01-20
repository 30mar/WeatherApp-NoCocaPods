//
//  LoginViewController.swift
//  PhotoWeatherApp
//
//  Created by Macbook on 1/19/18.
//  Copyright © 2018 Macbookodev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var image:UIImage
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginButton)
        loginButton.center = view.center
        loginButton.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func backPressed(_ sender: Any)
    {dismiss(animated: true, completion: nil)
    }
    
}
extension LoginViewController:FBSDKLoginButtonDelegate{
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
  
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if result.isCancelled == false{
            let controller = storyboard?.instantiateViewController(withIdentifier: "shareFB") as? FacebookShareViewController
            present(controller!, animated: true, completion: nil)
        }
    }
    

    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }

}
