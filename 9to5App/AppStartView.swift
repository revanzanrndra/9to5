//
//  AppStartView.swift
//  9to5App
//
//  Created by Mirabella on 09/04/25.
//
import SwiftUI

struct AppStartView: View {
    @AppStorage("savedName") private var userName: String = ""

    var body: some View {
        Group {
            if userName.isEmpty {
                NameView(textField: $userName)
            } else {
                MainPageView()
            }
        }
    }
}

#Preview {
    AppStartView()
}
