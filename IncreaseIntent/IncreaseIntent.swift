//
//  IncreaseIntent.swift
//  IncreaseIntent
//
//  Created by Pravinkumar on 21/01/26.
//

import WidgetKit
import AppIntents
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), post: nil)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), post: nil)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        
        let url  = URL(string:"https://jsonplaceholder.typicode.com/posts/1")!
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        var post : Post? = nil
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            post = try JSONDecoder().decode(Post.self, from: data)
            if let post = post {
                print(post)
            } else {
                print("Post is nil")
            }
        } catch {
            print("API Error:", error)
        }
        let entry =  SimpleEntry(date: Date(), post: post)
        
        let nextRefresh = Calendar.current.date(byAdding: .second, value: 10, to: Date())!
        
        return Timeline(entries: [entry], policy: .after(nextRefresh))
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let post : Post?
}


struct IncreaseIntentEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            if let post = entry.post {
                Text("User ID : \(String(post.userId))")
                    .font(.caption)
                Text("Id :\(String(post.id))")
                    .font(.caption)
                Text("Title :\(post.title)")
                    .font(.headline)
                Text("Body : \(post.body)")
                    .font(.caption)
            } else {
                Text("Loading...")
            }
        }.padding()
    }
}

struct IncreaseIntent: Widget {
    let kind: String = "IncreaseIntent"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            IncreaseIntentEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Counter Widgets")
        .description("Increase or decrease widgets")
        //.supportedFamilies([.systemSmall])
        
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    IncreaseIntent()
} timeline: {
    SimpleEntry(date: .now, post: nil)
    //SimpleEntry(date: .now, configuration: .starEyes)
}
