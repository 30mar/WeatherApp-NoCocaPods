//
//  HistoryViewController.swift
//  PhotoWeatherApp
//
//  Created by Macbook on 1/19/18.
//  Copyright © 2018 Macbookodev. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

  
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imagesArray:[UIImage]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (imagesArray?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ModifiedCellCollectionViewCell
        cell.image.image = imagesArray![(indexPath as NSIndexPath).row]
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

}
