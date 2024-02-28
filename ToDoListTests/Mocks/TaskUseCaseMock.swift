
@testable import ToDoList
import Foundation

var taskMock: [TaskItem] = []

struct TaskUseCaseMock: TaskUseCaseProtocol {
    
    func addTask(with title: String, idTaskPage: UUID) -> [TaskItem] {
        let pages = pagesMock
        if let index = pagesMock.firstIndex(where: {$0.id == idTaskPage }) {
            let newTask = TaskItem(
                title: title,
                date: Date(),
                status: TodoStatus.pending,
                note: "",
                lastUpdate: Date()
            )
            newTask.taskPageItem?.id = pages[index].id
            taskMock.append(newTask)
        }
        return taskMock
        
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
    
    func removeTask(at index: IndexSet) -> [TaskItem]{
        for index in index {
            taskMock.remove(at: index)
        }
        return taskMock
    }
    
    func fetchAllTask() -> [TaskItem] {
        return taskMock
    }
    
    
}
