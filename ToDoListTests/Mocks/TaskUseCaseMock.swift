
import Foundation
@testable import ToDoList

var taskMock: [TaskItem] = []

struct TaskUseCaseMock: TaskUseCaseProtocol {
    
    func addTask(with title: String, idTaskPage: UUID) -> TasksLocal? {
        if let index = pagesMock.firstIndex(where: { $0.id == idTaskPage }), !title.isEmpty {
            var newTask = TasksLocal(
                title: title,
                date: Date(),
                status: TodoStatus.pending,
                note: "",
                lastUpdate: Date(),
                taskPageItemID: pagesMock[index].id
            )
            newTask.tag = []
            taskMock.append(TaskMapper.mapToData(taskLocal: newTask))
            return newTask
        }
        return nil
    }

    func toggleTaskCompletion(task: TasksLocal) -> [TasksLocal] {
        if let index = taskMock.firstIndex(where: { $0.id == task.id }) {
            let status = task.status
            taskMock[index].completed.toggle()
            switch status {
            case .completed:
                taskMock[index].status = .pending
            case .pending:
                taskMock[index].lastUpdate = Date()
                taskMock[index].status = .completed
            }
        }
        return taskMock.map { TaskMapper.mapToDomainTestable(taskItem: $0) }
    }

    func removeTask(at index: IndexSet) -> Int? {
        for index in index {
            taskMock.remove(at: index)
            return index
        }
        return nil
    }

    func removeTasks(tasks _: [TasksLocal]) -> [TasksLocal] {
        let tasklocal = taskMock.map { TaskMapper.mapToDomain(taskItem: $0) }
        for task in tasklocal {
            if let index = tasklocal.firstIndex(of: task) {
                taskMock.remove(at: index)
            }
        }
        return fetchAllTask()
    }
    
    func updateTask(task: TasksLocal) -> [TasksLocal] {
        if let index = taskMock.firstIndex(where: { $0.id == task.id }) {
            taskMock[index].title = task.title
            taskMock[index].note = task.note
        }
        return taskMock.map { TaskMapper.mapToDomainTestable(taskItem: $0) }
    }

    func fetchAllTask() -> [TasksLocal] {
        return taskMock.map { TaskMapper.mapToDomain(taskItem: $0) }
    }
}
