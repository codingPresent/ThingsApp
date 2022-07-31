//
//  Movies+CoreDataProperties.swift
//  ThingsApp
//
//  Created by Naveen Kumawat on 31/07/22.
//
//

import Foundation
import CoreData


extension Movies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movies> {
        return NSFetchRequest<Movies>(entityName: "Movies")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?

}

extension Movies : Identifiable {

}
