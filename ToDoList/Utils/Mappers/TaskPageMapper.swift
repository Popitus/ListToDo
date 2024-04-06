import Foundation

enum TaskPageMapper {
    static func mapToData(taskPageLocal: TaskPageLocal) -> TaskPageItem {
        return TaskPageItem(
            id: taskPageLocal.id,
            title: taskPageLocal.title,
            selected: taskPageLocal.selected,
            date: taskPageLocal.date,
            taskItems: taskPageLocal.tasksItems.map { TaskMapper.mapToData(taskLocal: $0) }
        )
    }

    static func mapToDomain(taskPageItem: TaskPageItem) -> TaskPageLocal {
        return TaskPageLocal(
            id: taskPageItem.id,
            title: taskPageItem.title,
            selected: taskPageItem.selected,
            date: taskPageItem.date,
            taskItems: taskPageItem.tasksItems.map { TaskMapper.mapToDomain(taskItem: $0) }
        )
    }
}
