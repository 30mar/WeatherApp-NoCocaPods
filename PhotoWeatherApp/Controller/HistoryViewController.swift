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
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistantContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
    }
    
    @IBAction func ClearPressed(_ sender: Any) {
        // removing every item from the coredata and emptying the datasource array
        for item in imagesArray!{
            context.delete(item)
            appDelegate.saveContext()
            imagesArray?.removeAll()
        }
        imagesArray?.removeAll()
        collection.reloadData()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //Adjusting the spacing between cells
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let width = floor(self.collection.frame.size.width/3)
        layout.itemSize = CGSize(width: width, height: width)
        collection.collectionViewLayout = layout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //Trying to fetch photos from coredata
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
        //Converting binary data to uiimage
        if let currentImage = currentObject.image as? Data{
            cell.image.image = UIImage(data: currentImage)
            cell.image.contentMode = .scaleAspectFill
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentObject = imagesArray![(indexPath as NSIndexPath).row]
       
        guard let currentImage = currentObject.image as? Data else{
            return
        }
        let controller = storyboard?.instantiateViewController(withIdentifier: "full") as! ImageViewController
        controller.image = UIImage(data: currentImage)
        self.present(controller, animated: true, completion: nil)
        }

    }
    

