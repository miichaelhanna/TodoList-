# App Architecture (Human Guide)

Last updated: 2026-02-13

## 1) What this app is
This is a single-screen iOS todo application built in SwiftUI with local persistence using SwiftData.
The app focuses on fast task capture and lightweight scheduling through per-task due date and time.

## 2) High-level structure
The app is intentionally small and organized around four key files:

- `NotionStyleTodoAppApp.swift`: app entry point and SwiftData container wiring.
- `ContentView.swift`: main screen, task list UI, input field, and user interactions.
- `TaskItem.swift`: SwiftData model for stored tasks.
- `Theme.swift`: shared color tokens and hex color helper.

## 3) Data model
`TaskItem` is the persisted entity. It stores:

- `id` (UUID)
- `text` (task title)
- `isCompleted` (done/undone state)
- `dueDate` (optional date + time)
- `createdAt` and `updatedAt` timestamps

### Why `dueDate` is optional
Scheduling is useful but not mandatory, so each task can exist with or without a due date.

## 4) UI flow
The main screen has three sections:

1. Header (`Your Tasks`)
2. Inline create row (`Type a task...` + plus button)
3. Task list (or `No tasks` empty state)

Each task row supports:

- Toggle complete/incomplete
- Tap-to-edit task text inline
- Swipe to delete
- Assign/edit/clear due date and time using a date-time picker sheet

## 5) Interaction details
### Create task
- User types in the inline input.
- Task is added via Return key or plus button.
- Empty input is ignored.

### Edit task text
- Tap task text to enter edit mode.
- Save on Return or focus loss.
- Blank edits revert to previous value.

### Assign due date and time
- Tap calendar icon in the row.
- A sheet opens with a date/time picker.
- User can Save, Cancel, or Clear Due Date.

### Completion state
- Completed tasks are struck through and dimmed.

## 6) Sorting and presentation
Tasks are shown with this order:

1. Incomplete tasks first
2. Within each group: earliest `createdAt` first

This keeps active work visible at the top while preserving stable ordering.

## 7) Persistence strategy
SwiftData persists all tasks locally on device.
No account, cloud sync, or backend is used in v1.

## 8) Constraints and known gaps
- No automated test suite yet.
- Asset catalog build-phase wiring is minimal.
- Bundle identifier/signing still use placeholder defaults.

## 9) How to extend safely
If adding features, keep these patterns:

- Update `TaskItem` model with backward-safe defaults.
- Keep mutation logic centralized in `ContentView` methods.
- Reflect every change in docs:
  - `docs/STATUS.md`
  - `docs/CHANGELOG.md`
  - `docs/ai-context.json`
  - this file when architecture changes.
