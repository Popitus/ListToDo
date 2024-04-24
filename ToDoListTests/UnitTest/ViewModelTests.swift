
@testable import ToDoList
import XCTest

final class ViewModelTests: XCTestCase {
    var viewModel: TaskViewModel?

    override func setUpWithError() throws {
        viewModel = TaskViewModel(
            taskUseCase: TaskUseCaseMock(),
            taskPageUseCase: TaskPageUseCaseMock(),
            tagUseCase: TagUseCaseMock()
        )
    }

    override func tearDownWithError() throws {
        tagMock = []
        taskMock = []
        pagesMock = []
    }

    // MARK: - Page Testing

    func testAddPage() {
        let pageTitle = "Test Page number 1"
        viewModel?.addTaskPage(title: pageTitle)

        XCTAssertTrue((viewModel?.pages.isEmpty) != nil)
        XCTAssertEqual(viewModel?.pages.count, 1)
        XCTAssertEqual(viewModel?.pages.first?.title, pageTitle)
    }

    func testAddEmptyPage() {
        let pageTitle = ""
        viewModel?.addTaskPage(title: pageTitle)

        XCTAssertTrue((viewModel?.pages) == [])
        XCTAssertEqual(viewModel?.pages.count, 0)
        XCTAssertNotEqual(viewModel?.pages.first?.title, pageTitle)
    }

    func testAddThreePages() {
        createArrayOfPages()

        XCTAssertTrue((viewModel?.pages.isEmpty) != nil)
        XCTAssertEqual(viewModel?.pages.first?.title, pagesMock[0].title)
        XCTAssertEqual(viewModel?.pages.count, 3)
        XCTAssertEqual(viewModel?.pages[1].title, pagesMock[1].title)
    }

    func testTogglePageSelection() throws {
        createArrayOfPages()
        let page = try XCTUnwrap(viewModel?.pages.randomElement(),"Unable to get random page")
        
        if let index = viewModel?.pages.firstIndex(where: { $0.id == page.id }) {
            let selected = page.selected
            viewModel?.togglePageSelection(page: page)
            XCTAssertTrue(selected != viewModel?.pages[index].selected)
            XCTAssertTrue(selected != pagesMock[index].selected)
        }
    }

    func testRemoveSelectedPage() throws {
        createArrayOfPages()
        let page = try XCTUnwrap(viewModel?.pages.randomElement())
        
        let selectedId = page.id
        viewModel?.removePages(with: selectedId)

        XCTAssertTrue((viewModel?.pages.contains(page)) == false)
    }

    // MARK: - Task Testing

    func testAddTask() throws {
        createArrayOfPages()
        let idTaskPage = try XCTUnwrap(viewModel?.pages.randomElement()?.id)
        
        let taskTitle = "Test Task title"
        viewModel?.addTask(title: taskTitle, idTaskPage: idTaskPage)

        XCTAssertTrue(taskTitle == viewModel?.tasks.first?.title)
        XCTAssertTrue(viewModel?.tasks.count == 1)
    }

    func testAddEmpyTask() throws {
        createArrayOfPages()
        let idTaskPage = try XCTUnwrap(viewModel?.pages.randomElement()?.id)
        
        let taskTitle = ""
        viewModel?.addTask(title: taskTitle, idTaskPage: idTaskPage)

        XCTAssertFalse(taskTitle == viewModel?.tasks.first?.title)
        XCTAssertTrue(viewModel?.tasks.count == 0)
    }

    func testAddThreeTasks() throws {
        createArrayOfPages()
        let idTaskPage = try XCTUnwrap(viewModel?.pages.randomElement()?.id)
        
        let taskTitle1 = "Test Task title1"
        let taskTitle2 = "Test Task title2"
        let taskTitle3 = "Test Task title3"
        viewModel?.addTask(title: taskTitle1, idTaskPage: idTaskPage)
        viewModel?.addTask(title: taskTitle2, idTaskPage: idTaskPage)
        viewModel?.addTask(title: taskTitle3, idTaskPage: idTaskPage)

        XCTAssertTrue(taskTitle1 == viewModel?.tasks.first?.title)
        XCTAssertTrue(taskTitle2 == viewModel?.tasks[1].title)
        XCTAssertTrue(taskTitle3 == viewModel?.tasks[2].title)
        XCTAssertTrue(viewModel?.tasks.count == 3)
    }
    
    func testUpdateTaskTitle() throws {
        createArrayOfPages()
        let idTaskPage = try XCTUnwrap(viewModel?.pages.randomElement()?.id)
        
        let title = "New Task"
        var newTask = TasksLocal(title: title, date: .now, status: .pending, note: "", lastUpdate: .now)
        viewModel?.addTask(title: newTask.title, idTaskPage: idTaskPage)
        XCTAssertTrue(newTask.title == viewModel?.tasks.first?.title)
        
        newTask.title = "Change Task Title"
        viewModel?.updateTitleAndNote(with: newTask)
        XCTAssertTrue(newTask.title != title)
        XCTAssertTrue(newTask.note == "")
 
    }
    
