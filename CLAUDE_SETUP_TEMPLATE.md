# CLAUDE.md Setup Template - Universal Software Development

**Template Version:** 3.1 (Optimized & Modular)
**Applicable to:** Any software development project (Web, Mobile, Desktop, API, CLI, Library)

---

## 📋 Quick Setup Instructions

### 1. Copy These 3 Files to Your Project Root:
```
CLAUDE.md               (Core - always loaded)
CLAUDE_PHASES.md        (Reference - phase standards)
CLAUDE_WORKFLOW.md      (Reference - templates & patterns)
```

### 2. Customize CLAUDE.md Section 0:
- Replace project name, type, platforms
- Update tech stack (framework, language, tools)
- Set initial version (0.0.1 for new projects)
- Remove this template after setup

### 3. First Prompt to Claude:
```
"Read this setup. Update CLAUDE.md Section 0 with our project details:
- Project: [Your Project Name]
- Type: [Mobile/Web/Desktop/API/CLI/Library]
- Stack: [Your Tech Stack]
- Delete all example content and template notes."
```

### 4. Claude Will Auto-Detect Phase:
- v0.0.x → Prototype
- v0.1-0.4.x → Alpha
- v0.5-0.9.x → Beta
- v1.0.x → MVP
- v1.x-2.x → Growth
- v3.x+ → Maturity

---

## 📄 File Templates Below

---

# ═══════════════════════════════════════════════════════
# TEMPLATE 1: CLAUDE.md (Core)
# ═══════════════════════════════════════════════════════

```markdown
# CLAUDE.md - Adaptive Engineering Standards v3.1 (Optimized)

## 0. Project Context [Auto-Updated]

**[REMOVE AFTER SETUP: Replace all [PLACEHOLDER] values below]**

**Project:** [Your Project Name]
**Type:** [Mobile App | Web App | Desktop App | API | Library | CLI Tool | Multi-Platform]
**Platforms:** [iOS, Android, Web, Windows, macOS, Linux, Server, etc.]
**Phase:** [Auto-detected] ← Auto-detected from version
**Version:** 0.0.1+1
**Updated:** [YYYY-MM-DD]

**Tech Stack:**
- Primary: [Framework/Language + Version] (e.g., React 18.2, Flutter 3.19, FastAPI 0.110)
- State: [State Management Tool or N/A] (e.g., Redux, Riverpod, Pinia, N/A)
- Backend: [Service/Framework or "Mock" or "None"] (e.g., Node.js Express, Django, Mock)
- DB: [Database System or "None"] (e.g., PostgreSQL, MongoDB, Firebase, None)
- Test: [Testing Framework] (e.g., Jest, pytest, flutter_test, Manual)
- CI/CD: [Pipeline or "Manual"] (e.g., GitHub Actions, GitLab CI, Manual)

**Build Targets:** [Development, Staging, Production]

---

## 1. Current Phase Standards: Prototype (v0.0.x)

**[REMOVE AFTER SETUP: Claude will auto-update this section based on version]**

**Quality:** Lint-clean preferred, no cov req
**Performance:** Functional > optimal
**Security:** Basic input validation
**Testing:** Manual acceptable
**Docs:** README + inline comments

**Platform ([Your Platform]):**
- UI: [Platform-specific requirements]
- Performance: [Platform-specific metrics]
- Assets: [Asset requirements]
- Testing: [Testing requirements]
- Distribution: [Distribution requirements]

**[REMOVE: See CLAUDE_PHASES.md for all phase standards]**

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
   - [ ] Suggest version bump (format: `→ 0.11.0+20`)
   - [ ] List commits (format: `filename | commit message`)

**CRITICAL:** Always run Post-Task Checklist before final response.

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

**Testing [HYBRID - Customize for your stack]:**
- **Claude runs for:** Complex/risky changes (new features, refactors)
- **User runs for:** Simple changes (docs, minor tweaks)
- **Command:** `@verify` to request Claude run checks
- **Examples:** `flutter analyze`, `npm test`, `pytest`, `cargo test`

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

**Current Focus:** [REMOVE: Claude will update this]
**Branch:** [REMOVE: Claude will update this]

---

## 5. Project-Specific Notes [Auto-Updated]

**[REMOVE AFTER SETUP: Claude will populate this during development]**

**Patterns:**
[Claude documents discovered patterns here]

**Preferences:**
[Claude learns your coding style here]

**Architecture:**
[Claude logs architectural decisions here]

---

## Extended Documentation

- **CLAUDE_PHASES.md** - All phase standards, platform specs, release checklists
- **CLAUDE_WORKFLOW.md** - Templates, commits, patterns, quick commands
- **PROJECT_STRUCTURE.md** - Folder tree, features, tech debt, dependencies (create as needed)

**Schema:** v3.1 (Optimized)
```

