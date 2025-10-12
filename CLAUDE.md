# CLAUDE.md - Adaptive Engineering Standards v3.1 (Optimized)

## 0. Project Context [Auto-Updated]

**Project:** AutoBID - Online Reused Car Auction
**Type:** Multi-Platform App
**Platforms:** iOS, Android, Web
**Phase:** Beta (v0.10.0) ← Auto-detected
**Version:** 0.10.0+18
**Updated:** 2025-10-13

**Tech Stack:**
- Primary: Flutter 3.9.2 (Dart ^3.9.2)
- State: Riverpod 3.0.1 + Provider 6.1.1 (→Riverpod)
- Backend: Mock Services (Firebase 4.1.1 planned)
- DB: In-memory (Firestore 6.0.2 planned)
- Test: flutter_test, Manual
- CI/CD: Manual

**Build Targets:** Debug, Release

---

## 1. Current Phase Standards: Beta (v0.5.x-v0.9.x)

**Quality:** ≥70% cov, lint ✓, 0 warn
**Performance:** <50ms interact, <2s API, 60 FPS
**Security:** OWASP Top 10, encrypted storage
**Testing:** Unit + integration, beta feedback
**Docs:** User guides + API docs

**Platform (Multi-Platform):**
- UI: Shared design system, platform adaptations
- Performance: Meet strictest requirement
- Assets: Platform-specific bundles
- Testing: All platform test suites
- Distribution: Coordinated releases

---

## 2. Core Instructions

**Phase Detection:** `v0.0→Proto | 0.1-4→Alpha | 0.5-9→Beta | 1.0→MVP | 1-2→Growth | 3+→Maturity`

**Workflow:**
1. Check PROJECT_STRUCTURE.md first
2. Apply current phase standards (Section 1)
3. Complete user's tasks
4. **[AUTO] Post-Task Checklist:**
   - [ ] Update CLAUDE.md Section 0 if version/phase changed
   - [ ] Update PROJECT_STRUCTURE.md if structure/features changed
   - [ ] Generate semantic commits (ONE FILE = ONE COMMIT, single line only)
   - [ ] Bump pubspec.yaml version (highest impact commit type)
   - [ ] Ask user: "Ready to commit? (Y/n)"

**CRITICAL:** Always run Post-Task Checklist before final response.

**Commit Rules:**
- One file = one commit (atomic)
- Single line message only (no body, no Co-Authored-By, no metadata)
- Format: `[type]: [description <50 chars]`

**Version Bumps:**
- `feat` → Minor (+0.1.0)
- `fix|update|perf|build` → Patch (+0.0.1)
- `feat!|BREAKING CHANGE` → Major (+1.0.0)
- `docs|style|refactor|test|chore|ci` → No change

**Output:** Minimal unless asked (Section 7 in CLAUDE_WORKFLOW.md)

---

## 3. Auto-Read Triggers [CRITICAL]

**ALWAYS read referenced file BEFORE responding when triggered:**

| Trigger | Read File | Section |
|---------|-----------|---------|
| Version changes phase | CLAUDE_PHASES.md | New phase section |
| Need phase graduation criteria | CLAUDE_PHASES.md | Section 9 |
| Platform requirements unclear | CLAUDE_PHASES.md | Section 1.5 |
| Commit/PR work needed | CLAUDE_WORKFLOW.md | Sections 2-3 |
| Code pattern examples needed | CLAUDE_WORKFLOW.md | Section 6 |
| Performance checklist | CLAUDE_WORKFLOW.md | Section 8 |
| Release commands | CLAUDE_PHASES.md | Section 9 |
| User types `@context` | CLAUDE_WORKFLOW.md | Project Notes |
| User types `@verify|@profile|@deps|@export|@next|@commit` | CLAUDE_WORKFLOW.md | Section 5 |
| Need response template | CLAUDE_WORKFLOW.md | Section 2 |
| Error recovery needed | CLAUDE_WORKFLOW.md | Section 12 |

**MANDATORY:** If trigger matched → Read file → Process → Respond

---

## 4. Quick Reference

**Shortcuts:**
- `+feat` = New feature (minor)
- `+fix` = Bug fix (patch)
- `+break` = Breaking change (major)
- `!perf|!sec` = Critical priority

**Commands:**
- `@verify` - Run tests + lint
- `@context` - Show current state
- `@commit` - Generate commits
- `@export` - PR summary

**Current Focus:** Custom attribute system for listing enums and features
**Branch:** nekolaiv/carlisting-enhancement

---

## 5. Project-Specific Notes [Auto-Updated]

**Patterns:**
- Freezed models with abstract class
- Mock services (instant-2s delays)
- Multi-step flows: 8-step KYC, 6-step listing, 7-step auction
- Philippine data: locations, payments, IDs
- Material Design 3, green theme (#4CAF50)
- Grid/List view toggles, color-coded timers

**Preferences:**
- Concise responses, minimal explanations
- Atomic commits per file
- Auto-updates to CLAUDE.md + PROJECT_STRUCTURE.md
- Mock services for thesis demo
- Solo dev, beginner-friendly

**Architecture:**
- Hybrid: Riverpod + Provider (→full Riverpod)
- Clean Architecture (Presentation→Domain→Data)
- Freezed + JSON serialization
- Mock services with realistic PH data
- In-memory storage (Firebase planned)

---

## Extended Documentation

- **CLAUDE_PHASES.md** - All phase standards, platform specs, release checklists
- **CLAUDE_WORKFLOW.md** - Templates, commits, patterns, quick commands
- **PROJECT_STRUCTURE.md** - Folder tree, features, tech debt, dependencies

**Schema:** v3.1 (Optimized)
