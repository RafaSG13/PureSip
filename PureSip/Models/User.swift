//
//  User.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 27/8/24.
//

import Foundation
import SwiftData

@Model
class User {
    @Attribute(.unique) let email: String
    
    init(email: String) {
        self.email = email
    }
}
