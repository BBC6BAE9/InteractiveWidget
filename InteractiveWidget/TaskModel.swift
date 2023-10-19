//
//  TaskModel.swift
//  InteractiveWidget
//
//  Created by ihenry on 2023/10/19.
//

import SwiftUI

struct TaskModel:Identifiable {
    var id:String = UUID().uuidString
    var taskTitle: String
    var isComplete:Bool = false
}

struct TaskDataModel {
    static var shared = TaskDataModel()
    var tasks:[TaskModel] = [
        .init(taskTitle: "预约功能开发"),
        .init(taskTitle: "VisionOS网络库适配"),
        .init(taskTitle: "TVKPlayer接入")
    ]
}
