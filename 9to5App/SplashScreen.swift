//
//  SplashScreen.swift
//  9to5App
//
//  Created by Mirabella on 26/03/25.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var fadeIn = false
    
    var body: some View {
        if isActive {
            AppStartView()
        } else {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack(spacing: 12) {
                    Image("Splash")
                        .resizable()
                        .renderingMode(.original) 
                        .interpolation(.high)
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .padding(.bottom, 20)
                    
                    Text("9to5")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .kerning(1)
                    
                    Text("Stress-Free Parking Solutions")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.gray.opacity(0.9))
                        .italic()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                .opacity(fadeIn ? 1 : 0)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.0)) {
                        fadeIn = true
                    }
                    
                    // Tahan splash selama 4.5 detik
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
