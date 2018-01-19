//
//  WeatherPhoto+CoreDataProperties.swift
//  PhotoWeatherApp
//
//  Created by Macbook on 1/19/18.
//  Copyright © 2018 Macbookodev. All rights reserved.
//
//

import Foundation
import CoreData


extension WeatherPhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherPhoto> {
        return NSFetchRequest<WeatherPhoto>(entityName: "WeatherPhoto")
    }

    @NSManaged public var image: NSData?

}
