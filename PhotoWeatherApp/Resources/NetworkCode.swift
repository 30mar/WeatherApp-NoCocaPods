//
//  NetworkCode.swift
//  PhotoWeatherApp
//
//  Created by Macbook on 1/19/18.
//  Copyright © 2018 Macbookodev. All rights reserved.
//

import Foundation
import UIKit
let apiKey = "65503122517102020442c688f21cdc72"

class NetworkCode{
   
    func getWeatherDetails(latitude: Double,longitude:Double,completionHandler:@escaping (_ success:Bool,_ cityName:String?,_ temp: Double?,_ weatherCondition:String?,_ subWeatherCondition:String?,_ photoId:String?,_ country:String?,_ humidity:Double?)->()){
        
        /* 1. Set the parameters */
        var address = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&APPID=\(apiKey)&units=metric"
        print(address)
        /* 2/3. Build the URL, Configure the request */
        let request = URLRequest(url: URL(string: address)!)
        /* 4. Make the request */
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // if an error occurs, print it and re-enable the UI
            func displayError(_ error: String) {
                print(error)
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                displayError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                displayError("No data was returned by the request!")
                return
            }
            
            /* 5. Parse the data */
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            } catch {
                displayError("Could not parse the data as JSON: '\(data)'")
                return
            }
            
            /* GUARD: Is the "request_token" key in parsedResult? */
            guard let cityName = parsedResult["name"] as? String else {
                displayError("Cannot find name key in \(parsedResult)")
                return
            }
            print("city name is: \(cityName)")
            guard let weatherArray = parsedResult["weather"] as? [[String:Any]] else {
                displayError("Cannot find weather key in \(parsedResult)")
                return
            }
            
            guard let mainCondition = weatherArray.first!["main"] as? String else {
                displayError("Cannot find main key in \(parsedResult)")
                return
            }
            
            guard let subCondition = weatherArray.first!["description"] as? String else {
                displayError("Cannot find description key in \(parsedResult)")
                return
            }
            
            guard let icon = weatherArray.first!["icon"] as? String else {
                displayError("Cannot find icon key in \(parsedResult)")
                return
            }
            
            guard let mainTemp = parsedResult["main"] as? [String:Double] else {
                displayError("Cannot find main key in \(parsedResult)")
                return
            }
            
            guard let temp = mainTemp["temp"] else {
                displayError("Cannot find temp key in \(parsedResult)")
                return
            }
            guard let humidity = mainTemp["humidity"] else {
                displayError("Cannot find humidity key in \(parsedResult)")
                return
            }
            guard let sys = parsedResult["sys"] as? [String:Any] else {
                displayError("Cannot find sys key in \(parsedResult)")
                return
            }
            guard let country = sys["country"] as? String else {
                displayError("Cannot find country key in \(parsedResult)")
                return
            }
            print(cityName)
            print(temp)
            print(mainCondition)
            print(subCondition)
            print(icon)
            print(humidity)

            /* 6. Use the data! */
            completionHandler(true,cityName, temp, mainCondition, subCondition, icon,country,humidity)
        }

        /* 7. Start the request */
        task.resume()

    }
    func downloadIcon(icon:String,completion: @escaping(_ success:Bool, _ image:UIImage?)->()){
        let imageURL = URL(string: "http://openweathermap.org/img/w/\(icon).png")
        let task = URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
            guard error == nil else {
            return debugPrint(error)
            }
                // create image
                let downloadedImage = UIImage(data: data!)
                // update UI on a main thread
            completion(true, downloadedImage)
            }
            task.resume()
        
        }
    

    class func sharedInstance()->NetworkCode{
        struct singleton{
            static var instance = NetworkCode()
        }
        return singleton.instance
    }

}





