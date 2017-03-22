//
//  BaseCell.swift
//  FebulaTunesTest
//
//  Created by Paul on 20.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import UIKit


class MXBaseCell: UITableViewCell {
  
  // MARK: - Properties
  @IBOutlet weak var matchedView: UIImageView!
  @IBOutlet weak var storeButton: RoundedButton!
  @IBOutlet weak var labelName: UILabel!
  @IBOutlet weak var thumbImageView: UIImageView!
  weak var cellDelegate:BaseCellDelegate?
  var trackId:Double = 0.0
  var trackName = "n/a"
  var imageThumb = UIImage()
  
  let deConvertQueue = DispatchQueue(label: "convert.queue", qos: .utility, attributes:.concurrent)
  
  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none
  }
  
  // MARK: - Function for filling cell with image and data
  
  func configureCell(tunesData:AnyObject, viewController: UIViewController) {
    let unitDictOpt = tunesData as? TunesUnit
    
    if let unitDict = unitDictOpt {
      configureCellFromCoreDataUnit(unit: unitDict)
    } else {
      let cellDictOpt = tunesData as? NSDictionary
      cellDelegate = viewController as? BaseCellDelegate
      storeButton.isUserInteractionEnabled = false
      storeButton.backgroundColor = UIColor.lightGray
      if let cellDict = cellDictOpt {
        let urlString = cellDict["artworkUrl100"] as? String
        if let imageUrl = urlString  {
          loadImage(urlString: imageUrl)
        }
        let trackNameOpt = cellDict["trackName"] as? String
        if let trackName = trackNameOpt {
          labelName.text = trackName
          self.trackName = trackName
        }
        let trackIdOpt = cellDict["trackId"] as? Double
        if let idTrack = trackIdOpt {
          trackId = idTrack
          let strNumber = String(format: "%.1f", idTrack)
          matchDuplications(name: strNumber, delegate:false)
        }
        
      }
    }
  }
  
  func configureCellFromCoreDataUnit(unit:TunesUnit) {
    storeButton.isHidden = true
    storeButton.isUserInteractionEnabled = true
    labelName.text = unit.trackName
    deconvertionToImageAndDisplay(unit: unit)
  }
  
  func loadImage(urlString:String) {
    let url = URL(string: urlString)
    DispatchQueue.global().async {
      let data = try? Data(contentsOf: url!)
      DispatchQueue.main.async {
        if data != nil {
          self.thumbImageView.image = UIImage(data: data!)
          self.storeButton.isUserInteractionEnabled = true
          self.storeButton.backgroundColor = UIColor.orange
          self.imageThumb = UIImage(data: data!)!
        }
      }
    }
  }
  
  @IBAction func addToStoreAction(_ sender: RoundedButton) {
    let strNumber = String(format: "%.1f", trackId)
    matchDuplications(name: strNumber, delegate:true)    
  }
}



protocol BaseCellDelegate: class {
  func addToStorePressed(trackId:Double, name:String, image:UIImage)
}
