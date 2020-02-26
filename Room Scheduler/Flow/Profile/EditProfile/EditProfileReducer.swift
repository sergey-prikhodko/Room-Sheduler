//
//  EditProfileReducer.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 25.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import Foundation
import Core

let editProfileReducer: (inout User, EditProfileAction) -> Void = combine(
    pullback(typeReducer, value: \.firstName, action: \.editFirstName),
    pullback(typeReducer, value: \.lastName, action: \.editLastName),
    pullback(typeReducer, value: \.age, action: \.countAction)
)
