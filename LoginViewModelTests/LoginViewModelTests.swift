//
//  LoginViewModelTests.swift
//  LoginViewModelTests
//
//  Created by Jayesh on 26/09/26.
//

import XCTest
@testable import UI_Unit_test

final class LoginViewModelTests: XCTestCase {

    var viewModel: LoginViewModel!
    var mockService: MockAuthService!

    override func setUp() {
        super.setUp()

        mockService = MockAuthService()

        viewModel = LoginViewModel(
            authService: mockService
        )
    }

    override func tearDown() {

        viewModel = nil
        mockService = nil

        super.tearDown()
    }

    // MARK: - Empty Email

    func testLoginWithEmptyEmail() {

        let expectation = expectation(
            description: "Should show email error"
        )

        viewModel.onLoginError = { message in

            XCTAssertEqual(
                message,
                "Please enter email"
            )

            expectation.fulfill()
        }

        viewModel.login(
            email: "",
            password: "123456"
        )

        wait(for: [expectation], timeout: 1)
    }

    // MARK: - Invalid Email

    func testLoginWithInvalidEmail() {

        let expectation = expectation(
            description: "Should show invalid email error"
        )

        viewModel.onLoginError = { message in

            XCTAssertEqual(
                message,
                "Please enter valid email"
            )

            expectation.fulfill()
        }

        viewModel.login(
            email: "jayesh",
            password: "123456"
        )

        wait(for: [expectation], timeout: 1)
    }

    // MARK: - Empty Password

    func testLoginWithEmptyPassword() {

        let expectation = expectation(
            description: "Should show password error"
        )

        viewModel.onLoginError = { message in

            XCTAssertEqual(
                message,
                "Please enter password"
            )

            expectation.fulfill()
        }

        viewModel.login(
            email: "test@gmail.com",
            password: ""
        )

        wait(for: [expectation], timeout: 1)
    }

    // MARK: - Successful Login

    func testSuccessfulLogin() {

        mockService.result = .success(
            User(
                name: "Jayesh",
                email: "test@gmail.com"
            )
        )

        let expectation = expectation(
            description: "Login should succeed"
        )

        viewModel.onLoginSuccess = { user in

            XCTAssertEqual(
                user.name,
                "Jayesh"
            )

            XCTAssertEqual(
                user.email,
                "test@gmail.com"
            )

            expectation.fulfill()
        }

        viewModel.login(
            email: "test@gmail.com",
            password: "123456"
        )

        wait(for: [expectation], timeout: 1)
    }

    // MARK: - Failed Login

    func testFailedLogin() {

        mockService.result = .failure(
            AuthError.invalidCredentials
        )

        let expectation = expectation(
            description: "Login should fail"
        )

        viewModel.onLoginError = { message in

            XCTAssertEqual(
                message,
                "Invalid email or password"
            )

            expectation.fulfill()
        }

        viewModel.login(
            email: "wrong@gmail.com",
            password: "wrong"
        )

        wait(for: [expectation], timeout: 1)
    }
}
