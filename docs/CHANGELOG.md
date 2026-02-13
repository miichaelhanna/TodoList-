# Changelog

## 2026-02-13
- Created iOS SwiftUI app project at `NotionStyleTodoApp/`.
- Added SwiftData model `TaskItem`.
- Implemented task creation, editing, completion toggle, and swipe deletion.
- Added empty state handling.
- Added theme tokens and hex color helper.
- Validated project builds via `xcodebuild` for `iphoneos` target.
- Added documentation framework for AI-readable updates:
  - `README.md`
  - `AGENTS.md`
  - `docs/AI_INDEX.md`
  - `docs/STATUS.md`
  - `docs/ARCHITECTURE.md`
  - `docs/DECISIONS.md`
  - `docs/UPDATE_PROTOCOL.md`
  - `docs/ai-context.json`
- Updated UI header title to `Your Tasks`.
- Removed live clock from header.
- Added task-level due date and time feature:
  - Model support with optional `dueDate`
  - Row-level assign/edit/clear schedule controls
  - Date-time picker sheet UI
- Added human-focused architecture documentation:
  - `docs/ARCHITECTURE_HUMAN.md`
- Refreshed AI and project index docs to include latest state.
