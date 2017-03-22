//
//  Country.swift
//  FebulaTunesTest
//
//  Created by Paul on 20.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import Foundation

public enum Country: String {
  case australia     = "au"
  case canada        = "ca"
  case china         = "zh"
  case denmark       = "dk"
  case france        = "fr"
  case germany       = "de"
  case italy         = "it"
  case japan         = "ja"
  case netherlands   = "nl"
  case poland        = "pl"
  case spain         = "es"
  case sweden        = "se"
  case switzerland   = "ch"
  case unitedKingdom = "gb"
  case unitedStates  = "us"
  case belarus       = "by"
}

extension Country {
  public var code: String {
    return rawValue
  }
}
