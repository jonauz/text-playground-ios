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
        Text("Text Playground")
            .padding()
            .onAppear(perform: {
                viewModel.getRandomText()
            })
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: RootViewModel(service: MockBaconIpsumService()))
    }
}
