# CLAUDE_SETUP.md - Auto-Initializing Documentation System

**Version:** 3.1 (Optimized & Auto-Splitting)
**Status:** Template - Ready for initialization

---

## 📋 Quick Start

**For New Projects:**
1. Copy this file (`CLAUDE_SETUP.md`) to your project root
2. First prompt to Claude: **"Initialize Claude setup"**
3. Done! Claude auto-detects your stack and creates 3 customized files

**For This Project:**
Already initialized! This file kept as reference/backup.

---

## 🤖 Instructions for Claude

**When user types: "Initialize Claude setup" or "Setup Claude documentation"**

**STEP 1: Auto-Detect Project**
- Read project manifest files to determine stack:
  - `pubspec.yaml` → Flutter/Dart
  - `package.json` → JavaScript/TypeScript (check for React/Vue/Angular/Node.js)
  - `Cargo.toml` → Rust
  - `go.mod` → Go
  - `requirements.txt` or `pyproject.toml` → Python
  - `Gemfile` → Ruby
  - `build.gradle` or `pom.xml` → Java/Kotlin
  - `*.csproj` → C#/.NET
  - `composer.json` → PHP

**STEP 2: Detect Platform Type**
- Check manifest for platform targets:
  - Flutter: Check `pubspec.yaml` for platforms
  - React/Vue: Check `package.json` scripts/dependencies
  - Backend: Check for server frameworks
  - CLI: Check for CLI-specific deps

**STEP 3: Split This File**
- Create 3 new files from sections below:
  1. `CLAUDE.md` (Section A)
  2. `CLAUDE_PHASES.md` (Section B)
  3. `CLAUDE_WORKFLOW.md` (Section C)

**STEP 4: Customize Files**
- Replace all `[AUTO-DETECT: ...]` with detected values
- Filter platform sections (keep only detected platforms)
- Add stack-specific patterns
- Remove template annotations
- Set initial version: 0.0.1+1 (or current if exists)

**STEP 5: Keep This File**
- Do NOT delete CLAUDE_SETUP.md after splitting
- Keep as backup/reference

**STEP 6: Commit**
- Stage all 4 files
- Commit: `docs: initialize Claude Code documentation`
- Show summary of detected configuration

---

# ═══════════════════════════════════════════════════════
# SECTION A: CLAUDE.md (Core - Always Loaded)
# ═══════════════════════════════════════════════════════

```markdown
# CLAUDE.md - Adaptive Engineering Standards v3.1 (Optimized)

## 0. Project Context [Auto-Updated]

**Project:** [AUTO-DETECT: project name from manifest]
**Type:** [AUTO-DETECT: Mobile App|Web App|Desktop App|API|Library|CLI Tool|Multi-Platform]
**Platforms:** [AUTO-DETECT: iOS, Android, Web, Windows, macOS, Linux, Server]
**Phase:** Prototype (v0.0.1) ← Auto-detected
**Version:** [AUTO-DETECT: version from manifest or 0.0.1+1]
**Updated:** [AUTO-DETECT: current date YYYY-MM-DD]

**Tech Stack:**
- Primary: [AUTO-DETECT: framework + version]
- State: [AUTO-DETECT: state management tool or N/A]
- Backend: [AUTO-DETECT: backend framework or "Mock" or "None"]
- DB: [AUTO-DETECT: database or "None"]
- Test: [AUTO-DETECT: test framework or "Manual"]
- CI/CD: Manual

**Build Targets:** Development, Staging, Production

---

## 1. Current Phase Standards: Prototype (v0.0.x)

**Quality:** Lint-clean preferred, no cov req
**Performance:** Functional > optimal
**Security:** Basic input validation
**Testing:** Manual acceptable
**Docs:** README + inline comments

**Platform ([AUTO-DETECT: detected platform]):**
- UI: [AUTO-DETECT: platform-specific requirements]
- Performance: [AUTO-DETECT: platform metrics]
- Assets: [AUTO-DETECT: asset requirements]
- Testing: [AUTO-DETECT: testing requirements]
- Distribution: [AUTO-DETECT: distribution requirements]

---

## 2. Core Instructions

**Phase Detection:** `v0.0→Proto | 0.1-4→Alpha | 0.5-9→Beta | 1.0→MVP | 1-2→Growth | 3+→Maturity`

**Workflow:**
1. Check PROJECT_STRUCTURE.md first (if exists)
2. Apply current phase standards (Section 1)
3. Complete user's tasks
4. **[AUTO] Post-Task Checklist:**
   - [ ] Update CLAUDE.md Section 0 if version/phase changed
   - [ ] Update PROJECT_STRUCTURE.md if structure/features changed
   - [ ] Generate semantic commits (ONE FILE = ONE COMMIT, single line only)
   - [ ] Bump version file ([AUTO-DETECT: manifest filename])
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

**Current Focus:** [AUTO-DETECT: from git branch or "Initial setup"]
**Branch:** [AUTO-DETECT: current git branch]

---

## 5. Project-Specific Notes [Auto-Updated]

**Patterns:**
[Claude will document discovered patterns here]

**Preferences:**
[Claude will learn your coding style here]

**Architecture:**
[Claude will log architectural decisions here]

---

## Extended Documentation

- **CLAUDE_PHASES.md** - All phase standards, platform specs, release checklists
- **CLAUDE_WORKFLOW.md** - Templates, commits, patterns, quick commands
- **PROJECT_STRUCTURE.md** - Folder tree, features, tech debt (auto-generated)
- **CLAUDE_SETUP.md** - This template (kept as backup/reference)

**Schema:** v3.1 (Optimized)
```

