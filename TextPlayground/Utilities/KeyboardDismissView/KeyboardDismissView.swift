//
//  KeyboardDismissView.swift
//  TextPlayground
//
//  Created by Jonas Simkus on 17/06/2021.
//

import SwiftUI

struct KeyboardDismissView: View {

    @StateObject private var viewModel = KeyboardDismissViewModel()

    var onAction: (() -> Void)?

    var body: some View {
        VStack {
            if viewModel.isKeyboardPresented {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.hideKeyboard()
                        self.onAction?()
                    }, label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                            .font(.system(.title3))
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.white)
                    })
                    .background(Color.blue)
                    .cornerRadius(15)
                    .padding()
                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 1, y: 1)
                }
                .animation(.default)
            }
        }
    }
}
