//
//  Date.swift
//  PureSip
//
//  Created by Rafael Serrano Gamarra on 30/11/24.
//

import Foundation

extension Date {
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
}
