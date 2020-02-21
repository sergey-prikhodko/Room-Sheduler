//
//  File.swift
//  Room Scheduler
//
//  Created by Sergey Prikhodko on 20.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import Foundation
import Combine

class CombineCancelable {
    
    var cancelableBag = Set<AnyCancellable>()
}
