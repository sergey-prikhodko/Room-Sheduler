//  MainViewController.swift
//
//  MainViewController.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 19.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import UIKit

final class MainViewController: DefaultViewController {

    // MARK: - Properties

    // MARK: - Life cicle

    override init() {
        super.init()

        setupUI()
    }
}

// MARK: - UI

private extension MainViewController {
    
    func setupUI() {
        title = "Main title"
    }
}
