//
//  String+URLEscaped.swift
//  FebulaTunesTest
//
//  Created by Paul on 20.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import Foundation

extension String {
  var urlEscaped: String? {
    return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
  }
}