---

# ═══════════════════════════════════════════════════════
# TEMPLATE 2: CLAUDE_PHASES.md (Reference)
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

**[REMOVE AFTER SETUP: Keep only relevant platforms]**

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

**[REMOVE AFTER SETUP: Keep only your stack]**

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
# Update version in code/metadata
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
**Last Updated:** [Auto-updated by Claude]
```

---

# ═══════════════════════════════════════════════════════
# TEMPLATE 3: CLAUDE_WORKFLOW.md (Reference)
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

**Rules:**
- One file = one commit (atomic)
- Max 50 chars
- Present tense (add, not added)
- No period at end
- Scope optional: `feat(auth): add OAuth2`

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

**[REMOVE AFTER SETUP: Customize for your stack]**

**@verify**
```bash
# Examples - use your stack's commands
npm test && npm run lint
pytest && pylint src/
cargo test && cargo clippy
flutter analyze && flutter test
```

**@profile**
- Check performance metrics
- Measure startup/response time
- Memory usage analysis
- Identify bottlenecks

**@deps**
```bash
# Examples
npm outdated
pip list --outdated
cargo outdated
flutter pub outdated
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

**[REMOVE AFTER SETUP: Add your stack's patterns]**

### Example: State Management
```javascript
// Redux example
const reducer = (state = initialState, action) => {
  switch (action.type) {
    case 'UPDATE':
      return { ...state, ...action.payload };
    default:
      return state;
  }
};
```

### Example: Repository Pattern
```typescript
// Domain - abstraction
interface IRepository<T> {
  fetch(id: string): Promise<T>;
  save(entity: T): Promise<void>;
}

// Data - implementation
class RepositoryImpl<T> implements IRepository<T> {
  async fetch(id: string): Promise<T> {
    // Implementation
  }
  async save(entity: T): Promise<void> {
    // Implementation
  }
}
```

### Example: Error Handling
```python
# Result type pattern
from typing import Union, Generic, TypeVar

T = TypeVar('T')

class Success(Generic[T]):
    def __init__(self, data: T):
        self.data = data

class Failure:
    def __init__(self, error: str):
        self.error = error

Result = Union[Success[T], Failure]
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

**[REMOVE AFTER SETUP: Customize for your platform]**

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
   # Examples
   flutter clean && flutter pub get
   npm ci
   cargo clean && cargo build
   rm -rf node_modules && npm install
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

**[REMOVE AFTER SETUP: Claude will populate this during development]**

### Current Patterns
[Claude documents discovered patterns here]

### User Preferences
[Claude learns your coding style here]

### Technical Decisions
[Claude logs architectural decisions here]

### API Endpoints
[Claude documents endpoints if applicable]

### Performance Baseline
[Claude tracks metrics here]

---

**File Version:** 3.1
**Last Updated:** [Auto-updated by Claude]
```

---

## 🎯 Post-Setup Checklist

After copying files to your project:

1. [ ] Renamed files (removed TEMPLATE_ prefix if used)
2. [ ] Updated CLAUDE.md Section 0 with project details
3. [ ] Removed all `[REMOVE AFTER SETUP]` annotations
4. [ ] Kept only relevant platform sections in CLAUDE_PHASES.md
5. [ ] Customized code patterns in CLAUDE_WORKFLOW.md Section 6
6. [ ] Updated release commands for your stack in CLAUDE_PHASES.md
7. [ ] Set initial version (0.0.1 for new projects)
8. [ ] Committed files: `git add CLAUDE*.md && git commit -m "docs: add Claude Code documentation"`
9. [ ] Tested with first prompt to Claude
10. [ ] Created PROJECT_STRUCTURE.md (optional, Claude can generate)

---

## 📚 Additional Resources

**For more information:**
- Full implementation example: See `CLAUDE_v3.0_FULL.md` (if available)
- Original unoptimized version: See backup files
- Claude Code docs: https://docs.claude.com/claude-code

**Support:**
- GitHub Issues: https://github.com/anthropics/claude-code/issues
- Community: https://discord.gg/anthropic

---

**Template maintained by:** Claude Code Community
**License:** MIT (adapt freely)
**Version:** 3.1 (Optimized & Modular)
**Last Updated:** 2025-10-12
