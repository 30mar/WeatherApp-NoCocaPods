//
//  CameraViewController.swift
//  PhotoWeatherApp
//
//  Created by Macbook on 1/19/18.
//  Copyright © 2018 Macbookodev. All rights reserved.
//

import CoreLocation
import UIKit
import CoreData
class CameraViewController: UIViewController, CLLocationManagerDelegate {
   
    @IBOutlet weak var loadingLAbel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var watherIcon: UIImageView!
    @IBOutlet weak var subCondition: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var overlayView: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var humedityLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var takePhotoLabel: UILabel!
    
    var country:String?
    var humedity:String?
    var capitalWithCountry:String?
    var tempreture:String?
    var weatherConditon:String?
    var weatherSubCondition:String?
    var iconUrl: String?
    var iconImage:UIImage?
    var locationManager: CLLocationManager!
    var weatherImage:UIImage?
    
    //Defining the appDelegate and the context to interact with coredata
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistantContainer.viewContext
    
    // location manager setup so we can get user coordinates in the beginning and get the weather for that coordinates
        override func viewDidLoad() {
        loadingLAbel.isHidden = false
        activity.startAnimating()
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        
    }
    
    // this function is called everytime the user changes his/her location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
            //getting user coordinates
            let locValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
            print("locations = \(locValue.latitude) longtude: \(locValue.longitude)")
            NetworkCode.sharedInstance().getWeatherDetails(latitude: locValue.latitude, longitude: locValue.longitude, completionHandler: { (success, city, temp, weather, subweather, icon,country,humedity) in
                if success{
                    //this is the function from the GCD file, it allow jumping into the main thread to preform some updates and then returns to background thread
                    performUIUpdatesOnMain {
                        let correctCity = city!.replacingOccurrences(of: "testing", with: "Cairo")
                        self.capitalWithCountry = "\(correctCity), \(country!)"
                        self.weatherConditon = weather!
                        self.tempreture = "\(temp!)°"
                        self.weatherSubCondition = subweather!
                        self.country = country!
                        self.humedity = "humidity: \(humedity!)%"
                        self.iconUrl = icon!
                        self.activity.stopAnimating()
                        self.welcomeLabel.isHidden = false
                        self.takePhotoLabel.isHidden = false
                        self.loadingLAbel.isHidden = true
                        self.cameraButton.isEnabled = true
                        }
                   
                }})

        }}
        
    @IBAction func donePressed(_ sender: Any) {
        doneButton.isEnabled = false
        // Generate a combiled photo from the camera output and the weather data
        self.weatherImage = generateFinalPhoto()
        //create a new entity to be saved
        let newPhoto = WeatherPhoto(entity: WeatherPhoto.entity(), insertInto: context)
        // convert ui representation to binary data to allow saving in coredata
        newPhoto.image = UIImagePNGRepresentation(self.weatherImage!) as NSData?
        //saving into coredata
        appDelegate.saveContext()
        //presenting the next viewcontroller: Hiroey viewcontroller
        let controller = storyboard?.instantiateViewController(withIdentifier: "history") as! HistoryViewController
        present(controller, animated: true, completion: nil)
        
        
    }
 
    @IBAction func CameraPressed(_ sender: Any) {
        self.welcomeLabel.isHidden = true
        self.takePhotoLabel.isHidden = true
        chooseSource(sourceType: .camera)
        NetworkCode.sharedInstance().downloadIcon(icon: iconUrl!, completion: { (success, image) in
            if success{
                performUIUpdatesOnMain {
                    self.iconImage = image
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
        humedityLabel.isHidden = false
    }
}
    
extension CameraViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            background.contentMode = .scaleAspectFill
            background.image = pickedImage
            
        }
        unHideOverlay()
        city.text = capitalWithCountry
        condition.text = weatherConditon!
        subCondition.text = weatherSubCondition!
        temp.text = tempreture
        watherIcon.image = iconImage!
        doneButton.isEnabled = true
        humedityLabel.text = humedity!
        dismiss(animated: true, completion: nil)
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func hideBarsAndButtons(hide: Bool) {
        toolbar.isHidden = hide
        self.navigationController?.setNavigationBarHidden(hide, animated: true)
    }
    func generateFinalPhoto() -> UIImage {
        // This is the photo that will be stored in coredata and will be shared later
        // Hide toolbar and navbar
        hideBarsAndButtons(hide: true)
        // Render view to an image , i.e: cobine all visual layers to form an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        // Show toolbar and navbar
        hideBarsAndButtons(hide: false)
        return memedImage
    }
    
}
