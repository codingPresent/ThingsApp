//
//  Movies+CoreDataUpdation.swift.swift
//  ThingsApp
//
//  Created by Naveen Kumawat on 31/07/22.
//

import CoreData
extension Movies {
    convenience init(movieID: Int64, movieTitle: String, context: NSManagedObjectContext) {
        self.init(context: context)
        update(with: movieID, movieTitle: movieTitle, context: context)
    }
    
    func update(with movieID: Int64, movieTitle: String, context: NSManagedObjectContext) {
        id      = movieID
        title    = movieTitle
    }
    
}
