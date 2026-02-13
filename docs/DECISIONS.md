# Decisions

## D-001: Persistence with SwiftData
- Date: 2026-02-13
- Decision: Use SwiftData as local persistence.
- Reason: Matches modern SwiftUI stack and iOS 17+ target.

## D-002: iOS interaction replacement for hover delete
- Date: 2026-02-13
- Decision: Use swipe-to-delete in task rows.
- Reason: Native iOS gesture pattern and best UX for touch.

## D-003: iPhone-only v1 target
- Date: 2026-02-13
- Decision: Target iPhone (device family 1), iOS 17+.
- Reason: Minimize scope and keep implementation focused.

## D-004: Sorting strategy
- Date: 2026-02-13
- Decision: Render incomplete tasks first, then by creation date.
- Reason: Improves task visibility and keeps stable ordering.

## D-005: Empty edit behavior
- Date: 2026-02-13
- Decision: Revert to previous text when edit becomes blank.
- Reason: Prevent accidental destructive edits without confirmation.
