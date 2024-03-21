import Foundation

struct TaskMapper {
    static func mapToData(taskLocal: TaskLocal) -> TaskItem {
        let taskPage = taskLocal.taskPageItem ?? TaskPageLocal(title: "")
        return TaskItem(
            id: taskLocal.id,
            title: taskLocal.title,
            date: taskLocal.date,
            status: taskLocal.status,
            note: taskLocal.note,
            lastUpdate: taskLocal.lastUpdate,
            completed: taskLocal.completed,
            taskPageItem: TaskPageMapper.mapToData(taskPageLocal: taskPage),
            tag: taskLocal.tag.map{ TagMapper.mapToData(tagLocal: $0)})
    }
    
    static func mapToDomain(taskItem: TaskItem) -> TaskLocal {
        let taskPage = taskItem.taskPageItem ?? TaskPageItem(title: "")
        return TaskLocal(
            id: taskItem.id,
            title: taskItem.title,
            date: taskItem.date,
            status: taskItem.status,
            note: taskItem.note,
            lastUpdate: taskItem.lastUpdate,
            completed: taskItem.completed,
            taskPageItem: TaskPageMapper.mapToDomain(taskPageItem: taskPage),
            tag: taskItem.tag.map{ TagMapper.mapToDomain(tagItem: $0)})
    }
}
