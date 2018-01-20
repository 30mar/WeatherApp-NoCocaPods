//
//  LoginViewController.swift
//  PhotoWeatherApp
//
//  Created by Macbook on 1/19/18.
//  Copyright © 2018 Macbookodev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    
    var image:UIImage?
    //instantiating facebook login button
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
        
    }()

    override func viewWillAppear(_ animated: Bool) {
        print(loginButton.titleLabel?.text!)
        if loginButton.titleLabel?.text! == "Log out"{
            shareButton.isEnabled = true
            shareButton.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.3490196078, blue: 0.5960784314, alpha: 1)
        }
        else{
         shareButton.isEnabled == false
            shareButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        super.viewWillAppear(true)
        self.imageBackground.image = image!
    }
    
    override func viewDidLoad() {
        //setting facebook login button position and assigning the delagte to this viewController
        super.viewDidLoad()
        view.addSubview(loginButton)
        loginButton.center = view.center
        loginButton.delegate = self
    }

    @IBAction func logoutPressed(_ sender: Any) {
        //loging out from facebook session
        let loginManager = FBSDKLoginManager()
        loginManager.logOut() // this is an instance function
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backPressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
}
extension LoginViewController:FBSDKLoginButtonDelegate{
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        shareButton.isEnabled = false
        shareButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if result.isCancelled == false{
            if loginButton.titleLabel?.text! == "Log out"{
                self.shareButton.isEnabled = true
                    shareButton.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.3490196078, blue: 0.5960784314, alpha: 1)
                    
                }
            }    
        }
  
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    }

extension LoginViewController:FBSDKSharingDelegate{
    
    @IBAction func buttonPressed(_ sender: Any) {
        // sharing into Facebook by making a sharephoto conttent and then adding a new shrephoto to it with our image inside it. showing this in the end in the  shareDialog.
        let content = FBSDKSharePhotoContent()
        content.photos =  [FBSDKSharePhoto(image: image!, userGenerated: true)]
        let dialog = FBSDKShareDialog()
        dialog.fromViewController = self
        dialog.shareContent = content
        dialog.delegate = self
        dialog.mode = FBSDKShareDialogMode.native
        dialog.show()
    }
    //Protocol functions Doesn't need implementation
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
    }
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
    }
    
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
    }
}
