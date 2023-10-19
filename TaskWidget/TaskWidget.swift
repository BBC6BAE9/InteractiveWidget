//
//  TaskWidget.swift
//  TaskWidget
//
//  Created by ihenry on 2023/10/19.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> TaskEntry {
        TaskEntry(lastThreeTasks: Array(TaskDataModel.shared.tasks.prefix(3)))
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> TaskEntry {
        TaskEntry(lastThreeTasks: Array(TaskDataModel.shared.tasks.prefix(3)))
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<TaskEntry> {
        let lastestTasks = Array(TaskDataModel.shared.tasks.prefix(3))
        let lastestEntires = [TaskEntry(lastThreeTasks: lastestTasks)]
        return Timeline(entries: lastestEntires, policy: .atEnd)
    }
}

struct TaskEntry: TimelineEntry {
    let date: Date = .now
    var lastThreeTasks:[TaskModel]
    
}

struct TaskWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 0 ){
            Text("任务")
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            VStack(alignment: .leading, spacing: 6) {
                if entry.lastThreeTasks.isEmpty{
                    Text("没有任务")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }else{
                    ForEach(entry.lastThreeTasks){ task in
                        HStack(spacing:6){
                            Button(intent: ToggleIntentState(id: task.id)) {
                                Image(systemName: task.isComplete ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(.green)
                            }
                            .buttonStyle(.plain)
                            VStack(alignment: .leading, spacing: 4){
                                Text(task.taskTitle)
                                    .textScale(.secondary)
                                    .lineLimit(1)
                                    .strikethrough(task.isComplete, pattern: .solid, color: .primary)
                                Divider()
                            }
                        }
                        
                        if task.id != entry.lastThreeTasks.last?.id {
                            Spacer(minLength: 0)
                        }
                    }
                }
                    
            }
        }
    }
}

struct TaskWidget: Widget {
    let kind: String = "TaskWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            TaskWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
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
    TaskWidget()
} timeline: {
    TaskEntry(lastThreeTasks: TaskDataModel.shared.tasks)
}
