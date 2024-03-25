
import XCTest
@testable import ToDoList

final class ModelsToDoListTests: XCTestCase {
    
    // MARK: - Test Models
    
    // Test Tag Model
    
    func testInitializationModelTag() {
        
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
    
    func testInitializationModelTaskItem() {
        // Arrange
        let title = "Text TaskItem Title"
        
        // Act
        let taskItem = makeInitTaskItem(with: title)
        
        // Assert
        XCTAssertEqual(taskItem.title, title)
        XCTAssertNotEqual(taskItem.date, Date())
        XCTAssertEqual(taskItem.status, .pending)
        XCTAssertEqual(taskItem.note, "")
        XCTAssertNotEqual(taskItem.lastUpdate,taskItem.date)
        
    }
    
    // Test TaskPageItem Model
    
    func testInitializationModelTaskPageItem() {
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
    
    private func makeInitTag(with title: String) -> TagItem {
        return TagItem(title: title)
    }
    
    private func makeInitTaskItem(with title: String) -> TaskItem {
        return TaskItem(title: title, date: Date(), status: .pending, note: "", lastUpdate: .now)
    }
    
    private func makeInitTaskPageInit(with title: String) -> TaskPageItem {
        return TaskPageItem(title: title)
    }

}
