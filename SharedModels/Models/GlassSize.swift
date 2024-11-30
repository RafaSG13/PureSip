//
//  GlassSize.swift
//  SharedModels
//
//  Created by Rafael Serrano Gamarra on 6/11/24.
//

import Foundation
import AppIntents

public enum GlassSize: Double, CaseIterable {
    case small = 0.25
    case medium = 0.5
    case large = 1
}

extension GlassSize: AppEnum {
    public static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Glass Size")

    public static var caseDisplayRepresentations: [GlassSize: DisplayRepresentation] = [
        .small: DisplayRepresentation("Small"),
        .medium: DisplayRepresentation("Medium"),
        .large: DisplayRepresentation("Large")
    ]
}

