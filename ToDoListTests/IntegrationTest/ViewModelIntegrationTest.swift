
import XCTest
@testable import ToDoList

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
            tagUseCase: tagUseCase)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    
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
     


}
