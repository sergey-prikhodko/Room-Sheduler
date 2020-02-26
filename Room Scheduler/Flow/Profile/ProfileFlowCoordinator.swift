//
//  ProfileFlowCoordinator.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 26.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import Foundation
import Combine
import Core
import UIKit

enum ProfileFlowAction {
    
    case editProfile
}

final class ProfileFlowCoordinator {
    
    private var store: Store<User, ProfileAction>
    private var navigation: UINavigationController?
    
    init(_ store: Store<User, ProfileAction>) {
        self.store = store
    }
    
    private var profile: UIViewController {
        ProfileViewController(store.substore(value: { $0 }, action: { _ in .profileAction }), coordinator: self)
    }
    
    private var editProfile: UIViewController {
        EditProfileViewController(store.substore(value: { $0 }, action: { .editPrrofile($0) }))
    }
    
    func createFlow() -> UIViewController {
        let navigation = UINavigationController(rootViewController: profile)
        navigation.navigationBar.prefersLargeTitles = true
        self.navigation = navigation
        
        return navigation
    }
    
    
    func provide(_ action: ProfileFlowAction) {
        switch action {
        case .editProfile:
            navigation?.pushViewController(editProfile, animated: true)
        }
    }
}
