
@testable import ToDoList
import Foundation

var taskMock: [TaskItem] = []

struct TaskUseCaseMock: TaskUseCaseProtocol {
    
    func addTask(with title: String, idTaskPage: UUID) -> [TaskItem] {
        let newTask = TaskItem(title: title, date: Date(), status: .pending, note: "", lastUpdate: Date())
        
        taskMock.append(newTask)
        return taskMock
        
    }
    
    func toggleTaskCompletion(task: ToDoList.TaskItem) {
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
    
    func removeTask(at index: IndexSet) -> [TaskItem]{
        for index in index {
            taskMock.remove(at: index)
        }
        return taskMock
    }
    
    
}
