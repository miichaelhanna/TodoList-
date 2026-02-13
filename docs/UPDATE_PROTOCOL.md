# Update Protocol

Use this protocol whenever code is changed.

## Required Files to Update
1. `docs/STATUS.md`
2. `docs/CHANGELOG.md`
3. `docs/ai-context.json`

## Optional (update when impacted)
- `docs/ARCHITECTURE.md` when structure/data flow changes
- `docs/DECISIONS.md` when a new decision is made
- `docs/AI_INDEX.md` when source-of-truth paths change

## Standard Update Steps
1. Implement code changes.
2. Run relevant verification (build/tests).
3. Append entry in `docs/CHANGELOG.md` with date.
4. Refresh `docs/STATUS.md` sections:
   - Completed
   - Known Gaps
   - Last updated
5. Refresh `docs/ai-context.json` fields:
   - `last_updated`
   - `build_status`
   - `feature_status`

## How AI Should Answer "Give me an update"
- First read: `docs/STATUS.md`
- Cross-check with: `docs/CHANGELOG.md`
- Validate structure from: `docs/ARCHITECTURE.md`
- Include explicit file paths in response.
