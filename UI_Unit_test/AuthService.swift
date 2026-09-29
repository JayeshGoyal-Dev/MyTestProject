//
//  AuthService.swift
//  UI_Unit_test
//
//  Created by Jayesh on 26/09/26.
//

import Foundation

protocol AuthServiceProtocol {
    func login(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    )
}

enum AuthError: Error, Equatable {
    case invalidCredentials
    case serverError
}

final class AuthService: AuthServiceProtocol {

    func login(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {

        // Simulating API call
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {

            if email == "test@gmail.com" && password == "123456" {

                let user = User(
                    name: "Jayesh",
                    email: email
                )

                completion(.success(user))

            } else {
                completion(.failure(AuthError.invalidCredentials))
            }
        }
    }
}
