//
//  WelcomeViewController.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 27.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import UIKit
import Combine

final class WelcomeViewController: DefaultViewController {

    // MARK: - Properties
    
    private let welcomeLabel = UILabel()
    private let signInButton = UIButton()
    private let signUpButton = UIButton()
    
    private let coordinator: (WelcomeFlowAction) -> Void
    
    private var bag = Set<AnyCancellable>()

    // MARK: - Life cicle

    init(coordinator: @escaping (WelcomeFlowAction) -> Void) {
        self.coordinator = coordinator
        
        super.init()

        setupUI()
        
        signInButton.publisher(for: .touchUpInside).map { _ in .signIn }.sink(receiveValue: coordinator).store(in: &bag)
        signUpButton.publisher(for: .touchUpInside).map { _ in .signUp }.sink(receiveValue: coordinator).store(in: &bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - UI

private extension WelcomeViewController {
	
	func setupUI() {
        setupSignUpButton()
        setupSignInButton()
        setupWelcomeLabel()
    }
    
    func setupSignUpButton() {
        view.addSubview(signUpButton)
        signUpButton.layout {
            $0.leading == view.safeAreaLayoutGuide.leadingAnchor + 15.0
            $0.trailing == view.safeAreaLayoutGuide.trailingAnchor - 15.0
            $0.bottom == view.safeAreaLayoutGuide.bottomAnchor - 15.0
            $0.height == 76.0
        }
        
        signUpButton.backgroundColor = .secondarySystemBackground
        signUpButton.setTitleColor(.label, for: .normal)
        signUpButton.layer.cornerRadius = 12.0
        
        signUpButton.setTitle("Sign Up", for: .normal)
    }
    
    func setupSignInButton() {
        view.addSubview(signInButton)
        signInButton.layout {
            $0.leading == view.safeAreaLayoutGuide.leadingAnchor + 15.0
            $0.trailing == view.safeAreaLayoutGuide.trailingAnchor - 15.0
            $0.bottom == signUpButton.topAnchor - 15.0
            $0.height == 76.0
        }
        
        signInButton.backgroundColor = .secondarySystemBackground
        signInButton.setTitleColor(.label, for: .normal)
        signInButton.layer.cornerRadius = 12.0
        
        signInButton.setTitle("Sign In", for: .normal)
    }
    
    func setupWelcomeLabel() {
        view.addSubview(welcomeLabel)
        welcomeLabel.layout {
            $0.leading == view.safeAreaLayoutGuide.leadingAnchor + 15.0
            $0.top == view.safeAreaLayoutGuide.topAnchor + 30.0
            $0.trailing == view.safeAreaLayoutGuide.trailingAnchor - 15.0
        }
        
        welcomeLabel.textColor = .label
        welcomeLabel.font = .boldSystemFont(ofSize: 25.0)
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textAlignment = .center
        
        welcomeLabel.text = "Welcome to App"
    }
}
