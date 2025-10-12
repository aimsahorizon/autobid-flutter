# CLAUDE.md - Adaptive Engineering Standards v3.0

**Template Version - Universal Software Development Guide**

---

## 0. Project Context [Auto-Updated]

Project Name: [Your Project Name]
Project Type: [Mobile App | Web App | Desktop App | API | Library | CLI Tool | Multi-Platform | Full-Stack | Microservice]
Target Platforms: [iOS, Android, Web, Windows, macOS, Linux, Server, Edge, etc.]

Development Phase: [Auto-detected from version] ← Claude auto-detects
├─ Prototype (v0.0.x) - Proof of concept, rapid iteration
├─ Alpha (v0.1.x-v0.4.x) - Core features, internal testing
├─ Beta (v0.5.x-v0.9.x) - Feature complete, user testing
├─ MVP (v1.0.x) - Public launch, minimum viable features
├─ Growth (v1.x.x-v2.x.x) - Feature expansion, scaling
├─ Maturity (v3.x.x+) - Optimization, maintenance, legacy support
└─ Sunset - Deprecation, migration planning

Tech Stack:
  Primary: [Framework/Language + Version]
  State Management: [Tool/Pattern or N/A]
  Backend: [Service/Framework or "Mock" or "None"]
  Database: [System/Service or "None"]
  Testing: [Framework(s) or "Manual"]
  CI/CD: [Pipeline/Service or "Manual"]

Current Version: [X.Y.Z+build]
Build Targets: [Development, Staging, Production]
Last Updated: [YYYY-MM-DD]

---

## 1. Engineering Standards [Phase-Adaptive]

### Core Principles (All Phases):
- Architecture: Clean/Domain-Driven/Modular as appropriate
- Code: Type-safe, null-safe, version-controlled
- Dependencies: Documented, security-audited
- Reviews: Code review before merge (Beta+)

### Phase-Specific Standards:

**Prototype (v0.0.x):**
- Quality: Lint-clean preferred, no coverage requirement
- Performance: Functional > optimal
- Security: Basic input validation only
- Testing: Manual testing acceptable
- Documentation: README + inline comments
- Deployment: Local/dev environment only

**Alpha (v0.1.x-v0.4.x):**
- Quality: ≥50% test coverage, lint-clean
- Performance: <100ms interactions, basic profiling
- Security: Authentication, basic authorization
- Testing: Unit tests for core logic
- Documentation: API docs + architecture diagrams
- Deployment: Internal staging environment

**Beta (v0.5.x-v0.9.x):**
- Quality: ≥70% test coverage, lint-clean, no warnings
- Performance: <50ms interactions, <2s API, 60 FPS (if UI)
- Security: OWASP Top 10 addressed, encrypted storage
- Testing: Unit + integration tests, beta user feedback
- Documentation: User guides + API docs
- Deployment: Public beta/staging with rollback

**MVP/Production (v1.0.x+):**
- Quality: ≥80% test coverage, lint-clean, zero warnings
- Performance: <16ms frames (UI), <1s API, optimized assets
- Security: OWASP compliance, penetration tested, TLS
- Testing: Unit + integration + E2E + load testing
- Documentation: Full user docs + runbooks + SLAs
- Deployment: Production with monitoring + alerts

**Growth (v1.x.x-v2.x.x):**
- Quality: ≥85% coverage, mutation testing
- Performance: CDN, caching, <10ms API p99
- Security: Regular audits, bug bounty program
- Testing: Automated regression, canary deployments
- Documentation: Changelogs + migration guides
- Deployment: Multi-region, blue-green deployments

**Maturity (v3.x.x+):**
- Quality: ≥90% coverage, legacy code refactoring
- Performance: Multi-region, edge computing
- Security: Compliance certifications (SOC2, ISO27001)
- Testing: Chaos engineering, disaster recovery drills
- Documentation: Deprecation notices + sunset plans
- Deployment: HA clusters, auto-scaling

---

## 1.5. Platform-Specific Standards

### Mobile (iOS/Android):
- UI: Native feel, gesture support, offline-first
- Performance: <2s cold start, <200MB memory (Beta+)
- Assets: 1x/2x/3x image variants, optimize for size
- Testing: Device farm testing (5+ devices for MVP)
- Distribution: App Store + Play Store compliance
- Accessibility: VoiceOver/TalkBack support (Beta+)

### Web/PWA:
- UI: Responsive (mobile/tablet/desktop), <5s LCP
- Performance: Lighthouse score >90 (MVP), lazy loading
- Assets: WebP/AVIF images, code splitting
- Testing: Cross-browser (Chrome, Firefox, Safari, Edge)
- Distribution: CDN, SSL, CORS configured
- Accessibility: WCAG 2.1 AA compliance (Beta+)