---

# ═══════════════════════════════════════════════════════
# SECTION B: CLAUDE_PHASES.md (Reference - Phase Standards)
# ═══════════════════════════════════════════════════════

```markdown
# CLAUDE_PHASES.md - Phase Standards & Platform Requirements

**Reference Document - Read when triggered by CLAUDE.md Section 3**

---

## Phase Standards Matrix

### Prototype (v0.0.x)
**Quality:** Lint-clean preferred, no cov req
**Performance:** Functional > optimal
**Security:** Basic input validation
**Testing:** Manual acceptable
**Docs:** README + inline comments

### Alpha (v0.1.x-v0.4.x)
**Quality:** ≥50% cov, lint ✓
**Performance:** <100ms interact, basic profiling
**Security:** Auth, basic authz
**Testing:** Unit tests for core logic
**Docs:** API docs + architecture diagrams

### Beta (v0.5.x-v0.9.x)
**Quality:** ≥70% cov, lint ✓, 0 warn
**Performance:** <50ms interact, <2s API, 60 FPS (if UI)
**Security:** OWASP Top 10, encrypted storage
**Testing:** Unit + integration, beta feedback
**Docs:** User guides + API docs

### MVP/Production (v1.0.x+)
**Quality:** ≥80% cov, lint ✓, 0 warn
**Performance:** <16ms frames (UI), <1s API, optimized assets
**Security:** OWASP compliant, pen tested, TLS
**Testing:** Unit + integration + E2E + load
**Docs:** Full user docs + runbooks + SLAs

### Growth (v1.x.x-v2.x.x)
**Quality:** ≥85% cov, mutation testing
**Performance:** CDN, caching, <10ms API p99
**Security:** Regular audits, bug bounty
**Testing:** Automated regression, canary deploys
**Docs:** Changelogs + migration guides

### Maturity (v3.x.x+)
**Quality:** ≥90% cov, legacy refactoring
**Performance:** Multi-region, edge computing
**Security:** Compliance certs (SOC2, ISO27001)
**Testing:** Chaos engineering, DR drills
**Docs:** Deprecation notices + sunset plans

---

## 1.5. Platform-Specific Standards

[AUTO-FILTER: Keep only detected platforms below]

### Mobile (iOS/Android)
**UI:** Native feel, gestures, offline-first
**Performance:** <2s cold start, <200MB mem
**Assets:** 1x/2x/3x variants, optimize size
**Testing:** Device farm (5+ devices for MVP)
**Distribution:** App Store + Play Store compliance

### Web/PWA
**UI:** Responsive (mobile/tablet/desktop), <5s LCP
**Performance:** Lighthouse >90 (MVP), lazy load
**Assets:** WebP/AVIF, code splitting
**Testing:** Cross-browser (Chrome/Firefox/Safari/Edge)
**Distribution:** CDN, SSL, CORS

### Desktop (Windows/macOS/Linux)
**UI:** Native window controls, keyboard shortcuts
**Performance:** <1s startup, <100MB base mem
**Assets:** Bundled resources, system theme
**Testing:** Installer testing, auto-updates
**Distribution:** Signed binaries

### API/Backend
**Architecture:** RESTful/GraphQL/gRPC
**Performance:** <100ms p95, rate limiting
**Security:** JWT/OAuth2, API versioning
**Testing:** Contract tests, load (1000+ RPS for Prod)
**Distribution:** Docker, k8s, health checks

### CLI Tool
**UX:** Consistent flags, help text
**Performance:** <1s startup
**Packaging:** Package managers (brew, apt, npm, pip)
**Testing:** Unit + integration
**Distribution:** GitHub releases

### Library/Package
**API:** Semantic versioning, stable public API
**Performance:** Benchmarks tracked
**Packaging:** Registry (npm, PyPI, crates.io, pub.dev)
**Testing:** 100% public API coverage (MVP)
**Distribution:** Multi-platform support

---

## 9. Phase Transition Checklists

### Prototype → Alpha (v0.0.x → v0.1.0)
- [ ] Core functionality works
- [ ] Basic error handling
- [ ] README with setup
- [ ] Tag: v0.1.0-alpha.1

### Alpha → Beta (v0.4.x → v0.5.0)
- [ ] All features implemented
- [ ] ≥50% cov
- [ ] Lint ✓, no critical warn
- [ ] Security basics (auth, validation)
- [ ] Beta feedback process ready
- [ ] Tag: v0.5.0-beta.1

### Beta → MVP (v0.9.x → v1.0.0)
- [ ] ≥70% cov (Beta met)
- [ ] 0 lint warn
- [ ] Security audit passed (OWASP Top 10)
- [ ] Performance benchmarks met
- [ ] User docs complete
- [ ] Production monitoring ready
- [ ] Rollback plan documented
- [ ] Legal/compliance review (if applicable)
- [ ] Tag: v1.0.0

### MVP → Growth (v1.0.x → v1.1.0)
- [ ] Analytics instrumented
- [ ] A/B testing framework
- [ ] Scalability tested (10x load)
- [ ] Support system operational
- [ ] Feature flagging implemented
- [ ] Tag: v1.1.0

### Growth → Maturity (v2.x.x → v3.0.0)
- [ ] Multi-region deployment
- [ ] SLA met (99.9%+ uptime)
- [ ] Disaster recovery tested
- [ ] Tech debt <20%
- [ ] Team knowledge transfer
- [ ] Tag: v3.0.0

---

## Release Commands by Stack

[AUTO-SELECT: Keep only detected stack]

### Flutter/Dart
```bash
flutter analyze
dart format .
flutter test --coverage
flutter build apk --release
# Update pubspec.yaml version
git tag v[X.Y.Z]
git push origin v[X.Y.Z]
```

### JavaScript/TypeScript (Node.js/React/Vue/Angular)
```bash
npm run lint
npm run format
npm test
npm run build
npm version [major|minor|patch]
git push origin v[X.Y.Z]
```

### Python
```bash
pylint src/
black .
pytest --cov
python setup.py build
# Update setup.py or pyproject.toml
git tag v[X.Y.Z]
git push origin v[X.Y.Z]
```

### Rust
```bash
cargo clippy
cargo fmt
cargo test
cargo build --release
# Update Cargo.toml
git tag v[X.Y.Z]
git push origin v[X.Y.Z]
```

### Go
```bash
go fmt ./...
go vet ./...
go test ./...
go build
# Update version in code
git tag v[X.Y.Z]
git push origin v[X.Y.Z]
```

### Ruby
```bash
rubocop
rspec
bundle exec rake build
# Update version in gemspec
git tag v[X.Y.Z]
git push origin v[X.Y.Z]
```

### Java/Kotlin
```bash
./gradlew check
./gradlew test
./gradlew build
# Update build.gradle version
git tag v[X.Y.Z]
git push origin v[X.Y.Z]
```

### C#/.NET
```bash
dotnet format
dotnet test
dotnet build --configuration Release
# Update .csproj version
git tag v[X.Y.Z]
git push origin v[X.Y.Z]
```

---

**File Version:** 3.1
**Last Updated:** [AUTO-DETECT: current date]
```

