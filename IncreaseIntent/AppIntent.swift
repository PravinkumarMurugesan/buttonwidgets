//
//  AppIntent.swift
//  IncreaseIntent
//
//  Created by Pravinkumar on 21/01/26.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is an example widget." }

    // An example configurable parameter.
    @Parameter(title: "Hi am pravinkumar", default: "😃")
    var favoriteEmoji: String
}
