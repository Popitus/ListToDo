import Foundation

enum TaskMapper {
    static func mapToData(taskLocal: TasksLocal) -> TaskItem {
        let taskPage = taskLocal.taskPageItemID ?? UUID()
        return TaskItem(
            id: taskLocal.id,
            title: taskLocal.title,
            date: taskLocal.date,
            status: taskLocal.status,
            note: taskLocal.note,
            lastUpdate: taskLocal.lastUpdate,
            completed: taskLocal.completed,
            sticker: taskLocal.sticker,
            taskPageItem: TaskPageItem(id: taskPage, title: ""),
            tag: taskLocal.tag.map { TagMapper.mapToData(tagLocal: $0) }
        )
    }

    static func mapToDomain(taskItem: TaskItem) -> TasksLocal {
        let taskPage = taskItem.taskPageItem?.id ?? UUID()
        return TasksLocal(
            id: taskItem.id,
            title: taskItem.title,
            date: taskItem.date,
            status: taskItem.status,
            note: taskItem.note,
            lastUpdate: taskItem.lastUpdate,
            completed: taskItem.completed,
            sticker: taskItem.sticker,
            taskPageItemID: taskPage,
            tag: taskItem.tag.map { TagMapper.mapToDomain(tagItem: $0) }
        )
    }

    static func mapToDomainTestable(taskItem: TaskItem) -> TasksLocal {
        return TasksLocal(
            id: taskItem.id,
            title: taskItem.title,
            date: taskItem.date,
            status: taskItem.status,
            note: taskItem.note,
            lastUpdate: taskItem.lastUpdate,
            completed: taskItem.completed,
            sticker: taskItem.sticker,
            tag: taskItem.tag.map { TagMapper.mapToDomain(tagItem: $0) }
        )
    }
}
