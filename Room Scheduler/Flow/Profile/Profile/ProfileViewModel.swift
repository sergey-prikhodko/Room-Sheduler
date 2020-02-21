//
//  ProfileViewModel.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 19.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import Combine
import Core
import UIKit

final class ProfileViewModel: HasCancelableBag {
    
    @Published var fullName: String = ""

	private let model: ProfileModel

    init(_ model: ProfileModel) {
    	self.model = model
                
        model.$test
            .map(\.firstName, \.lastName)
            .map { "\($0) \($1)" }
            .assign(to: \.fullName, on: self)
            .store(in: &cancelableBag)
    }
}
