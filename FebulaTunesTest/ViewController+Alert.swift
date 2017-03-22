//
//  ViewController+Alert.swift
//  FebulaTunesTest
//
//  Created by Paul on 22.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func presentAlertWithTitle(title: String, messageString message: String) {
    let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
}
