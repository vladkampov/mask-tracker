//
//  Mask_Tracker_Widget.swift
//  Mask Tracker Widget
//
//  Created by Vladyslav Kampov on 11.10.2020.
//

import WidgetKit
import SwiftUI
import Intents
import CoreData

struct Provider: IntentTimelineProvider {
    private let viewContext = PersistenceController.shared.container.viewContext

    func placeholder(in context: Context) -> MaskDataEntry {
        let m = MaskData.init(context: viewContext)
        m.id = UUID()
        m.name = "Lalka"
        m.changedAt = Date()
        m.createdAt = Date()
        m.image = "Mask Placeholder"
        m.isCounterActive = false
        m.secondsInUse = 545
        m.secondsToBeUsed = 7300
        return MaskDataEntry(configuration: ConfigurationIntent(), mask: m)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (MaskDataEntry) -> Void) {
        var masks = [MaskData]()
        let fetchRequest = NSFetchRequest<MaskData>(entityName: "MaskData")
        do {
            try masks = viewContext.fetch(fetchRequest) as [MaskData]
        } catch {
            print(error)
        }
        let entry: MaskDataEntry = MaskDataEntry(configuration: configuration, mask: masks.isEmpty ? nil : masks[0])
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var masks = [MaskData]()
        let fetchRequest = NSFetchRequest<MaskData>(entityName: "MaskData")
        do {
            try masks = viewContext.fetch(fetchRequest) as [MaskData]
        } catch {
            print(error)
        }

        let entries: [MaskDataEntry] = [MaskDataEntry(configuration: configuration, mask: masks.isEmpty ? nil : masks[0])]

        if !masks.isEmpty && masks[0].isCounterActive {
            Timer.scheduledTimer(withTimeInterval: 15.0, repeats: true) { (_) in
                WidgetCenter.shared.reloadAllTimelines()
            }
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct MaskDataEntry: TimelineEntry {
    let date = Calendar.current.date(byAdding: .minute, value: 5, to: Date())!
    let configuration: ConfigurationIntent
    let mask: MaskData?
}

struct Mask_Tracker_WidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        if entry.mask == nil {
            return CardView(title: "newMaskCard.title", description: "newMaskCard.description", image: "Mask Placeholder", isRunning: false)
                .scaleEffect(0.7, anchor: .center)
        }

        let (hours, minutes, seconds) = secondsToHoursMinutesSeconds(seconds: Int(entry.mask!.secondsInUse))
        let percent = usedPercentage(current: entry.mask!.secondsInUse, max: entry.mask!.secondsToBeUsed)

        return CardView(title: entry.mask!.name, description: String(format: "%02i:%02i:%02i", hours, minutes, seconds), image: "Mask Placeholder", percent: percent, isRunning: entry.mask!.isCounterActive)
            .scaleEffect(0.7, anchor: .center)
    }
}

@main
struct Mask_Tracker_Widget: Widget {
    let kind: String = "Mask_Tracker_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Mask_Tracker_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName(NSLocalizedString("widget.title", comment: "widget title"))
        .description(NSLocalizedString("widget.description", comment: "widget description"))
    }
}

struct Mask_Tracker_Widget_Previews: PreviewProvider {
    static var previews: some View {
        let m = MaskData.init()

        return Mask_Tracker_WidgetEntryView(entry: MaskDataEntry(configuration: ConfigurationIntent(), mask: m))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
