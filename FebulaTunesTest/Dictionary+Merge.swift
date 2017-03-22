//
//  Dictionary+Merge.swift
//  FebulaTunesTest
//
//  Created by Paul on 20.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import Foundation

extension Dictionary {
  mutating func unionInPlace(_ dictionary: Dictionary<Key, Value>) {
    for (key, value) in dictionary {
      self[key] = value
    }
  }
  
  func union(_ dictionary: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
    var dict = self
    dict.unionInPlace(dictionary)
    return dict
  }
}