---

# ═══════════════════════════════════════════════════════
# SECTION C: CLAUDE_WORKFLOW.md (Reference - Templates & Patterns)
# ═══════════════════════════════════════════════════════

```markdown
# CLAUDE_WORKFLOW.md - Templates, Patterns & Commands

**Reference Document - Read when triggered by CLAUDE.md Section 3**

---

## 2. Response Templates

### Feature Complete
```
✅ [Feature Name] v[X.Y.Z]
Files: [count] modified
Branch: [name]
Coverage: [%]
Next: [action]
```

### Bug Fix
```
🔧 Fixed: [issue]
File: [path]
Change: [summary]
Verified: ✓
```

### Code Delivery
```
📦 [Description]
Changed: [file1, file2...]
Tests: [pass/fail]
Version: [X.Y.Z]
```

---

## 3. Conventional Commits

**Format:** `[type]([scope]): [description <50 chars]`

**CRITICAL Rules:**
- **One file = one commit** (atomic, never group files)
- **Single line only** (no body, no author, no metadata)
- **Max 50 chars**
- **Present tense** (add, not added)
- **No period at end**
- **Scope optional:** `feat(auth): add OAuth2`

**Types:**
- `feat` - New feature → Minor (+0.1.0)
- `fix` - Bug fix → Patch (+0.0.1)
- `update` - Dependency/config → Patch (+0.0.1)
- `perf` - Performance → Patch (+0.0.1)
- `build` - Build system → Patch (+0.0.1)
- `docs` - Documentation → No change
- `style` - Formatting → No change
- `refactor` - Code restructure → No change
- `test` - Add/modify tests → No change
- `chore` - Maintenance → No change
- `ci` - CI/CD changes → No change
- `revert` - Revert commit → Varies
- `feat!` or `BREAKING CHANGE` → Major (+1.0.0)

**Commit Command Format:**
```bash
# ✓ CORRECT - Single line, one file
git add file.dart
git commit -m "feat: add user authentication"

