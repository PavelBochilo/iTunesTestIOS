//
//  RoundedButton.swift
//  FebulaTunesTest
//
//  Created by Paul on 20.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
  
  // MARK: Functions
  override func draw(_ rect: CGRect) {
    self.layer.cornerRadius = frame.height/2
    self.clipsToBounds = true
  }
}
