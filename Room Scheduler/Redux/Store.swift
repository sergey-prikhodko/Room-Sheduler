//
//  Store.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 21.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import Foundation
import Combine

func pullback<LValue, GValue, LAction, GAction> (
    _ reducer: @escaping (inout LValue, LAction) -> Void,
    value: WritableKeyPath<GValue, LValue>,
    action: WritableKeyPath<GAction, LAction?>
) -> (inout GValue, GAction) -> Void {
    return { gValue, gAction in
        guard let lAction = gAction[keyPath: action] else { return }
        reducer(&gValue[keyPath: value], lAction)
    }
}

func combine<Value, Action>(_ reducers: (inout Value, Action) -> Void...) -> (inout Value, Action) -> Void {
    return { value, action in reducers.forEach { $0(&value, action) } }
}

protocol Action {}

final class Store<S, A: Action> {
    
    @Published var state: S
    
    private let reducer: (inout S, A) -> Void
    
    init(_ state: S, reducer: @escaping (inout S, A) -> Void) {
        self.state = state
        self.reducer = reducer
    } 
    
    func provide(_ action: A) {
        reducer(&state, action)
    }
}

struct State {
    
    var count: Int
    var text: String
}

enum CountAction: Action {
    
    case incr
    case decr
}

enum TextAction: Action {
    
    case write(String)
    case cleare
}

enum StateAction: Action {
    
    case count(CountAction)
    case text(TextAction)
    
    var count: CountAction? {
        get {
          guard case let .count(value) = self else { return nil }
          return value
        }
        set {
          guard case .count = self, let newValue = newValue else { return }
          self = .count(newValue)
        }
    }
    
    var text: TextAction? {
        get {
          guard case let .text(value) = self else { return nil }
          return value
        }
        set {
          guard case .text = self, let newValue = newValue else { return }
          self = .text(newValue)
        }
    }
}

func countReducer(value: inout Int, action: CountAction) {
    switch action {
    case .incr:
        value += 1
        
    case .decr:
        value -= 1
    }
}

func textReducer(value: inout String, action: TextAction) {
    switch action {
    case let .write(newValue):
        value = newValue
        
    case .cleare:
        value = ""
    }
}

let reducer: (inout State, StateAction) -> Void = combine(
    pullback(countReducer, value: \.count, action: \.count),
    pullback(textReducer, value: \.text, action: \.text)
)

func f() {
    let store = Store<State, StateAction>(State(count: 0, text: ""), reducer: reducer)
    store.provide(.text(.write("test")))
    store.provide(.count(.incr))
    store.provide(.count(.incr))
    store.provide(.count(.incr))
    store.provide(.count(.incr))
    store.provide(.text(.write("sdjkvbh jds ajv ahs j")))
    store.provide(.text(.cleare))
    store.provide(.text(.write("slkdjsac")))
}

