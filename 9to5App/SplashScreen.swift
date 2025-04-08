//
//  SplashScreen.swift
//  9to5App
//
//  Created by Mirabella on 26/03/25.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        Image("Splash")
            .resizable()
            .scaledToFit()
            .frame(width: 250, height: 250)
            .padding()
        Text("9to5")
            .font(.largeTitle)
            .bold()
        Text("Stress-Free Parking Solutions")
            .font(.title2)
            .italic()
            .padding(15)
    }
    
}

#Preview {
    SplashScreen()
}
