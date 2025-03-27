//
//  NameView.swift
//  9to5App
//
//  Created by Mirabella on 26/03/25.
//

import SwiftUI

struct NameView: View {
    @Binding var textField: String
    @State private var tempName: String = ""  // Store temporary input
    @Environment(\.dismiss) var dismiss  // For dismissing the view

    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            VStack {
                Text("Hi, What's Your Name?")
            }
            VStack {
                TextField("Enter Text", text: $tempName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Text("Welcome Aboard \(tempName)!")
                    .padding()
            }
            .padding(.bottom, 150)
            Button(action: {
                if !tempName.isEmpty {
                    textField = tempName  // Update name only when clicking continue
                    dismiss()  // Go back to MainPage
                }
            }) {
                Text("Continue")
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 2)
                    )
            }
            .disabled(tempName.isEmpty)
        }
        .onAppear {
            tempName = textField  // Keep the last input if returning to this page
        }
        Spacer()
    }
}

#Preview {
    NameView(textField: .constant(""))
}
