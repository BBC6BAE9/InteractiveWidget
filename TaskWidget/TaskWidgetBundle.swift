//
//  TaskWidgetBundle.swift
//  TaskWidget
//
//  Created by ihenry on 2023/10/19.
//

import WidgetKit
import SwiftUI

@main
struct TaskWidgetBundle: WidgetBundle {
    var body: some Widget {
        TaskWidget()
        TaskWidgetLiveActivity()
    }
}
