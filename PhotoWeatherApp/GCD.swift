//
//  GCD.swift
//  PhotoWeatherApp
//
//  Created by Macbook on 1/19/18.
//  Copyright © 2018 Macbookodev. All rights reserved.
//

import Foundation
func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
