//
//  SelectedMoviesView.swift
//  ThingsApp
//
//  Created by Naveen Kumawat on 31/07/22.
//

import SwiftUI

struct SelectedMoviesView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @FetchRequest(sortDescriptors: []) var movies: FetchedResults<Movies>
    @State var leftMovieList: [Movies] = []
    @State var flagMovie: Movies?
    
    var nextButton: () -> Void
    
    @Binding var buttonPressed: (() -> Void)?
    @Binding var title: LocalizedStringKey
    @Binding var circlePositionVector: Double
    @Binding var buttonHorizontalAlignment: HorizontalAlignment
    @Binding var buttonEdgeSet: Edge.Set
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                if movies.isEmpty {
                    ProgressView()
                        .padding(.top, 20)
                }else{
                    let totalMovies = leftMovieList.count
                    let opacityUnit: Double = 1/(Double(totalMovies+1))
                    HStack(alignment: .top){
                        VStack{
                            ScrollView{
                                ForEach(0..<totalMovies, id: \.self) { i in
                                    let opacity = opacityUnit * Double(totalMovies-(i-1))
                                    let movie: Movies = leftMovieList[i]
                                    Button {
                                        flagMovie = movie
                                        leftMovieList = movies.filter{$0.id != flagMovie?.id}
                                    } label: {
                                        Text(movie.title ?? "")
                                            .fontWeight(.bold)
                                            .multilineTextAlignment(.leading)
                                            .padding()
                                    }
                                    .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.2, alignment: .leading)
                                    .background(.blue.opacity(opacity))
                                    .foregroundColor(Color("ThingButtonText"))
                                    .cornerRadius(5)
                                }
                            }
                        }
                        VStack{
                            Text(flagMovie?.title ?? "")
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding()
                                .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.60, alignment: .center)
                                .foregroundColor(Color("ThingButtonText"))
                                .cornerRadius(5)
                        }
                        .border(.blue)
                    }
                    .padding()
                    .frame(alignment: .center)
                    .onAppear(){
                        leftMovieList = movies.filter{$0.id != flagMovie?.id}
                    }
                }
            }
            .frame(width:geometry.size.width,alignment: .leading)
            .padding([.leading],15)
            .navigationBarHidden(true)
            .onAppear(){
                buttonPressed = self.backPressed
            }
        }
    }
    
    func backPressed() {
        title = "Next"
        circlePositionVector = 0.75
        buttonHorizontalAlignment = .trailing
        buttonEdgeSet = .trailing
        buttonPressed = nextButton
        presentationMode.wrappedValue.dismiss()
    }
}

//struct SelectedMoviesView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedMoviesView()
//    }
//}
