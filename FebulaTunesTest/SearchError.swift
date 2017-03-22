//
//  SearchError.swift
//  FebulaTunesTest
//
//  Created by Paul on 20.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import Foundation

public enum SearchError: Error {
  case invalidSearchTerm
  case invalidURL
  case invalidServerResponse
  case serverError(Int)
  case invalidJSON
}
