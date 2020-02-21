//  ProfileModel.swift
//
//  ProfileModel.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 19.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import Core
import Combine

final class ProfileModel {
    
    @Published var test: User
        
    init(user: User) {
        self.test = user
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.test.firstName = "lksanvdsj"
        }
    }
}
