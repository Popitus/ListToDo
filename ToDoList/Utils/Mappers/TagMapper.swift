import Foundation

struct TagMapper {
    static func mapToData(tagLocal: TagLocal) -> TagItem {
        return TagItem(
            id: tagLocal.id,
            title: tagLocal.title,
            isInitial: tagLocal.isInitial,
            date: tagLocal.date,
            taskItem: tagLocal.taskItem.map{ TaskMapper.mapToData(taskLocal: $0)})
    }
    
    static func mapToDomain(tagItem: TagItem) -> TagLocal {
        return TagLocal(
            id: tagItem.id,
            title: tagItem.title,
            isInitial: tagItem.isInitial,
            date: tagItem.date,
            taskItem: tagItem.taskItem.map{ TaskMapper.mapToDomain(taskItem: $0)})
    }
}
