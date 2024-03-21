
@testable import ToDoList
import Foundation

var taskMock: [TaskItem] = []

struct TaskUseCaseMock: TaskUseCaseProtocol {
    
    func addTask(with title: String, idTaskPage: UUID) -> TaskItem? {
        if let index = pagesMock.firstIndex(where: {$0.id == idTaskPage }), !title.isEmpty {
            let newTask = TaskItem(
                title: title,
                date: Date(),
                status: TodoStatus.pending,
                note: "",
                lastUpdate: Date(),
                taskPageItem: pagesMock[index]
            )
            newTask.tag = []
            taskMock.append(newTask)
            //pagesMock[index].tasksItems = taskMock
            return newTask
        }
        return nil
        
    }
    
    func toggleTaskCompletion(task: TaskItem) {
        if let index = taskMock.firstIndex(where: {$0.id == task.id}) {
            let status = task.status
            taskMock[index].completed.toggle()
            switch status {
            case .completed:
                return taskMock[index].status = .pending
            case .pending:
                taskMock[index].lastUpdate = Date()
                return taskMock[index].status = .completed
            }
        }
    }
    
    func removeTask(at index: IndexSet) -> Int? {
        for index in index {
            taskMock.remove(at: index)
            return index
        }
        return nil
    }
    
    func removeTasks(tasks: [TaskItem]) -> [TaskItem] {
        for task in tasks {
            if let index = taskMock.firstIndex(of: task) {
                taskMock.remove(at: index)
            }
        }
        return taskMock
    }
    
    func fetchAllTask() -> [TaskItem] {
        return taskMock
    }
    
    
}
