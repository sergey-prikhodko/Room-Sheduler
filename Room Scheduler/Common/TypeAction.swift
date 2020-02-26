//
//  TypeAction.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 26.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import Foundation

enum TypeAction<T> {
    
    case set(T)
}

func typeReducer<T>(value: inout T, action: TypeAction<T>) {
    
    switch action {
    case let .set(newValue):
        value = newValue
    }
}
