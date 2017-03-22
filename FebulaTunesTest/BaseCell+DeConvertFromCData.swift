//
//  BaseCell+DeConvertFromCData.swift
//  FebulaTunesTest
//
//  Created by Paul on 21.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import UIKit
import CoreData


extension MXBaseCell {
  
  func deconvertionToImageAndDisplay(unit: TunesUnit)  {
    deConvertQueue.async {
      let imageDataOpt = unit.imageData as? Data
      if let imageData = imageDataOpt {
        let image = UIImage(data:imageData,scale:1.0)
        DispatchQueue.main.async {
          self.thumbImageView.image = image
        }
      }
    }
  }
  
  func matchDuplications(name:String, delegate:Bool)  {
    DispatchQueue.global().async {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let managedContext = appDelegate.persistentContainer.viewContext
      let entity = NSEntityDescription.entity(forEntityName: "TunesUnit", in: managedContext)
      let fetchRequest:NSFetchRequest<TunesUnit> = TunesUnit.fetchRequest()
      fetchRequest.entity = entity
      let pred = NSPredicate(format: "trackId == %@", name)
      fetchRequest.predicate = pred
      do {
        let results =
          try managedContext.fetch(fetchRequest as!
            NSFetchRequest<NSFetchRequestResult>)
        if results.count > 0 {
          DispatchQueue.main.async {
            if delegate == true {
              print("Core date already saved this Unit! There is no need to save it")
            } else {
            self.matchedView.isHidden = false
            }
          }
        } else {
          DispatchQueue.main.async {
            if delegate == true {
              if self.cellDelegate != nil {
                self.cellDelegate?.addToStorePressed(trackId: self.trackId, name: self.trackName, image: self.imageThumb)
                self.matchedView.isHidden = false
              }
            } else {
            self.matchedView.isHidden = true
            }
          }
        }
      } catch let error {
        print("No fetch with error: \(error)")
      }
    }
  }
  
}
