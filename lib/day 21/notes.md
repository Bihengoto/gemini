# Day 21-22: Learning Notes & Self-Reflection

## Key Concepts Applied

### 1. Object-Oriented Programming
- **Classes**: Created `Task` class to represent individual to-do items
- **Encapsulation**: Used private fields with getter/setter methods
- **Constructor**: Implemented both default and named constructors
- **Methods**: Added behavior methods like `markComplete()`, `toggle()`

### 2. Data Structures
- **Lists**: Used `List<Task>` to store and manage tasks
- **Iteration**: Applied various loop types (for, for-in, while)
- **Filtering**: Used `where()` method for task filtering

### 3. Functions & Methods
- **Pure Functions**: Created utility functions without side effects
- **Method Chaining**: Enabled fluent interface patterns
- **Parameter Validation**: Added input validation and error handling

### 4. User Interaction
- **Console Input**: Used `stdin.readLineSync()` for user input
- **Menu Systems**: Implemented interactive menu navigation
- **Input Validation**: Added robust error handling for user input

## Design Patterns Identified

### 1. Model-View-Controller (MVC)
- **Model**: `Task` class represents data structure
- **View**: `ConsoleUI` handles all user interface concerns
- **Controller**: `TodoManager` contains business logic

### 2. Single Responsibility Principle
- Each class has one clear, focused responsibility
- `Task`: Represents a single to-do item
- `TodoManager`: Manages collection of tasks
- `ConsoleUI`: Handles user interface only

### 3. Separation of Concerns
- Data representation separated from business logic
- UI logic separated from data management
- Easy to modify one aspect without affecting others

## Code Structure Decisions

### Why This Structure?
1. **Maintainability**: Easy to find and modify specific functionality
2. **Testability**: Each component can be tested independently
3. **Scalability**: Easy to add new features without major refactoring
4. **Readability**: Clear organization makes code self-documenting

### Alternative Approaches Considered
1. **Single File**: Would be simpler but harder to maintain
2. **Functional Approach**: Could work but OOP better demonstrates class concepts
3. **Database Storage**: Too complex for this learning exercise

## Challenges Encountered

### 1. Input Validation
- **Problem**: Users might enter invalid menu choices or empty strings
- **Solution**: Added comprehensive validation with retry loops

### 2. State Management
- **Problem**: Keeping track of task completion status
- **Solution**: Used boolean flag in Task class with toggle methods

### 3. User Experience
- **Problem**: Making console interface intuitive
- **Solution**: Clear menus, confirmation messages, and error feedback

## What I Learned

### Technical Skills
- How to structure a multi-class Dart project
- Proper use of constructors and methods
- List manipulation and filtering techniques
- Console I/O handling and validation

### Design Skills
- Importance of separating concerns
- How to identify and apply design patterns
- Benefits of planning before coding
- Value of consistent naming conventions

## Future Enhancements

### Immediate Improvements
- Add task priorities (high, medium, low)
- Implement due dates for tasks
- Add task categories or tags
- Save/load tasks to/from file

### Advanced Features
- Search and filter functionality
- Task statistics and reporting
- Multiple to-do lists
- Undo/redo functionality

## Self-Assessment

### What Went Well
- Clean separation of responsibilities
- Intuitive user interface
- Robust error handling
- Good code organization

### Areas for Improvement
- Could add more comprehensive testing
- File persistence would make it more practical
- Better input parsing (commands vs menu numbers)
- More sophisticated task management features

## Key Takeaways
1. **Planning First**: Sketching out classes and methods before coding saved time
2. **Iterative Development**: Building features one at a time made debugging easier
3. **User Perspective**: Thinking about user experience improved the interface design
4. **Code Organization**: Proper file structure makes projects much more manageable