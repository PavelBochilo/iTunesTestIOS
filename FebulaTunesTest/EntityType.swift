//
//  EntityType.swift
//  FebulaTunesTest
//
//  Created by Paul on 20.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import Foundation

public protocol EntityType {
  var value: String { get }
  var parameter: [String : String] { get }
}

public extension EntityType {
  var parameter: [String : String] {
    return ["entity" : value]
  }
}
