//
//  DefaultViewController.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 18.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import UIKit

class DefaultViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - UI

private extension DefaultViewController {
    
    func setupUI() {
        
        view.backgroundColor = .purple
    }
}
