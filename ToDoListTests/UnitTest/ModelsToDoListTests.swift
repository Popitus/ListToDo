
import XCTest
@testable import ToDoList

final class ModelsToDoListTests: XCTestCase {
    
    // MARK: - Test Models
    
    // Test Tag Model
    
    func test_initialization_model_tag() {
        
        // Arrange
        let title = "Text Tag Title"
        
        // Act
        let tag = makeInitTag(with: title)
        
        // Assert
        XCTAssertEqual(tag.title, title)
        XCTAssertTrue(tag.id.hashValue != 0)
        XCTAssertTrue(tag.isInitial == false)
        
    }
    
    // Test TaskItem Model
    
    func test_initialization_model_taskItem() {
        // Arrange
        let title = "Text TaskItem Title"
        
        // Act
        let taskItem = makeInitTaskItem(with: title)
        
        // Assert
        XCTAssertEqual(taskItem.title, title)
        XCTAssertNotEqual(taskItem.date, Date())
        XCTAssertEqual(taskItem.status, .pending)
        XCTAssertEqual(taskItem.note, "")
        XCTAssertEqual(taskItem.lastUpdate,taskItem.date)
        
    }
    
    // Test TaskPageItem Model
    
    func test_initialization_model_taskPageItem() {
        // Arrange
        let title = "Text Tag Title"
        
        // Act
        let page = makeInitTaskPageInit(with: title)
        
        // Assert
        XCTAssertEqual(page.title, title)
        XCTAssertTrue(page.id.hashValue != 0)
        XCTAssertTrue(page.selected == false)
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
