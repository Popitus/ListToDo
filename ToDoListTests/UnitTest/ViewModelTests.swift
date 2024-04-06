
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

    func testTogglePageSelection() {
        createArrayOfPages()
        guard let page = viewModel?.pages.randomElement() else {
            XCTFail("Unable to get random page")
            return
        }
        if let index = viewModel?.pages.firstIndex(where: { $0.id == page.id }) {
            let selected = page.selected
            viewModel?.togglePageSelection(page: page)
            XCTAssertTrue(selected != viewModel?.pages[index].selected)
            XCTAssertTrue(selected != pagesMock[index].selected)
        }
    }

    func testRemoveSelectedPage() {
        createArrayOfPages()
        guard let page = viewModel?.pages.randomElement() else {
            XCTFail("Unable to get random page")
            return
        }
        let selectedId = page.id
        viewModel?.removePages(with: selectedId)

        XCTAssertTrue((viewModel?.pages.contains(page)) == false)
    }

    // MARK: - Task Testing

    func testAddTask() {
        createArrayOfPages()
        guard let idTaskPage = viewModel?.pages.randomElement()?.id else {
            return XCTFail()
        }
        let taskTitle = "Test Task title"
        viewModel?.addTask(title: taskTitle, idTaskPage: idTaskPage)

        XCTAssertTrue(taskTitle == viewModel?.tasks.first?.title)
        XCTAssertTrue(viewModel?.tasks.count == 1)
    }

    func testAddEmpyTask() {
        createArrayOfPages()
        guard let idTaskPage = viewModel?.pages.randomElement()?.id else {
            return XCTFail()
        }
        let taskTitle = ""
        viewModel?.addTask(title: taskTitle, idTaskPage: idTaskPage)

        XCTAssertFalse(taskTitle == viewModel?.tasks.first?.title)
        XCTAssertTrue(viewModel?.tasks.count == 0)
    }

    func testAddThreeTasks() {
        createArrayOfPages()
        guard let idTaskPage = viewModel?.pages.randomElement()?.id else {
            return XCTFail()
        }
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

    func testToggleCompletionTask() {
        createArrayOfTask()
        guard let task = viewModel?.tasks.randomElement() else {
            return XCTFail()
        }
        let selected = task.status
        viewModel?.toggleTaskCompletion(task: task)
        guard let taskChange = viewModel?.tasks.first(where: { $0.id == task.id }) else {
            return XCTFail()
        }
        XCTAssertTrue(selected != taskChange.status)
    }

    func testRemoveTask() {
        createArrayOfTask()
        guard let task = viewModel?.tasks.randomElement() else {
            return XCTFail()
        }

        guard let index = viewModel?.tasks.firstIndex(of: task) else {
            return XCTFail()
        }

        viewModel?.removeTask(at: IndexSet(integer: index))

        XCTAssertEqual(viewModel?.tasks.count, 2)
        XCTAssertTrue((viewModel?.tasks.contains(task)) == false)
    }

    // MARK: - Tags Testing

    func testAddTag() {
        createArrayOfTask()
        guard let task = viewModel?.tasks.randomElement() else {
            return XCTFail()
        }
        let tag = makeInitTag(with: "Prueba Tag")
        viewModel?.addTag(title: tag.title, idTaskItem: task.id, idTag: tag.id)

        XCTAssertTrue(tag.title == viewModel?.tags.first?.title)
        XCTAssertTrue(viewModel?.tags.count == 1)
    }

    func testAddTagWithEmptyTitle() {
        createArrayOfTask()
        guard let task = viewModel?.tasks.randomElement() else {
            return XCTFail()
        }
        let tag = makeInitTag(with: "")
        viewModel?.addTag(title: tag.title, idTaskItem: task.id, idTag: tag.id)

        XCTAssertFalse(tag.title == viewModel?.tags.first?.title)
        XCTAssertTrue(viewModel?.tags.count == 0)
    }

    func testRemoveOneTag() {
        let tags = createArrayOfTags()
        guard let tag = tags.randomElement() else {
            return XCTFail()
        }
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

    private func createArrayOfTask() {
        createArrayOfPages()
        guard let page = viewModel?.pages.randomElement() else {
            return
        }
        viewModel?.addTask(title: "Titulo task1", idTaskPage: page.id)
        viewModel?.addTask(title: "Titulo task2", idTaskPage: page.id)
        viewModel?.addTask(title: "Titulo task3", idTaskPage: page.id)
    }
}
