//
//  ViewController.swift
//  FebulaTunesTest
//
//  Created by Paul on 20.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, BaseCellDelegate, PopupSearchMenuDelegate {
  
  
  @IBAction func searchAction(_ sender: UIBarButtonItem) {
    searchButton.isEnabled = false
    showSearchPopUp()
  }
  
  // MARK: - Properties
  @IBOutlet weak var tableView: UITableView!
  var cellSettings = [AnyObject]()
  var popUpView : PopupSearchMenu?
  let xibCellName = "BaseCell"
  var isMatchedArray:[Bool] = []
  var isFirstLoad = true
  var sourceStr = "sm"
  @IBOutlet weak var searchButton: UIBarButtonItem!
  
  //Mark: - Make two queues with higher priority against backGround: one for CoreData manipulations, another for UIImage conversions
  
  let convertQueue = DispatchQueue(label: "convert.queue", qos: .utility, attributes:.concurrent)
  let saveDataQueue = DispatchQueue(label: "save.data.queue", qos: .utility, attributes:.concurrent)
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tunesRequest(term: sourceStr)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    if isFirstLoad == false {
      tableView.reloadData()
    }
  }
  
  
  //MARK: TableView Delegate and DataSource
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellId = String.init(format: "baseCell%d", indexPath.row)
    tableView.register(UINib(nibName: xibCellName, bundle: nil), forCellReuseIdentifier: cellId)
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MXBaseCell
    cell.configureCell(tunesData: cellSettings[indexPath.row], viewController: self)
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellSettings.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 135
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
  
  // MARK: - Base search request
  
  func tunesRequest(term: String)  {
    let iTunesSearchR = iTunes()
    iTunesSearchR.search(for: term, ofType: .all(nil), options: nil) { result in
      switch result {
      case .success(let dataResponce):
        self.tableDataSource(data: dataResponce)
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func tableDataSource(data: AnyObject)  {
    let dataDictOpt  = data as? NSDictionary
    if let dataDict = dataDictOpt {
      let dataTuneArrayOpt = dataDict["results"] as? NSArray
      if let dataTuneArray = dataTuneArrayOpt {
        cellSettings = dataTuneArray as [AnyObject]
        isFirstLoad = false
        tableView.reloadData()
      }
    }
  }
  
  //MARK: - Show Popup menu with searching attributes
  
  func showSearchPopUp() {
    let popupOpt = Bundle.main.loadNibNamed("PopupSearchMenu",
                                            owner:self,
                                            
                                            options: nil)?[0] as? PopupSearchMenu
    if let popup = popupOpt {
      popUpView = popup
      popup.show(superView: view, viewController: self)
    }
  }
  
  //MARK: -  Cell delegating to store Unit in CoreData after conversion
  
  func addToStorePressed(trackId:Double, name:String, image:UIImage) {
    convertImageAndSaveUintInCoreData(trackId: trackId, name: name, image: image)
  }
  
  //MARK: - Popup menu delegating
  
  func searchPressed(additional:String, serachName:String) {
    if additional == "empty" {
      alertController()
    } else {
      tunesRequest(term: serachName)
      searchButton.isEnabled = true
    }
  }
  
  func dismissPressed() {
    searchButton.isEnabled = true
  }
  
  
  @IBAction func goToStore(_ sender: RoundedButton) {
    performSegue(withIdentifier: "goStore", sender: nil)
  }
}

