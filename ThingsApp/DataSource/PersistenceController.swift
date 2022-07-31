//
//  PersistenceController.swift
//  ThingsApp
//
//  Created by Naveen Kumawat on 31/07/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "ThingsApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            /*if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }*/
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
