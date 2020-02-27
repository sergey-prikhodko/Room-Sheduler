//  ProfileViewController.swift
//
//  ProfileViewController.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 19.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import UIKit
import Core
import Combine

final class ProfileViewController: DefaultViewController, HasCancelableBag {

    // MARK: - Properties
    
    private let scrollView = UIScrollView()
    private let container = UIView()
    
    private let avatarImageView = UIImageView()
    private let ageLabel = UILabel()
    private let bioLabel = UILabel()

    private var store: Store<User, Never>
    private var coordinator: (ProfileFlowAction) -> Void
    
    private var bag = Set<AnyCancellable>()
    
    init(_ store: Store<User, Never>, coordinator: @escaping (ProfileFlowAction) -> Void) {
        self.store = store
        self.coordinator = coordinator

        super.init()

        setupUI()
        setupBinding()
    }
    
    private func setupBinding() {
        store.$state.map { .some("\($0.firstName) \($0.lastName)") }.assign(to: \.title, on: self).store(in: &bag)
        store.$state.map { .some("Age: \($0.age)") }.assign(to: \.text, on: ageLabel).store(in: &bag)
        store.$state.map { .some($0.bio) }.assign(to: \.text, on: bioLabel).store(in: &bag)
    }
    
    @objc
    func showEdit() {
        coordinator(.editProfile)
    }
}

// MARK: - UI

private extension ProfileViewController  {
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        setupNavigation()
        setupScrollView()
        setupAvatarImageView()
        setupAgeLabel()
        setupBioLabel()
    }
    
    func setupNavigation() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(showEdit))
        navigationItem.rightBarButtonItem = editButton
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
    
    func setupAvatarImageView() {
        container.addSubview(avatarImageView)
        avatarImageView.layout {
            $0.top == container.topAnchor + 15.0
            $0.centerX == container.centerXAnchor
            $0.height == 120.0
            $0.width == 120.0
        }
        avatarImageView.layer.cornerRadius = 20.0
        avatarImageView.layer.borderWidth = 2.0
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.backgroundColor = .secondarySystemBackground
        avatarImageView.clipsToBounds = true
    }
    
    func setupAgeLabel() {
        container.addSubview(ageLabel)
        ageLabel.layout {
            $0.top == avatarImageView.bottomAnchor + 15.0
            $0.centerX == container.centerXAnchor
        }
        ageLabel.font = .systemFont(ofSize: 25.0)
        ageLabel.textColor = .label
    }
    
    func setupBioLabel() {
        container.addSubview(bioLabel)
        bioLabel.layout {
            $0.top == ageLabel.bottomAnchor + 15.0
            $0.leading == container.leadingAnchor + 15.0
            $0.trailing == container.trailingAnchor - 15.0
            $0.bottom == container.bottomAnchor - 15.0
        }
        bioLabel.font = .systemFont(ofSize: 23.0)
        bioLabel.textColor = .secondaryLabel
        bioLabel.numberOfLines = 0
    }
}
