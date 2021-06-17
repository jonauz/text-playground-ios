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
            ZStack {
                Form {
                    Section(header: editorHeaderView,
                            footer: editorFooterView) {
                        TextEditor(text: $viewModel.text)
                            .frame(minHeight: 240)
                            .disableAutocorrection(true)
                    }
                    .padding(.top, 10)
                }

                KeyboardDismissView {
                    self.viewModel.countWords()
                }
            }
            .navigationTitle("Text Playground")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                toolbarActionButton
            }
            .onAppear(perform: {
                viewModel.getRandomText()
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private var editorHeaderView: some View {
        Text("Load random text and try edit|✍️.. Have fun!")
            .frame(maxWidth: .infinity, alignment: .center)
    }

    private var editorFooterView: some View {
        Text("\(viewModel.wordCount) Word\(viewModel.wordCountIsPlural ? "s" : "")")
            .frame(maxWidth: .infinity, alignment: .trailing)
    }

    private var toolbarActionButton: some View {
        Button(action: {
            viewModel.getRandomText()
        }, label: {
            Image(systemName: "arrow.triangle.2.circlepath")
        })
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: RootViewModel(service: MockBaconIpsumService()))
    }
}
