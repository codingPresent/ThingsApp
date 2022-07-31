//
//  MovieViewModel.swift
//  ThingsApp
//
//  Created by Naveen Kumawat on 31/07/22.
//

import SwiftUI
import Combine

class MovieViewModel: ObservableObject {

    @Published var fetchedPopularMovies: [Movie] = []

    @Published var page: Int = 1
    
    private let limit = 5
    private let language = "en-US"
    private let API_KEY = "0291eec449d3882e829c679dee529a3a"
    
    func fetchPopularMovies() {
//    https://api.themoviedb.org/3/movie/popular?api_key=0291eec449d3882e829c679dee529a3a&language=en-US&page=2
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=\(API_KEY)&language=\(language)&page=\(page)"

        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { data, _, err in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            guard let responseJSON = data else { return }
            do {
                let moviesArray = try JSONDecoder().decode(MoviesArray.self, from: responseJSON)
                print("moviesArray: \(moviesArray)")
                DispatchQueue.main.async {
                    self.fetchedPopularMovies.append(contentsOf: moviesArray.results ?? [])
                }
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
        .resume()
    }
}


