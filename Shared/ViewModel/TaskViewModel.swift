//
//  TaskViewModel.swift
//  Task Manager
//
//  Created by Yuan on 01/07/2022.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
    @Published var currentTab: String = "Today"
    
    // New Task Properties
    @Published var openEditTask: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskDeadline: Date = Date()
    @Published var taskType: String = "Basic"
    // @Published var taskIsCompleted: Bool = false
    
    @Published var showDatePicker: Bool = false
    
    func addTask(context: NSManagedObjectContext) -> Bool {
        let task: Task = Task(context: context)
        task.title = taskTitle
        task.color = taskColor
        task.deadline = taskDeadline
        task.type = taskType
        task.isCompleted = false
        
        if let _ = try? context.save() {
            return true
        }
        return false
    }
    
    func resetTaskData() -> Void {
        taskTitle = ""
        taskColor = "Yellow"
        taskDeadline = Date()
        taskType = "Basic"
        // taskIsCompleted = false
    }
    
}
