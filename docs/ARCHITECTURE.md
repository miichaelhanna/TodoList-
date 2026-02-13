# Architecture

## App Layout
- Entry point: `NotionStyleTodoAppApp.swift`
- Main screen: `ContentView.swift`
- Persistence model: `TaskItem.swift`
- Theme system: `Theme.swift`

## Data Layer
- SwiftData model `TaskItem` stores all task records locally.
- Container created with `.modelContainer(for: TaskItem.self)` at app scene level.

## UI Layer
- `ContentView` contains:
  - Input row (TextField + plus button)
  - List of tasks
  - Empty state text
- `TaskRow` handles:
  - Complete/incomplete toggle button
  - Inline text editing
  - Editing focus state

## State and Mutations
Mutations are view-scoped methods in `ContentView`:
- `addTaskFromDraft()`
- `toggleComplete(_:)`
- `editTask(task:newText:)`
- `deleteTask(_:)`

## Ordering
Tasks are presented with computed sorting:
1. Incomplete tasks first
2. Then by `createdAt` ascending

## Interaction Mapping from Web Spec to iOS
- "LocalStorage" -> SwiftData
- "Delete on hover" -> Swipe-to-delete
- "Hover highlight" -> editing/interaction background highlight
