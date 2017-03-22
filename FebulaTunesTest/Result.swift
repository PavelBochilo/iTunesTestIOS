//
//  Result.swift
//  FebulaTunesTest
//
//  Created by Paul on 20.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import Foundation

public enum Result<T, U> {
  case success(T)
  case failure(U)
  
  public var value: T? {
    if case .success(let value) = self {
      return value
    }
    return nil
  }
  
  public var error: U? {
    if case .failure(let error) = self {
      return error
    }
    return nil
  }
  
}
