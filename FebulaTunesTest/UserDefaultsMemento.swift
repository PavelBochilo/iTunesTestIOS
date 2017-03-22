//
//  UserDefaultsMemento.swift
//  FebulaTunesTest
//
//  Created by Paul on 22.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import UIKit

extension UserDefaults {
  
  func saveSearchString(sString: String) {
    set(sString, forKey: "sString")
    synchronize()
  }
  
  func getSearchString() -> String {
    let searchStringOpt = object(forKey: "sString") as? String
    if let sString = searchStringOpt {
      return sString
    } else {
      return ""
    }
  }
  
}
