//
//  FooterView.swift
//  ThingsApp
//
//  Created by Naveen Kumawat on 29/07/22.
//

import SwiftUI

struct FooterView: View {
    @Binding var title: LocalizedStringKey
    var bgColor: Color
    @Binding var circlePositionVector: Double
    var buttonPressed: () -> Void
    @Binding var buttonHorizontalAlignment: HorizontalAlignment
    @Binding var buttonEdgeSet: Edge.Set
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                .trim(from: 0.5, to: 1)
                .fill(self.bgColor)
                .frame(width: geometry.size.width * 2, alignment: .bottomTrailing)
                .position(x: geometry.size.width * circlePositionVector, y: geometry.size.height * 1.35)
                .shadow(radius: 2)
                .edgesIgnoringSafeArea(.all)
                
                HStack {
                    if(circlePositionVector == 0.75){
                        Spacer()
                    }
                    
                    VStack(alignment: buttonHorizontalAlignment) {
                        Spacer()
                        Button(title) {
                            self.buttonPressed()
                        }
                        .foregroundColor(.blue)
                        .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.06, alignment: .center)
                        .background(Color("NextBackBG"))
                        .cornerRadius(5)
                    }
                    .padding(buttonEdgeSet, 25)
                    .padding(.bottom, 30)
                    
                    if(circlePositionVector < 0.75){
                        Spacer()
                    }

                }
            }
            
        }
    }
}

func temp() {
}
//struct FooterView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        FooterView(title: "Next", bgColor: .blue, buttonPressed: temp)
//        
////        FooterView(title: "THINGS", subtitle: "The App", bgColor: .blue)
////            .previewDevice(PreviewDevice(rawValue: "iPhone 8 Plus"))
////            .previewDisplayName("iPhone 8 Plus")
////
////        FooterView(title: "THINGS", subtitle: "The App", bgColor: .blue)
////            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
////            .previewDisplayName("iPhone 11")
////
////        FooterView(title: "THINGS", subtitle: "The App", bgColor: .blue)
////            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
////            .previewDisplayName("iPhone 11 Pro Max")
////
////        FooterView(title: "THINGS", subtitle: "The App", bgColor: .blue)
////            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
////            .previewDisplayName("iPhone 13 Pro Max")
//    }
//}
