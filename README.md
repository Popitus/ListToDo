# To-Do List in SwiftUI with SwiftData

This project is an MVP (Minimum Viable Product) of an enhanced to-do list application, using an architecture that incorporates some concepts from Clean Architecture and SOLID.

## Description

This to-do list application has been enhanced to adhere to solid software design principles, including the use of a repository, use cases, and implementing repositories through protocols. It also makes use of mappers to convert between internal data models and user interface entities.

## Features

- **Add Tasks:** Users can add new tasks through an input form.
- **Check and Uncheck Tasks:** Tasks can be checked or unchecked as completed.
- **Delete Tasks:** Tasks can be easily deleted from the list.
- **Enhanced Task Details:** A detailed view is provided for each task, including description, due date, priority, etc.

## Architecture and Technologies Used

- **Repository and Use Cases:** A repository is implemented to abstract data access and use cases for business logic.
- **Protocols and Mappers:** Repositories are implemented through protocols, allowing for easy substitution and testing. Mappers are used to convert between internal data models and user interface entities.
- **SwiftData:** Data persistence is performed using SwiftData.

## Project Structure

The project follows a clear and organized structure, with separation of responsibilities among presentation, domain, and data layers.

## Execution

1. Clone this repository.
2. Open the project in Xcode.
3. Run the application on the iOS simulator or on a physical device.

## Contributions

Contributions are welcome. If you find any issues or have an improvement, feel free to open an issue or submit a pull request.

## Additional Notes

This project has been created with the aim of demonstrating an enhanced implementation of an MVP using SwiftUI and best software development practices. It does not have commercial value as such, it is only for practice and illustrative purposes.

## Author

Oliver R.C.

Also, please note that there is localization available for both English and Spanish languages.
