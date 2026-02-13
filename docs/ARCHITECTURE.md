# Architecture

## App Layout
- Entry point: `NotionStyleTodoAppApp.swift`
- Main screen: `ContentView.swift`
- Persistence model: `TaskItem.swift`
- Theme system: `Theme.swift`

## Data Layer
- SwiftData model `TaskItem` stores all task records locally.
- Container created with `.modelContainer(for: TaskItem.self)` at app scene level.
- `TaskItem` fields:
  - `id`
  - `text`
  - `isCompleted`
  - `dueDate` (optional)
  - `createdAt`
  - `updatedAt`

## UI Layer
- `ContentView` contains:
  - Header (`Your Tasks`)
  - Input row (TextField + plus button)
  - List of tasks
  - Empty state text
- `TaskRow` handles:
  - Complete/incomplete toggle button
  - Inline text editing
  - Editing focus state
  - Due date/time assignment via sheet and date-time picker

## State and Mutations
Mutations are view-scoped methods in `ContentView`:
- `addTaskFromDraft()`
- `toggleComplete(_:)`
- `editTask(task:newText:)`
- `deleteTask(_:)`
- `assignDueDate(task:dueDate:)`

## Ordering
Tasks are presented with computed sorting:
1. Incomplete tasks first
2. Then by `createdAt` ascending

## Interaction Mapping from Web Spec to iOS
- "LocalStorage" -> SwiftData
- "Delete on hover" -> Swipe-to-delete
- "Hover highlight" -> editing/interaction background highlight
