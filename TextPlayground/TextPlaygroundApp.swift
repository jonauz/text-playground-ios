//
//  TextPlaygroundApp.swift
//  TextPlayground
//
//  Created by Jonas Simkus on 15/06/2021.
//

import SwiftUI

@main
struct TextPlaygroundApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: RootViewModel(service: BaconIpsumService()))
        }
    }
}
