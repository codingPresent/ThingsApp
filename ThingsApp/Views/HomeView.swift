//
//  HomeView.swift
//  ThingsApp
//
//  Created by Naveen Kumawat on 29/07/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var movieViewModel: MovieViewModel
    @EnvironmentObject var moviesDB: MoviesDB
    @FetchRequest(sortDescriptors: []) var movies: FetchedResults<Movies>
    @State var flagCheck: [Int64] = []
    @State private var showingAlert = false
    @State private var isSelectedView = false
    
    @State private var footerButtonTitle:LocalizedStringKey = "Next"
    @State private var circlePositionVector = 0.75
    @State private var buttonPressed: (() -> Void)? = nil
    @State private var buttonHorizontalAlignment: HorizontalAlignment = .trailing
    @State private var buttonEdgeSet: Edge.Set = .trailing
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                HeaderView(title: "THINGS", subtitle: "The App", bgColor: .blue)
                FooterView(title: $footerButtonTitle,
                           bgColor: .blue,
                           circlePositionVector: $circlePositionVector,
                           buttonPressed: buttonPressed ?? self.nextPressed,
                           buttonHorizontalAlignment: $buttonHorizontalAlignment,
                           buttonEdgeSet: $buttonEdgeSet)
//                FooterView(title: "Back", bgColor: .blue, circlePositionVector: 0.35, buttonPressed: self.backPressed,buttonHorizontalAlignment: .leading, buttonEdgeSet: .leading)
                
                if movieViewModel.fetchedPopularMovies.isEmpty {
                    ProgressView()
                        .padding(.top, 20)
                        .onAppear(){
                            movieViewModel.fetchPopularMovies()
                        }
                }else{
                    let totalMovies = movieViewModel.fetchedPopularMovies.count
                    let opacityUnit: Double = 1/(Double(totalMovies+1))
                    VStack{
                        NavigationView{
                        VStack{
                            NavigationLink(destination: SelectedMoviesView(nextButton: self.nextPressed, buttonPressed: $buttonPressed,title: $footerButtonTitle,
                                                                           circlePositionVector: $circlePositionVector,
                                                                           buttonHorizontalAlignment: $buttonHorizontalAlignment,
                                                                           buttonEdgeSet: $buttonEdgeSet),
                                           isActive: $isSelectedView) { EmptyView() }
                            ScrollView{
                                ForEach(0..<totalMovies, id: \.self) { i in
                                    let opacity = opacityUnit * Double(totalMovies-(i-1))
                                    let movie: Movie = movieViewModel.fetchedPopularMovies[i]
                                    Button {
                                        print("Button pressed")
                                        if let index = flagCheck.firstIndex(of: movie.id) {
                                            flagCheck.remove(at: index)
                                            let ids = movies.map { $0.id }
                                            if ids.contains(movie.id) {
                                                moviesDB.removeMovie(of: movie.id)
                                            }
                                        }else{
                                            flagCheck.append(movie.id)
                                        }
                                    } label: {
                                        HStack{
                                            Text(movie.title)
                                                .fontWeight(.bold)
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                            if flagCheck.contains(movie.id){
                                                AnimatedCheckmarkView(outerShape: AnyShape(RoundedRectangle(cornerRadius: 12)))
                                                    .disabled(true)
                                            }else{
                                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                                    .strokeBorder(.white)
                                                    .frame(width: 30, height: 30)
                                            }
                                        }.padding()
                                    }
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.1, alignment: .leading)
                                    .background(.blue.opacity(opacity))
                                    .foregroundColor(Color("ThingButtonText"))
                                    .cornerRadius(5)
                                }
                            }
                        }
                        .navigationBarHidden(true)
                        }.frame(height:geometry.size.height * 0.55,alignment: .top)
                    }.frame(height:geometry.size.height * 0.55,alignment: .top)
                }
            }
            .alert(isPresented: $showingAlert) {
                var message: String = "Select atleast 3 movies."
                if flagCheck.count > 0{
                    message = "Select atleast \(3-flagCheck.count) more movies."
                }
                return Alert(title: Text("Alert!!!"), message: Text(message), dismissButton: .cancel(Text("OK")))
            }
            .onAppear(){
                let ids = movies.map { $0.id }
                flagCheck.append(contentsOf: ids)
                buttonPressed = self.nextPressed
                footerButtonTitle = "Next"
                circlePositionVector = 0.75
                buttonHorizontalAlignment = .trailing
                buttonEdgeSet = .trailing
            }
        }
    }
    
    func nextPressed() {
        if flagCheck.count < 3{
            showingAlert = true
        }else{
            let selectedMovies = movieViewModel.fetchedPopularMovies.filter{flagCheck.contains($0.id)}
            moviesDB.saveMovies(movies: selectedMovies)
            isSelectedView = true
            footerButtonTitle = "Back"
            circlePositionVector = 0.35
            buttonHorizontalAlignment = .leading
            buttonEdgeSet = .leading
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

