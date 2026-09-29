//
//  LoginViewModel.swift
//  UI_Unit_test
//
//  Created by Jayesh on 26/09/26.
//

import Foundation

final class LoginViewModel {

    private let authService: AuthServiceProtocol

    var onLoginSuccess: ((User) -> Void)?
    var onLoginError: ((String) -> Void)?
    var onLoading: ((Bool) -> Void)?

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    func login(email: String, password: String) {

        guard !email.isEmpty else {
            onLoginError?("Please enter email")
            return
        }

        guard email.contains("@") else {
            onLoginError?("Please enter valid email")
            return
        }

        guard !password.isEmpty else {
            onLoginError?("Please enter password")
            return
        }

        onLoading?(true)

        authService.login(email: email,password: password) { [weak self] result in

            DispatchQueue.main.async {

                self?.onLoading?(false)

                switch result {

                case .success(let user):
                    self?.onLoginSuccess?(user)

                case .failure:
                    self?.onLoginError?(
                        "Invalid email or password"
                    )
                }
            }
        }
    }
}
