
import XCTest
@testable import ToDoList

final class ViewModelTests: XCTestCase {
    
    var viewModel: TaskViewModel?

    override func setUpWithError() throws {
        viewModel = TaskViewModel(tagUseCase: TagUseCaseMock())
    }

    override func tearDownWithError() throws {
        tagMock = []
    }
    
    // MARK: - Tasks testing
    func testAddTagWithUIDDofTask() {
        // Arrange
        let tag = makeInitTag(with: "Test tag1")
        let task = makeInitTaskItem(with: "Test Task1 for tag1")
        
        // Act
        viewModel?.addTag(addTag: tag, idTaskItem: task.id)
        
        // Assert
        XCTAssertEqual(viewModel?.tags.count, 1)
        XCTAssertEqual(viewModel?.tags.first?.title, tag.title)
        XCTAssertEqual(viewModel?.tags.first?.isInitial, false)
    }
    
    
    // MARK: - Helpers Tests
    
    private func makeInitTag(with title: String) -> Tag {
        return Tag(title: title)
    }
    
    private func makeInitTaskItem(with title: String) -> TaskItem {
        return TaskItem(title: title, date: Date(), status: .pending, note: "", lastUpdate: Date())
    }
    
    private func makeInitTaskPageInit(with title: String) -> TaskPageItem {
        return TaskPageItem(title: title)
    }

    

}
