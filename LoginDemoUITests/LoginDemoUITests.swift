//
//  LoginDemoUITests.swift
//  LoginDemoUITests
//
//  Created by Jayesh on 26/09/26.
//

import XCTest

final class LoginDemoUITests: XCTestCase {

    func testLoginScreenElements() {

        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(
            app.textFields["emailTextField"].exists
        )

        XCTAssertTrue(
            app.textFields["passwordTextField"].exists
        )

        XCTAssertTrue(
            app.buttons["loginButton"].exists
        )
    }
}
