//
//  ImageViewController.swift
//  PhotoWeatherApp
//
//  Created by Macbook on 1/19/18.
//  Copyright © 2018 Macbookodev. All rights reserved.
//

import UIKit
class ImageViewController: UIViewController {
    
    var image:UIImage?
    
    @IBOutlet weak var finalImage: UIImageView!
   
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
 
    @IBAction func sharePressed(_ sender: Any) {
        let alert = UIAlertController(title: "Share", message: "Share your weather photo", preferredStyle: .actionSheet)
        let FacebookAction = UIAlertAction(title: "Share on Facebook", style: .default) { (action) in
         self.performSegue(withIdentifier: "facebook", sender: self)
        }
        //add action to action sheet
        alert.addAction(FacebookAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finalImage.image = self.image!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier! == "facebook"{
            let controller = segue.destination as! LoginViewController
            controller.image = image!
        }
    }
}
