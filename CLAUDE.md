# CLAUDE.md - Adaptive Engineering Standards v3.3 (Automated Code Generation)

## 0. Project Context [Auto-Updated]

**Project:** AutoBID - Online Reused Car Auction
**Type:** Multi-Platform App
**Platforms:** iOS, Android, Web
**Phase:** Beta (v0.12.0) ← Auto-detected
**Version:** 0.12.0+21
**Updated:** 2025-10-15

**Tech Stack:**
- Primary: Flutter 3.9.2 (Dart ^3.9.2)
- State: Riverpod 3.0.1 + Provider 6.1.1 (→Riverpod)
- Backend: Mock Services (Firebase 4.1.1 planned)
- DB: In-memory (Firestore 6.0.2 planned)
- Test: flutter_test, Manual
- CI/CD: Manual

**Build Targets:** Debug, Release
**Current Focus:** OTP-based authentication + Signup flow enhancements
**Branch:** nekolaiv/enhance-auth

**Quick Commands:**
- `@generate-freeze` - Run build_runner (Workflow #4)
- `@analyze` - Run flutter analyze (Workflow #5)
- `@sync-docs` - Update project docs (Workflow #6)

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

**Workflow (CRITICAL - TO FOLLOW EVERY USER REQUEST):**
1. Check PROJECT_STRUCTURE.md first
2. Apply current phase standards (Section 1)
3. Complete user's tasks
4. **[AUTO] If Code Generation Required:**
   - [ ] Run `dart run build_runner build --delete-conflicting-outputs`
   - [ ] Verify generated files updated (`.freezed.dart`, `.g.dart`)
   - [ ] Check for compilation errors
   - **Triggers:**
     - ANY file with `@freezed` annotation modified
     - ANY file with `@riverpod` or `@Riverpod()` annotation modified
     - ANY Riverpod provider with changed parameters (keepAlive, dependencies, etc.)
     - ANY JSON serializable model with `@JsonSerializable()` modified
5. **[AUTO - CRITICAL] Error Resolution:**
   - [ ] Run `flutter analyze` to detect errors
   - [ ] Fix ALL RED errors (blocking)
   - [ ] Verify 0 RED errors remain
   - [ ] NEVER mark task complete with RED errors present
6. **[AUTO] Post-Task Checklist:**
   - [ ] Update CLAUDE.md Section 0 if version/phase changed
   - [ ] Update PROJECT_STRUCTURE.md if structure/features changed
   - [ ] Suggest version bump ONLY if changed this prompt
   - [ ] List commits ONLY for files modified this prompt

**CRITICAL:**
- Always run Post-Task Checklist before final response
- Assume all previous prompt files were committed
- Only show current prompt changes

**Version Bumps (User applies manually):**
- `feat` → Minor (+0.1.0)
- `fix|update|perf|build` → Patch (+0.0.1)
- `feat!|BREAKING CHANGE` → Major (+1.0.0)
- `docs|style|refactor|test|chore|ci` → No change

**Commit Format (User runs git):**
- One file = one commit (atomic)
- Claude provides: `filename | commit message`
- User handles git commands
- User creates tags manually for minor versions

**Error Resolution [AUTO - CRITICAL]:**
- **ALWAYS resolve ALL RED errors** before completing ANY task
- **RED = Blocking errors** (compilation failures, undefined references)
- **YELLOW = Warnings** (resolve if time permits, not blocking)
- **BLUE = Info** (ignore unless specifically requested)
- **Command:** `flutter analyze` to detect errors
- **Must achieve:** 0 RED errors, minimize YELLOW warnings
- **Never stop** until all RED errors are resolved

**Code Generation [AUTO - CRITICAL]:**
- **ALWAYS auto-run** after modifying files with code generation annotations
- **Command:** `dart run build_runner build --delete-conflicting-outputs`
- **Triggers (any of these require build_runner):**
  - `@freezed` - Freezed immutable models
  - `@riverpod` or `@Riverpod()` - Riverpod providers
  - `@JsonSerializable()` - JSON serialization
  - `part 'filename.g.dart'` directive added/modified
- **Verify:** Check generated files (`.freezed.dart`, `.g.dart`) exist and have no errors
- **On failure:** Use fallback script (regenerate_freezed.bat) or manual fix
- **Skip if:** Only modifying non-annotated files or generated files themselves
- **CRITICAL:** Provider parameter changes (like `keepAlive: true`) REQUIRE regeneration

**Hybrid Commands [USER FALLBACK]:**

If Claude fails to auto-execute workflows, use these commands:

- **`@generate-freeze`** → Manually trigger Workflow #4 (Code Generation)
  - Runs: `dart run build_runner build --delete-conflicting-outputs`
  - Use when: Freezed/Riverpod/JSON models modified but not regenerated

- **`@analyze`** → Manually trigger Workflow #5 (Error Resolution)
  - Runs: `flutter analyze`
  - Use when: Need to check for RED errors before completing task

- **`@sync-docs`** → Manually trigger Workflow #6 (Post-Task Checklist)
  - Updates: CLAUDE.md Section 0, PROJECT_STRUCTURE.md
  - Use when: Version/phase/structure changed but docs not updated

**Output:** Minimal unless asked (Section 7 in CLAUDE_WORKFLOW.md)

---

## 5. Project-Specific Notes [Auto-Updated]

**Patterns:**
- Freezed models with abstract class + code generation
- Riverpod providers with `@riverpod` annotation + code generation
- Mock services (instant-2s delays)
- Multi-step flows: 8-step KYC, 6-step listing, 7-step signup, 7-step auction
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

**Schema:** v3.3 (Automated Code Generation - Freezed + Riverpod + JSON)
