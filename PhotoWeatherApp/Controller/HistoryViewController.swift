//
//  HistoryVC.swift
//  PhotoWeatherApp
//
//  Created by Macbook on 1/19/18.
//  Copyright © 2018 Macbookodev. All rights reserved.
//

import UIKit
import CoreData
class HistoryViewController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet weak var collection: UICollectionView!
    var imagesArray:[WeatherPhoto]?
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistantContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
       // print("historrrryyy") 
    }

    @IBAction func backPressed(_ sender: Any) {
        for item in imagesArray!{
            context.delete(item)
            appDelegate.saveContext()
        }
        dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        do{
            imagesArray = try context.fetch(WeatherPhoto.fetchRequest())
            print("the count is \(imagesArray?.count)")
        }catch{
            debugPrint(error)
        }
       // collection.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray!.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ModifiedCellCollectionViewCell
        let currentObject = imagesArray![(indexPath as NSIndexPath).row]
        if let currentImage = currentObject.image as? Data{
            cell.image.image = UIImage(data: currentImage)
            cell.image.contentMode = .scaleAspectFill
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}
