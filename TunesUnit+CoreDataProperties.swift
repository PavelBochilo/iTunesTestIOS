//
//  TunesUnit+CoreDataProperties.swift
//  FebulaTunesTest
//
//  Created by Paul on 21.03.17.
//  Copyright © 2017 Paul. All rights reserved.
//

import Foundation
import CoreData


extension TunesUnit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TunesUnit> {
        return NSFetchRequest<TunesUnit>(entityName: "TunesUnit");
    }

    @NSManaged public var imageData: NSData?
    @NSManaged public var trackName: String?
    @NSManaged public var trackId: Double
  
  override public var description : String{
   return "*** track ID = \(trackId) with Name = \(trackName) ***"
  }
  
}
