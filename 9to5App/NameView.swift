//
//  NameView.swift
//  9to5App
//
//  Created by Mirabella on 26/03/25.
//

import SwiftUI

struct NameView: View {
    @Binding var textField: String
    @State private var tempName: String = ""
    @AppStorage("savedName") private var savedName: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image("Splash")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            
            Text("Hi, What's Your Name?")
                .font(.headline)
                .padding(.top)
            
            TextField("Enter your name", text: $tempName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.bottom, 150)
            
            Button(action: {
                if !tempName.isEmpty {
                    textField = tempName
                    savedName = tempName
                    dismiss()             
                }
            }) {
                Text("Continue")
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue, lineWidth: 2)
                    )
            }
            .disabled(tempName.isEmpty)
        }
        .onAppear {
            tempName = textField
        }
    }
}

#Preview {
    NameView(textField: .constant(""))
}
