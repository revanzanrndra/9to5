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
            .frame(width: 300, height: 300)
    }
}

#Preview {
    SplashScreen()
}
