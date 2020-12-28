//
//  BackgroundView.swift
//  Achieve
//
//  Created by Gavin Butler on 06-12-2020.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        GeometryReader { geometry in
            Color.black
                .edgesIgnoringSafeArea(.bottom)
            Image("photo-6")
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width)
                .edgesIgnoringSafeArea(.all)
            
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
