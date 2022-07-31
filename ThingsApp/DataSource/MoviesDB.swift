//
//  MoviesDB.swift
//  ThingsApp
//
//  Created by Naveen Kumawat on 31/07/22.
//

import SwiftUI
import Combine
import CoreData

class MoviesDB: ObservableObject {
    
    func saveMovies(movies:[Movie]) {
        for movie in movies {
            saveMovie(id: movie.id, title: movie.title)
        }
    }
    
    private func saveMovie(id: Int64, title: String) {
        let context = PersistenceController.shared.container.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.performAndWait {
            do {
                if let exisitingMovie = try self.fetchMovie(with: id, in: context) {
                    exisitingMovie.update(with: id, movieTitle: title, context: context)
                    do{
                        try exisitingMovie.managedObjectContext?.save()
                    }catch let error{
                        print("exisitingMovie: \(error)")
                    }
                }else {
                    let newMovie = Movies(movieID: id, movieTitle: title, context: context)
                    do{
                        try newMovie.managedObjectContext?.save()
                    }catch let error{
                        print("newMovie: \(error)")
                    }
                }
                
                try context.save()
            }
            catch let error {
                print("Function: \(#function), line: \(#line) - Issue with saving context: \(error)")
                context.rollback()
            }
        }
    }
    
    func removeMovie(of id: Int64) {
        print("Deleting id: \(id)")
        let context = PersistenceController.shared.container.newBackgroundContext()
        let fetchRequest: NSFetchRequest<Movies> = Movies.fetchRequest()
        let p = NSPredicate(format: "id == %d", id)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [p])
        fetchRequest.predicate = predicate

        do {
            let objects = try context.fetch(fetchRequest)
            print("Deleting objects: \(objects.count)")
            for object in objects {
                context.delete(object)
            }
            try context.save()
        } catch let error {
            print("Function: \(#function), line: \(#line) - Issue with saving context: \(error)")
        }
    }
    
    private func fetchMovie(with id: Int64, in context: NSManagedObjectContext) throws -> Movies? {
        let fetchRequest: NSFetchRequest<Movies> = Movies.fetchRequest()
        let p = NSPredicate(format: "id == %d", id)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [p])
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        return try context.fetch(fetchRequest).first
    }
}
