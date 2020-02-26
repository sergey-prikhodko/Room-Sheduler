//
//  ProfileAction.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 26.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import Foundation
import Core

enum ProfileAction {
    
    case editPrrofile(EditProfileAction)
    case profileAction
    
    var editPrrofile: EditProfileAction? {
        get {
          guard case let .editPrrofile(value) = self else { return nil }
          return value
        }
        set {
          guard case .editPrrofile = self, let newValue = newValue else { return }
          self = .editPrrofile(newValue)
        }
    }
}

let profileReducer: (inout User, ProfileAction) -> Void = combine(
    pullback(editProfileReducer, value: \.self, action: \.editPrrofile)
)