# ✗ WRONG - Multi-line with metadata
git commit -m "feat: add user authentication

Co-Authored-By: Someone <email>"

# ✗ WRONG - Multiple files in one commit
git add file1.dart file2.dart
git commit -m "feat: add multiple features"
```

**Examples:**
```
feat: add user authentication system
fix: resolve null pointer in service
update: upgrade framework to latest
perf: optimize rendering with memoization
feat!: redesign API response format
docs: add deployment guide
test: add integration tests
refactor: extract validation logic
chore: update gitignore
```

---

## 4. PROJECT_STRUCTURE.md Maintenance

**Auto-update when:**
- Folder structure changes
- New features added/completed
- Dependencies added/updated
- Tech debt identified
- Performance metrics change

**Sections to maintain:**
- Folder tree
- Feature matrix (name|status|version|branch)
- Tech debt log (P0-P3 priority)
- Performance baseline
- Dependency map

---

## 5. Quick Commands

[AUTO-CUSTOMIZE: Set commands for detected stack]

**@verify**
```bash
[AUTO-DETECT: test + lint commands for stack]
```

**@profile**
- Check performance metrics
- Measure startup/response time
- Memory usage analysis
- Identify bottlenecks

**@deps**
```bash
[AUTO-DETECT: dependency check command]
```

**@export**
- Generate PR summary
- List all commits since branch
- Show files changed
- Include test results

**@next**
- Check PROJECT_STRUCTURE.md tech debt
- Review current phase checklist
- Suggest next priority task

**@commit**
- Analyze all changed files
- Generate semantic commits
- Group related changes
- Determine version bump

**@update-context**
- Update CLAUDE.md Section 0
- Refresh version from manifest
- Update last updated timestamp

---

## 6. Code Patterns

[AUTO-CUSTOMIZE: Add detected stack's patterns]

### State Management
```[AUTO-DETECT: language]
[AUTO-DETECT: state management pattern for detected stack]
```

### Repository Pattern
```[AUTO-DETECT: language]
[AUTO-DETECT: repository pattern for detected stack]
```

### Error Handling
```[AUTO-DETECT: language]
[AUTO-DETECT: error handling pattern for detected stack]
```

---

## 7. Minimal Output Rules

1. **No explanations unless asked**
2. **No bash commands unless debugging**
3. **No redundant comments in code**
4. **Use shortcuts:**
   - STD = passes all standards
   - CA = follows Clean Architecture
   - ✓ = verified working

---

## 8. Performance Checklist

[AUTO-CUSTOMIZE: Keep relevant sections for platform]

### UI/Frontend
- [ ] Component rebuilds minimized
- [ ] Images optimized (appropriate format/size)
- [ ] Lazy loading implemented
- [ ] Memory leaks checked
- [ ] Network calls cached
- [ ] Animations smooth (60 FPS)

### Backend/API
- [ ] DB queries optimized (indexes, no N+1)
- [ ] Response compression enabled
- [ ] Connection pooling configured
- [ ] Caching strategy implemented
- [ ] Rate limiting in place

### General
- [ ] Build bundle size optimized
- [ ] Dependency tree pruned
- [ ] Code splitting (if applicable)
- [ ] Critical path optimized

---

## 10. Context Persistence

**Claude maintains:**
- Current version from manifest
- Project phase (version-based)
- Tech stack changes
- Last updated timestamp
- Discovered patterns

**Claude remembers:**
- Current feature being worked on
- Last version number
- Open tech debt items
- Performance baseline
- Architectural decisions
- User preferences

**Request:** Type `@context` to see full state

---

## 11. Efficiency Shortcuts

**Feature Shortcuts:**
- `+feat` = New feature (minor)
- `+fix` = Bug fix (patch)
- `+break` = Breaking change (major)
- `+test` = Add tests only
- `+docs` = Docs only

**Priority Flags:**
- `!perf` = Performance critical
- `!sec` = Security critical

---

## 12. Error Recovery

**If something breaks:**

1. **@rollback**
   ```bash
   git reset --hard HEAD~1
   # Or: git revert [commit]
   ```

2. **@debug**
   - Show detailed error logs
   - Stack traces
   - Environment info

3. **@clean**
   ```bash
   [AUTO-DETECT: clean/rebuild commands for stack]
   ```

4. **@reset**
   ```bash
   git stash
   git checkout main
   git pull origin main
   ```

---

## Definition of Done (Phase-Adaptive)

### Prototype
- [ ] Feature works as demonstrated
- [ ] Basic error handling

### Alpha
- [ ] Feature works as specified
- [ ] Unit tests (≥50% cov)
- [ ] Lint ✓

### Beta
- [ ] Feature works as specified
- [ ] Tests pass (≥70% cov)
- [ ] 0 lint warn
- [ ] Performance verified
- [ ] Docs updated

### MVP/Production
- [ ] Feature works as specified
- [ ] Tests pass (≥80% cov)
- [ ] 0 lint warn
- [ ] Performance verified
- [ ] Security reviewed
- [ ] Docs updated
- [ ] Version bumped
- [ ] PR ready

---

## Project-Specific Notes [Auto-Updated]

### Current Patterns
[Claude will document discovered patterns here]

### User Preferences
[Claude will learn your coding style here]

### Technical Decisions
[Claude will log architectural decisions here]

### API Endpoints
[Claude will document endpoints if applicable]

### Performance Baseline
[Claude will track metrics here]

---

**File Version:** 3.1
**Last Updated:** [AUTO-DETECT: current date]
```

