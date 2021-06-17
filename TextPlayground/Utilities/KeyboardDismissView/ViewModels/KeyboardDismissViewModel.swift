//
//  KeyboardDismissViewModel.swift
//  TextPlayground
//
//  Created by Jonas Simkus on 17/06/2021.
//

import SwiftUI
import Combine

final class KeyboardDismissViewModel: ObservableObject {

    private var keyboardHeight: CGFloat = 0 {
        didSet {
            isKeyboardPresented = keyboardHeight > 0
        }
    }

    @Published var isKeyboardPresented: Bool = false

    private var cancellable: AnyCancellable?

    private let keyboardWillShow = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height }

    private let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat.zero }

    init() {
        cancellable = Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .subscribe(on: DispatchQueue.main)
            .assign(to: \.self.keyboardHeight, on: self)
    }
}
