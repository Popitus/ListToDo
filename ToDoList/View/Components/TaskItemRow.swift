//
//  TaskItemRow.swift
//  ToDoList
//
//  Created by Oliver Ramírez Cáceres on 15/1/24.
//

import SwiftUI

struct TaskItemRow: View {
    
    var task: TaskItem
    var toggleCompletion: () -> Void
    
    var body: some View {
        HStack {
            Button(action: toggleCompletion, label: {
                Image(systemName: task.completed ? "checkmark.square" : "square")
                    .foregroundStyle(task.completed ? .green : .black)
            })
            
            Text(task.title)
                .strikethrough(task.completed)
                .foregroundColor(task.completed ? .gray : .primary)
            
            Spacer()
        }
    }
}		

#Preview {
        TaskItemRow(task: TaskItem(title: "Test"), toggleCompletion: {})
}
