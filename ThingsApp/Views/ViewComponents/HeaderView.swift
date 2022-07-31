//
//  HeaderView.swift
//  ThingsApp
//
//  Created by Naveen Kumawat on 29/07/22.
//

import SwiftUI

import SwiftUI

import SwiftUI

struct HeaderView: View {
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    var bgColor: Color

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .trim(from: 0, to: 0.5)
                .fill(self.bgColor)
                .frame(width: geometry.size.width * 2, alignment: .topLeading)
                .position(x: geometry.size.width * 0.25, y: geometry.size.height * -0.35)
                .shadow(radius: 2)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(self.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        
                        Text(self.subtitle)
                            .font(.title2)
                            .fontWeight(.bold)
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)

                        Spacer()
                    }
                    .padding(.leading, 25)
                    .padding(.top, 5)

                    Spacer()
                }
            }
            
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "THINGS", subtitle: "The App", bgColor: .blue)
        
//        HeaderView(title: "THINGS", subtitle: "The App", bgColor: .blue)
//            .previewDevice(PreviewDevice(rawValue: "iPhone 8 Plus"))
//            .previewDisplayName("iPhone 8 Plus")
//
//        HeaderView(title: "THINGS", subtitle: "The App", bgColor: .blue)
//            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
//            .previewDisplayName("iPhone 11")
//
//        HeaderView(title: "THINGS", subtitle: "The App", bgColor: .blue)
//            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
//            .previewDisplayName("iPhone 11 Pro Max")
//
//        HeaderView(title: "THINGS", subtitle: "The App", bgColor: .blue)
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
//            .previewDisplayName("iPhone 13 Pro Max")
    }
}

