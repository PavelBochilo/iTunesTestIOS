//
//  ViewController+CoreData.swift
//  FebulaTunesTest
//
//  Created by Paul on 21.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import UIKit
import CoreData

extension ViewController {
  
  //MARK: - First of all convert Image and then save it in CoreData as NSData
  
  func convertImageAndSaveUintInCoreData(trackId:Double, name:String, image:UIImage) {
    
    // access the NSManagedObjectContext located in the AppDelegate.swift
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    let tUnit = TunesUnit(context: managedContext)
    
    // make image grayScale
    let imageGrayScale = convertToBlackAndWhite(image: image)
    
    // go convert process async in created for it queue
    
    convertQueue.async {
      guard let imageThumbData = UIImageJPEGRepresentation(imageGrayScale!, 0.7) else {
        print("convertError")
        return
      }
      
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let managedContext = appDelegate.persistentContainer.viewContext
      let entity = NSEntityDescription.entity(forEntityName: "TunesUnit", in: managedContext)
      let fetchRequest:NSFetchRequest<TunesUnit> = TunesUnit.fetchRequest()
      fetchRequest.entity = entity
      self.saveDataQueue.async(flags: .barrier){
        let dataOpt = imageThumbData as NSData?
        if let imageTuneData = dataOpt {
          tUnit.imageData = imageTuneData
          tUnit.trackName = name
          tUnit.trackId = trackId
          appDelegate.saveContext()
        }
      }
    }
  }
  
  // MARK: - function with CoreImages filters with convertong them to black and white
  
  func convertToBlackAndWhite(image:UIImage) -> UIImage?
  {
    //first do color controls
    let ciImage = CIImage(image:image)
    let filterOpt = CIFilter(name: "CIColorControls")
    if let filter = filterOpt {
      filter.setValue(ciImage, forKey: kCIInputImageKey)
      filter.setValue(0.0, forKey: kCIInputBrightnessKey)
      filter.setValue(0.0, forKey: kCIInputSaturationKey)
      filter.setValue(1.1, forKey: kCIInputContrastKey)
      
      let intermediateImage = filter.outputImage
      
      let filter1Opt = CIFilter(name:"CIExposureAdjust")
      
      if let filter1 = filter1Opt {
        filter1.setValue(intermediateImage, forKey: kCIInputImageKey)
        filter1.setValue(0.7, forKey: kCIInputEVKey)
        let output = filter1.outputImage
        
        let context = CIContext(options: nil)
        let cgImage = context.createCGImage(output!, from: output!.extent)
        return UIImage(cgImage: cgImage!, scale: image.scale, orientation: image.imageOrientation)
      }
    }
    
    return UIImage(cgImage: ciImage as! CGImage, scale: image.scale, orientation: image.imageOrientation)
  }
  
  //MARK: -AlertController with message
  func alertController() {
   self.presentAlertWithTitle(title: "Title", messageString: "Please fill the textfield")
}
}

