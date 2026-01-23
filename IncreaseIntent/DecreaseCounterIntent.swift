//
//  DecreaseCounterIntent.swift
//  ButtonWidgets
//
//  Created by Pravinkumar on 21/01/26.
//

import SwiftUI
import AppIntents
import WidgetKit

struct DecreaseCounterIntent: AppIntent {

    static var title: LocalizedStringResource = "Decrease"

    func perform() async throws -> some IntentResult {
        await MainActor.run {
            WidgetStorage.shared.value -= 1
        }
        WidgetCenter.shared.reloadAllTimelines()
        return .result()
    }
}

