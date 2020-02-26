//
//  EditProfileAction.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 25.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import Foundation

enum EditProfileAction {
    
    case editFirstName(TypeAction<String>)
    case editLastName(TypeAction<String>)
    case countAction(TypeAction<Int>)
    
    var editFirstName: TypeAction<String>? {
        get {
          guard case let .editFirstName(value) = self else { return nil }
          return value
        }
        set {
          guard case .editFirstName = self, let newValue = newValue else { return }
          self = .editFirstName(newValue)
        }
    }
    
    var editLastName: TypeAction<String>? {
        get {
          guard case let .editLastName(value) = self else { return nil }
          return value
        }
        set {
          guard case .editLastName = self, let newValue = newValue else { return }
          self = .editLastName(newValue)
        }
    }
    
    var countAction: TypeAction<Int>? {
        get {
          guard case let .countAction(value) = self else { return nil }
          return value
        }
        set {
          guard case .countAction = self, let newValue = newValue else { return }
          self = .countAction(newValue)
        }
    }
}
