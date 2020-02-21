//
//  HasCancelableBag.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 21.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import Foundation
import ObjectiveC
import Combine

fileprivate var cancelableBagContext: UInt8 = 0

public protocol HasCancelableBag: class {

    var cancelableBag: Set<AnyCancellable> { get set }
}

extension HasCancelableBag {

    func synchronizedBag<T>( _ action: () -> T) -> T {
        objc_sync_enter(self)
        let result = action()
        objc_sync_exit(self)
        return result
    }

    public var cancelableBag: Set<AnyCancellable> {
        get {
            return synchronizedBag {
                if let cancelableObject = objc_getAssociatedObject(self, &cancelableBagContext) as? Set<AnyCancellable> {
                    return cancelableObject
                }
                let cancelableObject = Set<AnyCancellable>()
                objc_setAssociatedObject(self, &cancelableBagContext, cancelableObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return cancelableObject
            }
        }

        set {
            synchronizedBag {
                objc_setAssociatedObject(self, &cancelableBagContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
