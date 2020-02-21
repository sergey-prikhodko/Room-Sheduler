//
//  DefaultNavigationController.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 19.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import UIKit

class DefaultNavigationController: UINavigationController {
    
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - UI

private extension DefaultNavigationController {
    
    func setupUI() {
        navigationBar.prefersLargeTitles = true
    }
}
