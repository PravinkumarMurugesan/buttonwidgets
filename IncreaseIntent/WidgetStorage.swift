//
//  WidgetStorage.swift
//  ButtonWidgets
//
//  Created by Pravinkumar on 21/01/26.
//

import Foundation

class WidgetStorage {

    static let shared = WidgetStorage()

    private let defaults = UserDefaults(
        suiteName: "group.com.pravinkumar.widgets"
    )

    private let key = "counter_value"

    var value: Int {
        get {
            defaults?.integer(forKey: key) ?? 0
        }
        set {
            defaults?.set(newValue, forKey: key)
        }
    }
}
