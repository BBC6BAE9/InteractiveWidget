//
//  ToggleIntentState.swift
//  InteractiveWidget
//
//  Created by ihenry on 2023/10/19.
//

import Foundation
import AppIntents

struct ToggleIntentState: AppIntent {
    
    init() {}
    
    static var title: LocalizedStringResource = "Toggle Task State"
    @Parameter(title: "TaskID")
    var id:String
    
    init(id:String) {
        self.id = id
    }
    
    func perform() async throws -> some IntentResult {
        // 更新数据
        if let index = TaskDataModel.shared.tasks.firstIndex(where: {
            $0.id == id
        }){
            TaskDataModel.shared.tasks[index].isComplete.toggle()
        }
        return .result()
    }
}
