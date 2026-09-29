//
//  MockAuthService.swift
//  UI_Unit_test
//
//  Created by Jayesh on 26/09/26.
//

import Foundation

final class MockAuthService: AuthServiceProtocol {

    var result: Result<User, Error>?

    func login(email: String,password: String,completion: @escaping (Result<User, Error>) -> Void
    ) {

        if let result = result {
            completion(result)
        }
    }
}
