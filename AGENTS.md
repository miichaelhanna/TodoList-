# Agent Operating Contract

Purpose: make project status deterministic for AI assistants and future updates.

## Source-of-Truth Order (mandatory)
When asked for project updates, read these files in this order:
1. `docs/STATUS.md`
2. `docs/CHANGELOG.md`
3. `docs/ARCHITECTURE.md`
4. `docs/DECISIONS.md`
5. `docs/ai-context.json`

## Update Rules
- Do not infer status from memory when files disagree.
- `docs/STATUS.md` is authoritative for "what is done now".
- `docs/CHANGELOG.md` is authoritative for "what changed and when".
- `docs/DECISIONS.md` is authoritative for accepted tradeoffs.
- If code changes, update at least:
  - `docs/STATUS.md`
  - `docs/CHANGELOG.md`
  - `docs/ai-context.json`

## Response Rules for Future Update Requests
- Quote exact file paths used for the answer.
- Report date stamp from `docs/STATUS.md` and `docs/ai-context.json`.
- If missing data, state what file should have been updated.
