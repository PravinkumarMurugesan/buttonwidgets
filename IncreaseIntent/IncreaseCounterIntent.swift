//
//  IncreaseCounterIntent.swift
//  ButtonWidgets
//
//  Created by Pravinkumar on 21/01/26.
//

import AppIntents
import WidgetKit

struct IncreaseCounterIntent: AppIntent {

    static var title: LocalizedStringResource = "Increase"

    func perform() async throws -> some IntentResult {
        await MainActor.run {
            WidgetStorage.shared.value += 1
        }
        WidgetCenter.shared.reloadAllTimelines()
        return .result()
    }
}

