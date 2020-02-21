//  ProfileViewController.swift
//
//  ProfileViewController.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 19.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import UIKit
import Combine

final class ProfileViewController: DefaultViewController, HasCancelableBag {

    // MARK: - Properties
    
    private let scrollView = UIScrollView()
    private let container = UIView()
    
    private let avatarImageView = UIImageView()

    private var viewModel: ProfileViewModel
    
    init(_ viewModel: ProfileViewModel) {
        self.viewModel = viewModel

        super.init()

        setupUI()
        setupBinding()
    }
    
    private func setupBinding() {
        viewModel.$fullName.map { Optional($0) }.assign(to: \.title, on: self).store(in: &cancelableBag)
    }
}

// MARK: - UI

private extension ProfileViewController  {
    
    func setupUI() {
        title = "Profile"
        view.backgroundColor = .systemBackground
        
        setupNavigation()
        setupScrollView()
        setupAvatarImageView()
    }
    
    func setupNavigation() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
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
            $0.bottom == container.bottomAnchor - 15.0
            $0.height == 120.0
            $0.width == 120.0
        }
        avatarImageView.layer.cornerRadius = 20.0
        avatarImageView.layer.borderWidth = 2.0
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.backgroundColor = .secondarySystemBackground
        avatarImageView.clipsToBounds = true
    }
}
