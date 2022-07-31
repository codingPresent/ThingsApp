//
//  ThingsAppApp.swift
//  ThingsApp
//
//  Created by Naveen Kumawat on 29/07/22.
//

import SwiftUI

@main
struct ThingsAppApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject var popularMovies = MovieViewModel()
    @StateObject var moviesDB = MoviesDB()
    var body: some Scene {
        WindowGroup {
//            SelectedMoviesView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(popularMovies)
                .environmentObject(moviesDB)

        }
    }
}