### Desktop (Windows/macOS/Linux):
- UI: Native window controls, keyboard shortcuts
- Performance: <1s startup, <100MB base memory
- Assets: Bundled resources, system theme support
- Testing: Installer testing, update mechanisms
- Distribution: Signed binaries, auto-updates
- Accessibility: Screen reader support (Beta+)

### API/Backend:
- Architecture: RESTful/GraphQL/gRPC standards
- Performance: <100ms p95 (MVP), rate limiting
- Security: JWT/OAuth2, API versioning
- Testing: Contract tests, load testing (1000+ RPS for Production)
- Distribution: Docker, k8s, health checks
- Documentation: OpenAPI/Swagger specs (Beta+)

### CLI Tool:
- UX: Consistent flag conventions, help text
- Performance: <1s startup for simple commands
- Packaging: Homebrew, apt, chocolatey support (MVP)
- Testing: Unit tests + integration tests
- Distribution: GitHub releases, package managers
- Documentation: Man pages, --help output

### Library/Package:
- API: Semantic versioning, stable public API
- Performance: Benchmarks tracked, no regressions
- Packaging: Published to package registry (npm, PyPI, crates.io)
- Testing: 100% public API test coverage (MVP)
- Distribution: Multi-platform support documented
- Documentation: API reference, usage examples

### Multi-Platform:
- UI: Shared design system, platform adaptations
- Performance: Meet strictest platform requirement
- Assets: Platform-specific bundles
- Testing: All target platform test suites
- Distribution: Coordinated releases
- Documentation: Platform-specific guides

---

## 2. Response Templates

**Feature Complete:**
```
✅ [Feature Name] v[X.Y.Z]
Files: [count] modified
Branch: [branch-name]
Coverage: [%]
Next: [action]
```

**Bug Fix:**
```
🔧 Fixed: [issue]
File: [path]
Change: [summary]
Verified: ✓
```

**Code Delivery:**
```
📦 [Description]
Changed: [file1, file2...]
Tests: [pass/fail]
Version: [X.Y.Z]
```

**Commits:**
```
- feat: add user authentication
- fix: resolve memory leak in cache
- update: upgrade dependencies to latest
```

---

## 3. Conventional Commits and Semantic Versioning

**Commit Type → Version Impact:**
- `feat` → Minor (+0.1.0)
- `fix`, `update`, `perf`, `build` → Patch (+0.0.1)
- `feat!` or `BREAKING CHANGE` → Major (+1.0.0)
- `docs`, `style`, `refactor`, `test`, `chore`, `ci` → No change
- `revert` → Varies based on reverted commit

**Commit Rules:**
- One file = One commit (atomic commits)
- Max 50 chars in commit message
- Present tense (add, not added)
- No period at end
- Scope optional: `feat(auth): add OAuth2 login`

**Auto-Action Triggers:**
- New feature → Create feature branch → `feat: [description]`
- Bug fix → Update CHANGELOG → `fix: [description]`
- Breaking change → Migration guide + ! → `feat!: [description]`
- Performance fix → Profile metrics → `perf: [description]`
- Major changes → Suggest branch name: `username/feature-description`

---

## 4. PROJECT_STRUCTURE.md

Claude maintains and auto-updates PROJECT_STRUCTURE.md with:
- Folder tree (auto-updated on changes)
- Feature matrix (name|status|version|branch)
- Tech debt log (priority ranked)
- Performance baseline (metrics tracked)
- Dependency map (package:version:last-updated)

---

## 5. Workflow Optimization

**Quick Commands:**
- `@verify` - Run tests + lint
- `@profile` - Check performance metrics
- `@deps` - Audit dependencies
- `@export` - Generate PR summary with commits
- `@next` - Suggest next task
- `@commit` - Generate commit messages for all changes
- `@update-context` - Update CLAUDE.md project info

**Auto-Commit Workflow:**
For each changed file:
1. Analyze change type
2. Generate semantic commit: `[type]: [concise description under 50 chars]`
3. Group related changes if needed
4. Update version based on highest impact change

**Decision Tree:**
```
Issue reported?
├─ Critical? → Hotfix branch → fix: [message] → Patch
├─ Feature? → Feature branch → feat: [message] → Minor
└─ Refactor? → Chore branch → refactor: [message] → No change
```

---

## 6. Code Patterns

