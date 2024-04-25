//
//  TaskLocal.swift
//  ToDoList
//
//  Created by Adrian Iraizos Mendoza on 25/4/24.
//

import Foundation

extension TasksLocal {
    static let sample = TasksLocal(title: "Prueba", date: Date.now, status: .pending, note: "Prueba de nota", lastUpdate: Date(), sticker: Sticker.car)
}


extension TagLocal {
    static let samples = [TagLocal(title: "Tag1"), TagLocal(title: "Tag2")]
}


extension TaskViewModel {
    static var preview: TaskViewModel {
        let context = SwiftDataManagerFake.shared
     
        let previewTaskUseCase = TaskUseCase(swiftDataManager: context)
        let previewPageUseCase = TaskPageUseCase(swiftDataManager: context)
        let previewTagUseCase = TagUseCase(swiftDataManager: context)
        
        return TaskViewModel(taskUseCase: previewTaskUseCase, taskPageUseCase: previewPageUseCase, tagUseCase: previewTagUseCase)
    }
}
