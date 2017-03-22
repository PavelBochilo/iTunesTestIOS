//
//  StoreViewController.swift
//  FebulaTunesTest
//
//  Created by Paul on 20.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class StoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  // MARK: - Properties
  @IBOutlet weak var tableView: UITableView!
  let xibCellName = "BaseCell"
  var uinitsArray:[TunesUnit] = []
  @IBOutlet weak var indicator: UIActivityIndicatorView!
  @IBOutlet weak var clearButton: UIButton!
  var audioPlayer = AVAudioPlayer()
  
  
  let coreDataQueue = DispatchQueue(label: "save.data.queue", qos: .utility, attributes:.concurrent)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadingPlayer()
    loadDataFromContainer()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellId = String.init(format: "baseCell%d", indexPath.row)    
    tableView.register(UINib(nibName: xibCellName, bundle: nil), forCellReuseIdentifier: cellId)
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MXBaseCell    
    cell.configureCell(tunesData: uinitsArray[indexPath.row], viewController: self)
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return uinitsArray.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 135
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let iUnit = uinitsArray[indexPath.row]
      deleteSelectedRowWithAnimation(row: indexPath.row, unit: iUnit)
    }
  }
  
  @IBAction func clearAction(_ sender: UIButton) {
    alertController()
  }
  
  func alertController() {
    let alertController = UIAlertController(title: "Title", message: "Do you really want to delete all items in store?", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
      UIAlertAction in
      self.clearAllData()
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
      UIAlertAction in
      alertController.dismiss(animated: true, completion: nil)
    }
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
  func clearAllData() {
    DispatchQueue.main.async {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let managedContext = appDelegate.persistentContainer.viewContext
      let entity = NSEntityDescription.entity(forEntityName: "TunesUnit", in: managedContext)
      let fetchRequest:NSFetchRequest<TunesUnit> = TunesUnit.fetchRequest()
      fetchRequest.entity = entity
      let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TunesUnit")
      let request = NSBatchDeleteRequest(fetchRequest: fetch)
      do {
        let result = try managedContext.execute(request)
        print("clean completed \(result)")
        self.uinitsArray = []
        self.tableView.reloadData()
      } catch let error as NSError {
        print("\(error)")
      }
    }
    
    
  }
}