### State Management (Example - Adapt to your stack):
```
// Riverpod example
@riverpod
class FeatureController extends _$FeatureController {
  @override
  FutureOr<State> build() => repository.fetch();
}

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

### Repository Pattern:
```
// Domain layer - pure abstraction
interface IRepository {
  fetch(id: string): Promise<Entity>;
}

// Data layer - implementation
class RepositoryImpl implements IRepository {
  async fetch(id: string): Promise<Entity> {
    // API/Cache logic here
  }
}
```

### Error Handling:
```
// Result type pattern
type Result<T> =
  | { success: true; data: T }
  | { success: false; error: string };

// Or use language-specific patterns (Either, Option, etc.)
```

---

## 7. Minimal Output Rules

1. No explanations unless asked
2. No bash commands unless debugging
3. No redundant comments in code
4. Use shortcuts:
   - **STD** = passes all standards
   - **CA** = follows Clean Architecture
   - **✓** = verified working

---

## 8. Performance Checklist

### UI/Frontend:
- Widget/Component rebuilds minimized
- Images optimized (appropriate format/size)
- Lazy loading implemented
- Memory leaks checked (cleanup on unmount)
- Network calls cached
- Animations at 60 FPS

### Backend/API:
- Database queries optimized (indexes, N+1 prevention)
- Response compression enabled
- Connection pooling configured
- Caching strategy implemented
- Rate limiting in place
- Async operations where appropriate

### General:
- Build bundle size optimized
- Dependency tree pruned
- Code splitting implemented (where applicable)
- Critical path optimized
- Profiling data collected (Beta+)

---

## 9. Release Checklist [Phase-Adaptive]

### Prototype → Alpha (v0.0.x → v0.1.0):
- [ ] Core functionality works
- [ ] Basic error handling
- [ ] README with setup instructions
- [ ] Tag: `v0.1.0-alpha.1`

### Alpha → Beta (v0.4.x → v0.5.0):
- [ ] All planned features implemented
- [ ] ≥50% test coverage
- [ ] Lint-clean, no critical warnings
- [ ] Security basics in place (auth, input validation)
- [ ] Beta user feedback process ready
- [ ] Tag: `v0.5.0-beta.1`

### Beta → MVP (v0.9.x → v1.0.0):
- [ ] ≥70% test coverage (Beta standard met)
- [ ] Zero lint warnings
- [ ] Security audit passed (OWASP Top 10)
- [ ] Performance benchmarks met
- [ ] User documentation complete
- [ ] Production monitoring ready
- [ ] Rollback plan documented
- [ ] Legal/compliance review (if applicable)
- [ ] Tag: `v1.0.0`

### MVP → Growth (v1.0.x → v1.1.0):
- [ ] Analytics instrumented
- [ ] A/B testing framework ready
- [ ] Scalability tested (10x current load)
- [ ] Customer support system operational
- [ ] Feature flagging implemented
- [ ] Tag: `v1.1.0`

### Growth → Maturity (v2.x.x → v3.0.0):
- [ ] Multi-region deployment
- [ ] SLA commitments met (99.9%+ uptime)
- [ ] Disaster recovery tested
- [ ] Technical debt <20%
- [ ] Team knowledge transfer complete
- [ ] Tag: `v3.0.0`

### Pre-Release Commands (Adapt to your stack):
```bash
# Linting
npm run lint / cargo clippy / flutter analyze / pylint

# Formatting
prettier --write . / cargo fmt / dart format . / black .

# Testing
npm test / cargo test / flutter test / pytest

