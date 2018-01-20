//
//  FacebookShareViewController.swift
//  PhotoWeatherApp
//
//  Created by Macbook on 1/20/18.
//  Copyright © 2018 Macbookodev. All rights reserved.
//

import UIKit

class FacebookShareViewController: UIViewController,FBSDKSharingDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var image: UIImage?
    let shareButton=FBSDKShareButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        //let photoToBeShared = FBSDKSharePhoto(image: image!, userGenerated: true)
        let content = FBSDKSharePhotoContent()
       // content.photos = [photoToBeShared]
        shareButton.shareContent = content
        self.view.addSubview(shareButton)
        shareButton.center = view.center
//        let dialog : FBSDKShareDialog = FBSDKShareDialog()
//        dialog.fromViewController = self
//        dialog.shareContent = content
//        dialog.mode = FBSDKShareDialogMode.feedWeb
//        dialog.show()
            }


    @IBAction func logoutPressed(_ sender: Any) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut() // this is an instance function
        dismiss(animated: true, completion: nil)
    }
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        
    }
    @IBAction func buttonPressed(_ sender: Any) {
        let content = FBSDKSharePhotoContent()
        content.photos =  [FBSDKSharePhoto(image: image!, userGenerated: true)]
        let dialog = FBSDKShareDialog()
        dialog.fromViewController = self
        dialog.shareContent = content
        dialog.delegate = self
        dialog.mode = FBSDKShareDialogMode.native
        dialog.show()
    }
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
    }
    
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
    }
    
}