---

## 📊 Detection Logic Reference

**For Claude - Stack Detection Priority:**

1. **Flutter/Dart:** pubspec.yaml exists
2. **React:** package.json + react in dependencies
3. **Vue:** package.json + vue in dependencies
4. **Angular:** package.json + @angular/core in dependencies
5. **Node.js API:** package.json + express/fastify/koa in dependencies
6. **Python:** requirements.txt OR pyproject.toml OR setup.py
7. **Rust:** Cargo.toml exists
8. **Go:** go.mod exists
9. **Ruby:** Gemfile exists
10. **Java:** build.gradle OR pom.xml
11. **C#:** *.csproj OR *.sln
12. **PHP:** composer.json exists

**Platform Detection:**
- Mobile: Check for mobile-specific dependencies/configs
- Web: Check for webpack/vite/parcel configs
- Desktop: Check for electron/tauri configs
- API: Check for server frameworks
- CLI: Check for CLI frameworks/bins

---

## ✅ Post-Initialization Summary Template

**For Claude to show after initialization:**

```
✅ Claude Code Documentation Initialized

**Detected Configuration:**
- Project: [detected name]
- Type: [detected type]
- Platform: [detected platforms]
- Stack: [detected stack with versions]
- Version: [current or 0.0.1+1]

**Files Created:**
✓ CLAUDE.md (core instructions)
✓ CLAUDE_PHASES.md (phase standards)
✓ CLAUDE_WORKFLOW.md (templates & patterns)
✓ CLAUDE_SETUP.md (kept as backup)

**Ready to commit? (Y/n)**
```

---

**Template Version:** 3.1 (Auto-Splitting)
**Last Updated:** 2025-10-12
**License:** MIT (adapt freely)
