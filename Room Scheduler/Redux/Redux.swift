//
//  Redux.swift
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

final class Store<State, Action> {
    
    @Published private(set) var state: State
    
    private let reducer: (inout State, Action) -> Void
    private var cancellable: Cancellable?
    
    init(_ state: State, reducer: @escaping (inout State, Action) -> Void) {
        self.state = state
        self.reducer = reducer
    }
    
    func provide(_ action: Action) {
        reducer(&state, action)
    }
    
    public func substore<LocalValue, LocalAction>(
        value toLocalValue: @escaping (State) -> LocalValue,
        action toGlobalAction: @escaping (LocalAction) -> Action
    ) -> Store<LocalValue, LocalAction> {
        let localStore = Store<LocalValue, LocalAction>(toLocalValue(state)) { [weak self] localValue, localAction in
            guard let self = self else { return }
            
            self.provide(toGlobalAction(localAction))
            localValue = toLocalValue(self.state)
        }
        localStore.cancellable = self.$state.map { toLocalValue($0) }.assign(to: \.state, on: localStore)
        
        return localStore
    }
}

func logging<Value, Action>(
    _ reducer: @escaping (inout Value, Action) -> Void
) -> (inout Value, Action) -> Void {
    return { value, action in
        reducer(&value, action)
        print("Action: \(action)")
        print("Value:")
        dump(value)
        print("---")
    }
}

// MARK: - Test Example

//struct State {
//
//    var count: Int
//    var text: String
//}
//
//enum CountAction {
//
//    case incr
//    case decr
//}
//
//enum TextAction {
//
//    case write(String)
//    case cleare
//}
//
//enum StateAction {
//
//    case count(CountAction)
//    case text(TextAction)
//
//    var count: CountAction? {
//        get {
//          guard case let .count(value) = self else { return nil }
//          return value
//        }
//        set {
//          guard case .count = self, let newValue = newValue else { return }
//          self = .count(newValue)
//        }
//    }
//
//    var text: TextAction? {
//        get {
//          guard case let .text(value) = self else { return nil }
//          return value
//        }
//        set {
//          guard case .text = self, let newValue = newValue else { return }
//          self = .text(newValue)
//        }
//    }
//}
//
//func countReducer(value: inout Int, action: CountAction) {
//    switch action {
//    case .incr:
//        value += 1
//
//    case .decr:
//        value -= 1
//    }
//}
//
//
//func textReducer(value: inout String, action: TextAction) {
//    switch action {
//    case let .write(newValue):
//        value = newValue
//
//    case .cleare:
//        value = ""
//    }
//}
//
//let reducer: (inout State, StateAction) -> Void = combine(
//    pullback(countReducer, value: \.count, action: \.count),
//    pullback(textReducer, value: \.text, action: \.text)
//)

//let store = Store<State, StateAction>(State(count: 0, text: ""), reducer: reducer)
//
//final class TestStoreProvider<LocalValue, LocalAction> {
//
//    private var store: Store<LocalValue, LocalAction>
//    private var cancellable: Cancellable?
//
//    init(_ store: Store<LocalValue, LocalAction>, name: String) {
//        self.store = store
//
//        cancellable = store.$state.sink { print("Obj: \(name): \($0)") }
//    }
//
//    func provide(_ action: LocalAction) {
//        store.provide(action)
//    }
//}
//
//let countProvider = TestStoreProvider<Int, CountAction>(
//    store.substore(value: { $0.count }, action: { .count($0) }),
//    name: "counter 1"
//)
//
//let textProvider = TestStoreProvider<String, TextAction>(
//    store.substore(value: { $0.text }, action: { .text($0) }),
//    name: "writer 1"
//)
//
//textProvider.provide(.write("dklsvnbkfj"))
//print("---")
//textProvider.provide(.write("djskvbfjkvdsbvjbbkv"))
//print("---")
//
//countProvider.provide(.incr)
//print("---")
//countProvider.provide(.incr)
//print("---")
//countProvider.provide(.decr)
//print("---")
//
//textProvider.provide(.write("38383838"))
//print("---")
//textProvider.provide(.cleare)
//print("---")
//
//countProvider.provide(.incr)
//print("---")
//countProvider.provide(.decr)
//print("---")
//countProvider.provide(.incr)
//print("---")
//
//textProvider.provide(.write("kkkkkkkkkk"))
//print("---")
//
//let countProvider2 = TestStoreProvider<Int, CountAction>(
//    store.substore(value: { $0.count }, action: { .count($0) }),
//    name: "counter 2"
//)
//
//countProvider2.provide(.incr)
//print("---")
//countProvider2.provide(.incr)
//print("---")
//countProvider2.provide(.incr)
//print("---")
//countProvider2.provide(.incr)
//print("---")