    func testUpdateTaskNote() throws {
        createArrayOfPages()
        let idTaskPage = try XCTUnwrap(viewModel?.pages.randomElement()?.id)
        
        let title = "New Task"
        var newTask = TasksLocal(title: title, date: .now, status: .pending, note: "", lastUpdate: .now)
        viewModel?.addTask(title: newTask.title, idTaskPage: idTaskPage)
        XCTAssertTrue(newTask.title == viewModel?.tasks.first?.title)
        
        newTask.note = "New Note"
        viewModel?.updateTitleAndNote(with: newTask)
        XCTAssertTrue(newTask.note != "")
        XCTAssertTrue(newTask.title == title)
 
    }
    
    func testUpdateTaskWithoutChangeTitle() throws {
        createArrayOfPages()
        let idTaskPage = try XCTUnwrap(viewModel?.pages.randomElement()?.id)
        
        let title = "New Task"
        let newTask = TasksLocal(title: title, date: .now, status: .pending, note: "", lastUpdate: .now)
        viewModel?.addTask(title: newTask.title, idTaskPage: idTaskPage)
        XCTAssertTrue(newTask.title == viewModel?.tasks.first?.title)
        
        viewModel?.updateTitleAndNote(with: newTask)
        XCTAssertTrue(newTask.note == "")
        XCTAssertTrue(newTask.title == title)
    }
    
    func testUpdateTaskWithoutChangeNote() throws {
        createArrayOfPages()
        let idTaskPage = try XCTUnwrap(viewModel?.pages.randomElement()?.id)
        
        let title = "New Task"
        let newTask = TasksLocal(title: title, date: .now, status: .pending, note: "", lastUpdate: .now)
        viewModel?.addTask(title: newTask.title, idTaskPage: idTaskPage)
        XCTAssertTrue(newTask.title == viewModel?.tasks.first?.title)
        
        viewModel?.updateTitleAndNote(with: newTask)
        XCTAssertTrue(newTask.note == "")
        XCTAssertTrue(newTask.title == title)
    }

    func testToggleCompletionTask() throws {
        try createArrayOfTask()
        let task = try XCTUnwrap(viewModel?.tasks.randomElement())
        
        let selected = task.status
        viewModel?.toggleTaskStatus(task: task)
        let taskChange = try XCTUnwrap(viewModel?.tasks.first(where: { $0.id == task.id }))
        
        XCTAssertTrue(selected != taskChange.status)
    }

    func testRemoveTask() throws {
        try createArrayOfTask()
        let task = try XCTUnwrap(viewModel?.tasks.randomElement())

        let index = try XCTUnwrap(viewModel?.tasks.firstIndex(of: task))

        viewModel?.removeTask(at: IndexSet(integer: index))

        XCTAssertEqual(viewModel?.tasks.count, 2)
        XCTAssertTrue((viewModel?.tasks.contains(task)) == false)
    }
    
    
    func testCheckActiveTask_NotCompletedShouldBe3() throws {
        try createArrayOfTask()
        let page = try XCTUnwrap(viewModel?.tasks.first?.taskPageItemID)
        let completed = false
        let completedTask = viewModel?.checkActivetask(is: completed, id: page)
        
        XCTAssertEqual(completedTask, 3)
    }
    func testToggleTaskPendingToInProcess_ShouldBe3() throws {
        try createArrayOfTask()
        let newStatus = TodoStatus.inProcess
        
        viewModel?.tasks.forEach {
            viewModel?.toggleTaskStatus(task: $0)
        }
        
        let totalTasks = viewModel?.tasks.filter { $0.status == newStatus }.count
        
        XCTAssertEqual(totalTasks, 3)
    }
    
