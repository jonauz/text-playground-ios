//
//  RootView.swift
//  TextPlayground
//
//  Created by Jonas Simkus on 15/06/2021.
//

import SwiftUI

struct RootView: View {

    @ObservedObject var viewModel: RootViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                Text("Load random text and try edit|✍️.. Have fun!")
                    .font(.headline)

                HStack {
                    TextEditor(text: $viewModel.text)
                        .disableAutocorrection(true)
                        .overlay(RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray, lineWidth: 1))
                }
                .padding(.horizontal, 10)

                HStack {
                    Spacer()
                    Text("Word Count")
                        .padding(.trailing, 10)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 20)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .padding(.top, 15)
            .padding(.bottom, 30)
            .navigationTitle("Text Playground")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button(action: {
                        viewModel.getRandomText()
                    }, label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                    })
                }
            })
            .onAppear(perform: {
                viewModel.getRandomText()
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: RootViewModel(service: MockBaconIpsumService()))
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
