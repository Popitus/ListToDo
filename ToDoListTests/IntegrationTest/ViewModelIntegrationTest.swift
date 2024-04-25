
@testable import ToDoList
import XCTest

@MainActor
final class ViewModelIntegrationTest: XCTestCase {
    var sut: TaskViewModel?

    override func setUpWithError() throws {
        let swiftDataManager = SwiftDataManagerFake.shared
        swiftDataManager.modelContainer = SwiftDataManagerFake.setupContainer()

        let taskUseCase = TaskUseCase(swiftDataManager: swiftDataManager)
        let taskPageUseCase = TaskPageUseCase(swiftDataManager: swiftDataManager)
        let tagUseCase = TagUseCase(swiftDataManager: swiftDataManager)

        sut = TaskViewModel(
            taskUseCase: taskUseCase,
            taskPageUseCase: taskPageUseCase,
            tagUseCase: tagUseCase
        )
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // MARK: - Viewmodel Integration Test: TaskPageItems

    func testAddPage() {
        sut?.addTaskPage(title: "Texto pagina 1")
        let page = sut?.pages.first

        XCTAssertNotNil(page)
        XCTAssertEqual(page?.title, "Texto pagina 1")
        XCTAssertEqual(sut?.pages.count, 1)
    }

    func testAddTwoPage() {
        sut?.addTaskPage(title: "Texto pagina 2")
        sut?.addTaskPage(title: "Texto pagina 3")
        let page = sut?.pages.first
        let page2 = sut?.pages.last

        XCTAssertNotNil(page)
        XCTAssertNotNil(page2)
        XCTAssertEqual(page?.title, "Texto pagina 2")
        XCTAssertEqual(page2?.title, "Texto pagina 3")
        XCTAssertEqual(sut?.pages.count, 2)
    }

    func testToggleTaskCompletionWithTask() throws {
        createArrayOfPages()

        let page = try XCTUnwrap(sut?.pages.randomElement(),"Unable to get random page")

        if let index = sut?.pages.firstIndex(where: { $0.id == page.id }) {
            let selected = page.selected
            sut?.togglePageSelection(page: page)
            XCTAssertNotEqual(selected, sut?.pages[index].selected)
        }
    }

    func testRemovePage() throws {
        createArrayOfPages()
        let page = try XCTUnwrap(sut?.pages.randomElement())
        
        if let _ = sut?.pages.firstIndex(where: { $0.id == page.id }) {
            sut?.removePages(with: page.id)
            XCTAssertTrue((sut?.pages.contains(page)) == false)
        }
    }

    // MARK: - Viewmodel Integration Test: TasksItem

    func testAddTaskItem() throws {
        sut?.addTaskPage(title: "Texto pagina 1")
        let page = try XCTUnwrap(sut?.pages.first)
        
        sut?.addTask(title: "Texto 1", idTaskPage: page.id)

        let task = try XCTUnwrap(sut?.tasks.filter({ $0.taskPageItemID == page.id }))

        XCTAssertNotNil(page)
        XCTAssertNotNil(task)
        XCTAssertEqual(page.title, "Texto pagina 1")
        XCTAssertEqual(task[0].title, sut?.tasks.first?.title)
        XCTAssertEqual(page.id, task.first?.taskPageItemID)
        XCTAssertEqual(sut?.pages.count, 1)
        XCTAssertEqual(sut?.tasks.count, 1)
    }

    func testAddTwoTasks() throws {
        sut?.addTaskPage(title: "Texto pagina 1")

        let page = try XCTUnwrap(sut?.pages.first)
        
        sut?.addTask(title: "Texto 1", idTaskPage: page.id)
        sut?.addTask(title: "Texto 2", idTaskPage: page.id)

        let task = try XCTUnwrap(sut?.tasks.filter({ $0.taskPageItemID == page.id }))

        XCTAssertNotNil(page)
        XCTAssertNotNil(task)
        XCTAssertEqual(page.title, "Texto pagina 1")
        XCTAssertEqual(task[0].title, sut?.tasks.first?.title)
        XCTAssertEqual(task[1].title, sut?.tasks[1].title)
        XCTAssertEqual(page.id, task.first?.taskPageItemID)
        XCTAssertEqual(sut?.pages.count, 1)
        XCTAssertEqual(sut?.tasks.count, 2)
    }

    func testToggleTaskCompletion() throws {
        sut?.addTaskPage(title: "Texto pagina 1")
        let page = try XCTUnwrap(sut?.pages.first)
        
        let task = createNewTask(title: "Title 1")

        let status = sut?.tasks.first?.status

        sut?.addTask(title: task.title, idTaskPage: page.id)

        sut?.toggleTaskStatus(task: task)
        XCTAssertFalse(sut?.tasks == nil)
        XCTAssertNotEqual(status, sut?.tasks.first?.status)
    }
    func testUpdateTaskTitle() throws {
        sut?.addTaskPage(title: "Texto pagina 1")
        let page = try XCTUnwrap(sut?.pages.first)
        
        let title = "Texto 1"
        sut?.addTask(title: title, idTaskPage: page.id)
        var taskItem = try XCTUnwrap(sut?.tasks.first)
        
        taskItem.title = "Texto 2"
    
        sut?.updateTitleAndNote(with: taskItem)
        XCTAssertTrue(sut?.tasks.count == 1)
        XCTAssertNotEqual(title, sut?.tasks.first?.title)
        
    }
    
    func testUpdateTaskNote() throws {
        sut?.addTaskPage(title: "Texto pagina 1")
        
        let page = try XCTUnwrap(sut?.pages.first)
        
        let title = "Texto 1"
        sut?.addTask(title: title, idTaskPage: page.id)
        var taskItem = try XCTUnwrap(sut?.tasks.first)
        
        taskItem.note = "Prueba"
    
        sut?.updateTitleAndNote(with: taskItem)
        XCTAssertTrue(sut?.tasks.count == 1)
        XCTAssertNotEqual("", sut?.tasks.first?.note)
        XCTAssertEqual("Prueba", sut?.tasks.first?.note)
    }
    
    func testUpdateTaskWithoutChangeTitleOrNote() throws {
        sut?.addTaskPage(title: "Texto pagina 1")
        let page = try XCTUnwrap(sut?.pages.first)
        
        let title = "Texto 1"
        sut?.addTask(title: title, idTaskPage: page.id)
        let taskItem = try XCTUnwrap(sut?.tasks.first)
    
        sut?.updateTitleAndNote(with: taskItem)
        XCTAssertTrue(sut?.tasks.count == 1)
        XCTAssertEqual("", sut?.tasks.first?.note)

    }

    func testRemoveTask() throws {
        try createArrayOfTask()
        let task = try XCTUnwrap(sut?.tasks.randomElement())

        let index = try XCTUnwrap(sut?.tasks.firstIndex(of: task))

        sut?.removeTask(at: IndexSet(integer: index))

        XCTAssertEqual(sut?.tasks.count, 2)
        XCTAssertTrue((sut?.tasks.contains(task)) == false)
    }

    // MARK: - Viewmodel Integration Test: Tags

    func testAddTag() throws {
        try createArrayOfTask()
        let task = try XCTUnwrap(sut?.tasks.randomElement())
        
        let tag = TagLocal(title: "Texto Test Tag1")
        sut?.addTag(title: tag.title, idTaskItem: task.id, idTag: tag.id)

        XCTAssertTrue(tag.title == sut?.tags.first?.title)
        XCTAssertTrue(sut?.tags.count == 1)
    }

    func testAddTagWithEmptyTitle() throws {
        try createArrayOfTask()
        let task = try XCTUnwrap(sut?.tasks.randomElement())
        
        let tag = TagItem(title: "")
        sut?.addTag(title: tag.title, idTaskItem: task.id, idTag: tag.id)

        XCTAssertFalse(tag.title == sut?.tags.first?.title)
        XCTAssertTrue(sut?.tags.count == 0)
    }
    
    func testUpdateTag() throws {
       try createArrayOfTask()
        let task = try XCTUnwrap(sut?.tasks.randomElement())
        
        let title = "Texto Test Tag1"
        let tag = TagLocal(title: title)
        sut?.addTag(title: tag.title, idTaskItem: task.id, idTag: tag.id)
        XCTAssertTrue(tag.title == sut?.tags.first?.title)
        
        var tagItem = try XCTUnwrap(sut?.tags.first)
        
        tagItem.title = "Texto Nuevo"
        sut?.updateTag(tag: tagItem)
        XCTAssertFalse(tagItem.title != sut?.tags.first?.title)
        XCTAssertTrue(tagItem.id == sut?.tags.first?.id)
        
        
    }

    func testRemoveOneTag() throws {
        let tags = createArrayOfTags()
        let tag = try XCTUnwrap(tags.randomElement())
        
        let countTags = tags.count
        sut?.removeOneTag(id: tag.id)

        XCTAssertTrue(sut?.tags.contains(tag) == false)
        XCTAssertTrue(sut?.tasks.count != countTags)
    }

    func testRemoveAllTags() {
        let tags = createArrayOfTags()
        let countTags = tags.count
        sut?.removeAllTag(tag: tags)

        XCTAssertTrue(sut?.tags.count != countTags)
        XCTAssertEqual(sut?.tags, [])
    }

    // MARK: - Helpers functions

    private func createArrayOfTags() -> [TagLocal] {
        var arrayOfTags: [TagLocal] = []
        arrayOfTags.append(TagLocal(title: "Tag1"))
        arrayOfTags.append(TagLocal(title: "Tag2"))
        arrayOfTags.append(TagLocal(title: "Tag3"))
        return arrayOfTags
    }

    private func createArrayOfPages() {
        sut?.addTaskPage(title: "Titulo página 1")
        sut?.addTaskPage(title: "Titulo página 2")
        sut?.addTaskPage(title: "Titulo página 3")
    }

    private func createArrayOfTask() throws {
        createArrayOfPages()
        let page = try XCTUnwrap(sut?.pages.randomElement())
        
        sut?.addTask(title: "Titulo task1", idTaskPage: page.id)
        sut?.addTask(title: "Titulo task2", idTaskPage: page.id)
        sut?.addTask(title: "Titulo task3", idTaskPage: page.id)
    }
    
    private func createNewTask(title: String) -> TasksLocal {
        TasksLocal(title: title, date: .now, status: .pending, note: "", lastUpdate: .now,sticker: .none)
    }
}
