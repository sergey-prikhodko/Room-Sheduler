//
//  User.swift
//  Core
//
//  Created by Sergey Prikhodko on 19.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import Foundation

public struct User: Decodable {
    
    public var firstName: String
    public var lastName: String
    public var age: Int
    public var bio: String
    
    public var login: String
    public var password: String
}

// MARK: - Empty

public extension User {
    
    static var empty: User {
        return User(firstName: "Sergey",
                    lastName: "Prikhodko",
                    age: 24,
                    bio: "iOS dev",
                    login: "sergey-prikhodko",
                    password: "123456")
    }
}