    func testToggleTaskPendingToInProcessToCompletedToPending_ShouldBe3() throws {
        //Status Pending
        try createArrayOfTask()
        
        viewModel?.tasks.forEach {
            viewModel?.toggleTaskStatus(task: $0)
        }
        let inProcess = TodoStatus.inProcess
        let inProcessTasks = viewModel?.tasks.filter { $0.status == inProcess }.count
        XCTAssertEqual(inProcessTasks, 3)
        
        viewModel?.tasks.forEach {
            viewModel?.toggleTaskStatus(task: $0)
        }
        let completed = TodoStatus.completed
        let completedTasks = viewModel?.tasks.filter { $0.status == completed }.count
        XCTAssertEqual(completedTasks,3)
        
        viewModel?.tasks.forEach {
            viewModel?.toggleTaskStatus(task: $0)
        }
        let pending = TodoStatus.pending
        let pendingTasks = viewModel?.tasks.filter { $0.status == pending }.count
        XCTAssertEqual(pendingTasks, 3)
    }
    
    
    func testCheckStatusPendingTasks_ShouldBe3() throws {
        try createArrayOfTask()
        let pageId = try XCTUnwrap(viewModel?.tasks.first?.taskPageItemID)
        let status = TodoStatus.pending
        let totalTasks = viewModel?.checkStatusTasks(status, id: pageId)
        
        XCTAssertEqual(totalTasks, 3)
    }

    // MARK: - Tags Testing

    func testAddTag() throws {
        try createArrayOfTask()
        let task = try XCTUnwrap(viewModel?.tasks.randomElement())
        
        let tag = makeInitTag(with: "Prueba Tag")
        viewModel?.addTag(title: tag.title, idTaskItem: task.id, idTag: tag.id)

        XCTAssertTrue(tag.title == viewModel?.tags.first?.title)
        XCTAssertTrue(viewModel?.tags.count == 1)
    }

    func testAddTagWithEmptyTitle() throws {
        try createArrayOfTask()
        let task = try XCTUnwrap(viewModel?.tasks.randomElement())
        
        let tag = makeInitTag(with: "")
        viewModel?.addTag(title: tag.title, idTaskItem: task.id, idTag: tag.id)

        XCTAssertFalse(tag.title == viewModel?.tags.first?.title)
        XCTAssertTrue(viewModel?.tags.count == 0)
    }
    
    func testUpdateTag() throws {
        try createArrayOfTask()
        let task = try XCTUnwrap(viewModel?.tasks.randomElement())
        
        let tagName = "Tag1"
        var tag = makeInitTag(with: tagName)
        viewModel?.addTag(title: tag.title, idTaskItem: task.id, idTag: tag.id)
        tag.title = "New Tag2"
        
        viewModel?.updateTag(tag: tag)

        XCTAssertFalse(tagName != viewModel?.tags.first?.title)
        XCTAssertTrue(viewModel?.tags.count != 0)
    }

    func testRemoveOneTag() throws {
        let tags = createArrayOfTags()
        let tag = try XCTUnwrap(tags.randomElement())
        
        let countTags = tags.count
        viewModel?.removeOneTag(id: tag.id)

        XCTAssertTrue(viewModel?.tags.contains(tag) == false)
        XCTAssertTrue(viewModel?.tasks.count != countTags)
    }

    func testRemoveAllTags() {
        let tags = createArrayOfTags()
        let countTags = tags.count
        viewModel?.removeAllTag(tag: tags)

        XCTAssertTrue(viewModel?.tags.count != countTags)
        XCTAssertEqual(viewModel?.tags, [])
    }

    // MARK: - Complements

    func testFetchAllPages() {
        let _ = createArrayOfTags()
        createArrayOfPages()

        viewModel?.fetchData()

        XCTAssertTrue((viewModel?.tags.isEmpty) != nil)
        XCTAssertTrue((viewModel?.tasks.isEmpty) != nil)
        XCTAssertTrue((viewModel?.pages.isEmpty) != nil)
    }

    // MARK: - Helpers Tests

    private func makeInitTag(with title: String) -> TagLocal {
        return TagLocal(title: title)
    }

    private func makeInitTaskItem(with title: String) -> TaskItem {
        return TaskItem(title: title, date: Date(), status: .pending, note: "", lastUpdate: Date())
    }

    private func makeInitTaskPageInit(with title: String) -> TaskPageItem {
        return TaskPageItem(title: title)
    }

    private func createArrayOfTags() -> [TagLocal] {
        var arrayOfTags: [TagLocal] = []
        arrayOfTags.append(makeInitTag(with: "Tag1"))
        arrayOfTags.append(makeInitTag(with: "Tag2"))
        arrayOfTags.append(makeInitTag(with: "Tag3"))
        return arrayOfTags
    }

    private func createArrayOfPages() {
        viewModel?.addTaskPage(title: "Titulo página 1")
        viewModel?.addTaskPage(title: "Titulo página 2")
        viewModel?.addTaskPage(title: "Titulo página 3")
    }

    private func createArrayOfTask() throws {
        createArrayOfPages()
        let page = try XCTUnwrap(viewModel?.pages.randomElement())
        
        viewModel?.addTask(title: "Titulo task1", idTaskPage: page.id)
        viewModel?.addTask(title: "Titulo task2", idTaskPage: page.id)
        viewModel?.addTask(title: "Titulo task3", idTaskPage: page.id)
    }
}
