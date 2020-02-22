//
//  Store.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 21.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import Foundation
import Combine

protocol Action {}

final class Store<S, A: Action> {
    
    @Published var state: S
    
    private let reducer: (inout S, A) -> Void
    
    init(_ state: S, reducer: @escaping (inout S, A) -> Void) {
        self.state = state
        self.reducer = reducer
    }
    
    func provide(_ action: A) {
        var newState = state
        reducer(&newState, action)
        
        state = newState
    }
}

struct State {
    
    var count: Int
}

enum CountAction: Action {
    
    case incr
    case decr
}

func reducer(state: inout State, action: CountAction) {
    switch action {
    case .incr:
        state.count += 1
        
    case .decr:
        state.count -= 1
    }
}

func f() {
    let store = Store<State, CountAction>.init(State(count: 0), reducer: reducer(state:action:))
    store.provide(.incr)
    store.provide(.incr)
    store.provide(.decr)
    
    \CountAction
}

