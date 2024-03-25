import Foundation

struct TagMapper {
    static func mapToData(tagLocal: TagLocal) -> TagItem {
        let tag = tagLocal.taskItemID ?? UUID()
        return TagItem(
            id: tagLocal.id,
            title: tagLocal.title,
            isInitial: tagLocal.isInitial,
            date: tagLocal.date,
            taskItem: TaskItem(id: tag, title: "", date: .now, status: .pending, note: "", lastUpdate: .now))
    }
    
    static func mapToDomain(tagItem: TagItem) -> TagLocal {
        let tag = tagItem.taskItem?.id ?? UUID()
        return TagLocal(
            id: tagItem.id,
            title: tagItem.title,
            isInitial: tagItem.isInitial,
            date: tagItem.date,
            taskItemID: tag)
    }
}
