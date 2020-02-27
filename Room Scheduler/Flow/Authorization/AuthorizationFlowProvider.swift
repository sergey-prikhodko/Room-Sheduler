//
//  AuthorizationFlowProvider.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 27.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import UIKit

final class AuthorizationFlowProvider {
    
    private var navigation: UINavigationController?
    
    private var welcomeScreen: UIViewController {
        return WelcomeViewController(coordinator: welcomeFlowCoordinator(_:))
    }
    
    func createFlow() -> UIViewController {
        let navigation = UINavigationController(rootViewController: welcomeScreen)
        self.navigation = navigation
        
        return navigation
    }
    
    func welcomeFlowCoordinator(_ action: WelcomeFlowAction) {
        print(action)
    }
}