# Building
npm run build / cargo build --release / flutter build / python setup.py
```

### Release Commands (All Phases):
```bash
# Version bump (in package.json/Cargo.toml/pubspec.yaml/setup.py)
# Update CHANGELOG.md
git tag v[X.Y.Z]
git push origin v[X.Y.Z]
```

---

## 10. Context Persistence

Claude automatically maintains:
- Current version from package manifest
- Project phase (Prototype → Maturity)
- Tech stack additions/changes
- Last updated timestamp
- Project-specific patterns discovered

Claude remembers:
- Current feature being worked on
- Last version number
- Open tech debt items
- Performance baseline
- Recent architectural decisions
- User preferences and patterns

Request with: `@context` to see current state

---

## 11. Efficiency Shortcuts

- `+feat` = New feature (minor version)
- `+fix` = Bug fix (patch version)
- `+break` = Breaking change (major)
- `+test` = Add tests only
- `+docs` = Documentation only
- `!perf` = Performance critical
- `!sec` = Security critical

---

## 12. Error Recovery

If something breaks:
1. `@rollback` - Revert last change
2. `@debug` - Show detailed logs
3. `@clean` - Clean rebuild
4. `@reset` - Reset to last stable

---

## Definition of Done [Phase-Adaptive]

**Prototype:**
- [ ] Feature works as demonstrated
- [ ] Basic error handling

**Alpha:**
- [ ] Feature works as specified
- [ ] Unit tests written (≥50% coverage)
- [ ] Lint-clean

**Beta:**
- [ ] Feature works as specified
- [ ] Tests pass (≥70% coverage)
- [ ] No lint warnings
- [ ] Performance verified
- [ ] Docs updated

**MVP/Production:**
- [ ] Feature works as specified
- [ ] Tests pass (≥80% coverage)
- [ ] Zero lint warnings
- [ ] Performance verified
- [ ] Security reviewed
- [ ] Docs updated
- [ ] Version bumped
- [ ] PR ready

---

## Project-Specific Notes [Auto-Updated]

Claude will populate this section based on:
- User requirements and preferences
- Discovered patterns in codebase
- Custom business logic rules
- API endpoints and contracts
- Performance bottlenecks found
- Team conventions observed
- Integration requirements

### Current Project Patterns:
[Claude updates this section automatically]

### User Preferences:
[Claude learns and documents your coding style]

### Technical Decisions:
[Claude logs key architectural choices made]

---

## Instructions for Claude:

1. **Auto-detect project phase from version number:**
   - v0.0.x → Prototype
   - v0.1.x-v0.4.x → Alpha
   - v0.5.x-v0.9.x → Beta
   - v1.0.x → MVP
   - v1.x.x-v2.x.x → Growth
   - v3.x.x+ → Maturity

2. Apply phase-appropriate standards automatically from Section 1
3. Check platform requirements from Section 1.5 based on Target Platforms
4. Adjust "Definition of Done" based on current phase
5. Always check PROJECT_STRUCTURE.md first before starting work
6. Use templates from Section 2 for responses
7. Auto-generate semantic commits for each file (Section 3)
8. Auto-increment package version after completing tasks in each prompt
9. Auto-update CLAUDE.md Section 0 when version changes or phase transitions
10. Update Project-Specific Notes from learnings during development
11. Suggest phase graduation when next milestone criteria met (Section 9)
12. Warn if standards violated for current phase
13. Remind user to /export conversation after major work
14. Maintain single source of truth across CLAUDE.md and PROJECT_STRUCTURE.md
15. Never explain unless asked (Section 7: Minimal Output Rules)
16. Focus on deliverables only
17. Follow conventional commit format strictly (Section 3)
18. One atomic commit per logical change

### Version Update Rules:
- After completing ALL tasks in user's prompt, update package version
- Determine version bump from highest-impact commit type made:
  - `feat` → Minor (+0.1.0)
  - `fix`/`update`/`perf`/`build` → Patch (+0.0.1)
  - `feat!`/`BREAKING CHANGE` → Major (+1.0.0)
  - `docs`/`style`/`refactor`/`test`/`chore`/`ci` → No version change
- If no version-impacting changes, skip version bump
- Update CLAUDE.md Section 0 "Current Version" after bumping

### Export Reminders:
- After feature completion: "Ready to /export"
- After bug fixes: "Consider /export for history"
- End of session: "Remember to /export this session"

### Commit Examples:
```
- feat: add user authentication system
- fix: resolve memory leak in cache manager
- update: upgrade React to 18.3.0
- perf: optimize database query with indexes
- feat!: redesign API response format
- docs: add deployment guide
- test: add integration tests for payment flow
```

### Current Focus:
[Set by Claude or from PROJECT_STRUCTURE.md]

---

**Last Updated:** [YYYY-MM-DD]
**Schema Version:** 3.0

---

## 📝 Usage Instructions

1. **Copy this template** to your project root as `CLAUDE.md`
2. **Fill in Section 0** with your project details
3. **Customize Section 6** with your stack's code patterns
4. **Adjust Section 8** performance targets for your platform
5. **Update Section 9** release commands for your tooling
6. **Let Claude auto-update** Project-Specific Notes as you work

**Compatible with:**
- JavaScript/TypeScript (React, Vue, Angular, Node.js, Deno)
- Python (Django, Flask, FastAPI)
- Rust (Axum, Actix, Tauri)
- Go (Gin, Echo, Fiber)
- Java/Kotlin (Spring, Android)
- Swift (iOS, macOS)
- C#/.NET (ASP.NET, Unity, Xamarin)
- Ruby (Rails, Sinatra)
- PHP (Laravel, Symfony)
- Flutter/Dart
- And any other modern software stack!

---

**Template maintained by:** Claude Code Users
**License:** MIT (adapt freely to your needs)
