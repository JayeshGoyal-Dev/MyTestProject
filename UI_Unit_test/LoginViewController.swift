//
//  LoginViewController.swift.swift
//  UI_Unit_test
//
//  Created by Jayesh on 26/09/26.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var viewModel: LoginViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewModel()
    }

    private func setupUI() {

        emailTF.accessibilityIdentifier = "emailTextField"
        passwordTF.accessibilityIdentifier = "passwordTextField"

        loginButton.accessibilityIdentifier = "loginButton"

        activityIndicator.isHidden = true
    }

    private func setupViewModel() {

        viewModel = LoginViewModel(authService: AuthService())

        viewModel.onLoading = { [weak self] loading in

            DispatchQueue.main.async {

                self?.activityIndicator.isHidden = !loading

                loading
                ? self?.activityIndicator.startAnimating()
                : self?.activityIndicator.stopAnimating()

                self?.loginButton.isEnabled = !loading
            }
        }

        viewModel.onLoginSuccess = { [weak self] user in

            let alert = UIAlertController(
                title: "Success",
                message: "Welcome \(user.name)",
                preferredStyle: .alert
            )

            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default
                )
            )

            self?.present(alert, animated: true)
        }

        viewModel.onLoginError = { [weak self] message in

            let alert = UIAlertController(
                title: "Login Failed",
                message: message,
                preferredStyle: .alert
            )

            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default
                )
            )

            self?.present(alert, animated: true)
        }
    }

    @IBAction func btnLoginAction(_ sender: Any) {

        viewModel.login(
            email: emailTF.text ?? "",
            password: passwordTF.text ?? ""
        )
    }
}
