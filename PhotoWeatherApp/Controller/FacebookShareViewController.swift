//
//  FacebookShareViewController.swift
//  PhotoWeatherApp
//
//  Created by Macbook on 1/20/18.
//  Copyright © 2018 Macbookodev. All rights reserved.
//

import UIKit

class FacebookShareViewController: UIViewController,FBSDKSharingDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func validate() throws {
        print("dfs")
    }
    let x = FBSDKShareDialog()
    let shareButton=FBSDKShareButton()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        guard let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        let photoToBeShared = FBSDKSharePhoto(image: pickedImage, userGenerated: true)
        let content = FBSDKSharePhotoContent()
        content.photos = [photoToBeShared]
       try FBSDKShareDialog.show(from: self, with: content, delegate: nil)
       shareButton.shareContent = content
        self.view.addSubview(shareButton)
        shareButton.center = view.center
        print("the content is \(shareButton.shareContent)")

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickPeessed(_ sender: Any) {
        chooseSource(sourceType: .photoLibrary)
    }
    
    
    func chooseSource (sourceType:UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion: nil)
        
    }

    @IBAction func logoutPressed(_ sender: Any) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut() // this is an instance function
        dismiss(animated: true, completion: nil)
    }
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        
    }
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
    }
    
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
    }
    
}
