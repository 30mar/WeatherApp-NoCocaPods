//
//  ViewController.swift
//  PhotoWeatherApp
//
//  Created by Macbook on 1/19/18.
//  Copyright © 2018 Macbookodev. All rights reserved.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var watherIcon: UIImageView!
    @IBOutlet weak var subCondition: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var overlayView: UIImageView!
    @IBOutlet weak var background: UIImageView!
    
    var cityName:String?
    var tempreture:String?
    var weatherConditon:String?
    var weatherSubCondition:String?
    var iconUrl: String?
    var iconImage:UIImage?
    var locationManager: CLLocationManager!
    // location manager setup so we can get user coordinates in the beginning and get the weather for that coordinates
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        
    }  //ViewDidLoad
    // this function is called everytime the user changes his/her location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
            //getting user coordinates
            let locValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
            print("locations = \(locValue.latitude) longtude: \(locValue.longitude)")
            NetworkCode.sharedInstance().getWeatherDetails(latitude: locValue.latitude, longitude: locValue.longitude, completionHandler: { (success, city, temp, weather, subweather, icon) in
                if success{
                    performUIUpdatesOnMain {
                        self.cityName = city!
                        self.weatherConditon = weather!
                        self.tempreture = "\(temp!)'C"
                        self.weatherSubCondition = subweather!
                        self.iconUrl = icon!
                    }
                   
                }})

        }}
        
    @IBAction func CameraPressed(_ sender: Any) {
        
        chooseSource(sourceType: .camera)
        NetworkCode.sharedInstance().downloadIcon(icon: iconUrl!, completion: { (success, image) in
            if success{
                performUIUpdatesOnMain {
                    self.iconImage = image
                    print("imaaaage \(image)")
                }
            }
        })
    }
    
    
    func chooseSource (sourceType:UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    func unHideOverlay(){
        overlayView.isHidden = false
        city.isHidden = false
        condition.isHidden = false
        subCondition.isHidden = false
        temp.isHidden = false
        watherIcon.isHidden = false
    }
}
    
extension ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            background.contentMode = .scaleAspectFill
            background.image = pickedImage
            
        }
//        saveButton.isEnabled = true
//        shareButton.isEnabled = true
        unHideOverlay()
        city.text = cityName
        condition.text = weatherConditon!
        subCondition.text = weatherSubCondition!
        temp.text = tempreture
        watherIcon.image = iconImage!
        dismiss(animated: true, completion: nil)
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
