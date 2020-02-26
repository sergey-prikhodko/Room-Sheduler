//
//  EditProfileViewController.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 25.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import Foundation
import Core
import Combine
import UIKit

final class EditProfileViewController: DefaultViewController {
    
    // MARK: - Properties
    
    private let scrollView = UIScrollView()
    private let container = UIView()
    
    private let firstNameTextField = UITextField()
    private let lastNameTextField = UITextField()
    private let ageStepper = AgeStepper()
    
    private var bag = Set<AnyCancellable>()
    private var store: Store<User, EditProfileAction>
    
    init(_ store: Store<User, EditProfileAction>) {
        self.store = store
        
        super.init()
        
        firstNameTextField.text = store.state.firstName
        lastNameTextField.text = store.state.lastName
        
        setupUI()
        setupBinding()
    }
    
    private func setupBinding() {
        firstNameTextField.publisher(for: \.text)
            .map { .editFirstName(.set($0 ?? "")) }
            .sink(receiveValue: store.provide)
            .store(in: &bag)
        lastNameTextField.publisher(for: \.text)
            .map { .editLastName(.set($0 ?? "")) }
            .sink(receiveValue: store.provide)
            .store(in: &bag)
        ageStepper.apply(store.substore(value: { $0.age }, action: { .countAction($0) }))
    }
}

// MARK: - UI

private extension EditProfileViewController {
    
    func setupUI() {
//        view.back
        
        setupScrollView()
        setupFirstNameLabbel()
        setupLastNameLabbel()
        setupAgeStepper()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.keyboardDismissMode = .onDrag
        scrollView.alwaysBounceVertical = true
        scrollView.layout {
            $0.top == view.layoutMarginsGuide.topAnchor
            $0.bottom == view.layoutMarginsGuide.bottomAnchor
            $0.leading.equal(to: view.leadingAnchor)
            $0.trailing.equal(to: view.trailingAnchor)
        }
        scrollView.addSubview(container)
        container.layout {
            $0.top.equal(to: scrollView.topAnchor)
            $0.bottom.equal(to: scrollView.bottomAnchor)
            $0.leading.equal(to: scrollView.leadingAnchor)
            $0.trailing.equal(to: scrollView.trailingAnchor)
            $0.width.equal(to: scrollView.widthAnchor)
        }
    }
    
    func setupFirstNameLabbel() {
        container.addSubview(firstNameTextField)
        firstNameTextField.layout {
            $0.leading == container.leadingAnchor + 15.0
            $0.top == container.topAnchor + 15.0
            $0.trailing == container.trailingAnchor - 15.0
        }
    }
    
    func setupLastNameLabbel() {
        container.addSubview(lastNameTextField)
        lastNameTextField.layout {
            $0.leading == container.leadingAnchor + 15.0
            $0.top == firstNameTextField.bottomAnchor + 15.0
            $0.trailing == container.trailingAnchor - 15.0
        }
    }
    
    func setupAgeStepper() {
        container.addSubview(ageStepper)
        ageStepper.layout {
            $0.leading == container.leadingAnchor + 15.0
            $0.top == lastNameTextField.bottomAnchor + 15.0
            $0.trailing == container.trailingAnchor - 15.0
            $0.bottom == container.bottomAnchor - 15.0
            $0.height == 70.0
        }
    }
}
