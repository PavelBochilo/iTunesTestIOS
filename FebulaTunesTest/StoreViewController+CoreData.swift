//
//  StoreViewController+CoreData.swift
//  FebulaTunesTest
//
//  Created by Paul on 21.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import AnotherFramework

extension StoreViewController {
  
  
  
  func loadDataFromContainer() {
    indicator.startAnimating()
    clearButton.isHidden = true
    coreDataQueue.async(flags: .barrier) {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let managedContext = appDelegate.persistentContainer.viewContext
      let entity = NSEntityDescription.entity(forEntityName: "TunesUnit", in: managedContext)
      let fetchRequest:NSFetchRequest<TunesUnit> = TunesUnit.fetchRequest()
      fetchRequest.entity = entity
      do {
        let result = try managedContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        let resultOpt = result as? [TunesUnit]
        if let arrayResult = resultOpt {
          DispatchQueue.main.async {
            self.uinitsArray = arrayResult
            print(self.uinitsArray)
            self.tableView.reloadData()
            self.clearButton.isHidden = false
            self.preparationsCompleted()
          }
        }
      } catch let error as NSError {
        print("No fetch with error: \(error)")
        DispatchQueue.main.async {
          self.preparationsCompleted()
        }
      }
    }
  }
  
  func deleteSelectedRowWithAnimation(row:Int, unit:TunesUnit) {
    let index = IndexPath(row: row, section: 0)
    coreDataQueue.async(flags: .barrier) {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let managedContext = appDelegate.persistentContainer.viewContext
      managedContext.delete(unit)
      do {
        try managedContext.save()
        DispatchQueue.main.async {
          self.audioPlayer.play()
          self.uinitsArray.remove(at: row)
          self.tableView.deleteRows(at: [index], with: .automatic)
        }
      } catch let error as NSError {
        print("Error While Deleting Note: \(error.userInfo)")
      }
    }
  }
  
  func loadingPlayer() {
    let music = Bundle.main.path(forResource: "bell", ofType: "mp3")
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: music! ))
      try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
      try AVAudioSession.sharedInstance().setActive(true)
    }
    catch{
      print(error)
    }
  }
  
  func preparationsCompleted() {
    DispatchQueue.main.async {
      self.indicator.stopAnimating()
      self.tableView.isHidden = false
    }
  }
}
