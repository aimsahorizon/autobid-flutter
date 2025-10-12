CLAUDE.md - Adaptive Engineering Standards v3.0

0. Project Context [Auto-Updated]

Project Name: AutoBID - Online Reused Car Auction
Project Type: Multi-Platform App
Target Platforms: iOS, Android, Web

Development Phase: Beta (v0.8.3) ← Claude auto-detects
├─ Prototype (v0.0.x) - Proof of concept, rapid iteration
├─ Alpha (v0.1.x-v0.4.x) - Core features, internal testing
├─ Beta (v0.5.x-v0.9.x) - Feature complete, user testing
├─ MVP (v1.0.x) - Public launch, minimum viable features
├─ Growth (v1.x.x-v2.x.x) - Feature expansion, scaling
├─ Maturity (v3.x.x+) - Optimization, maintenance, legacy support
└─ Sunset - Deprecation, migration planning

Tech Stack:
  Primary: Flutter 3.9.2 (Dart SDK ^3.9.2)
  State Management: Riverpod 3.0.1 + Provider 6.1.1 (migrating to full Riverpod)
  Backend: Mock Services (Firebase 4.1.1 planned for production)
  Database: In-memory (Cloud Firestore 6.0.2 planned)
  Testing: flutter_test, Manual testing
  CI/CD: Manual

Current Version: 0.8.4+12
Build Targets: Debug, Release
Last Updated: 2025-10-12

---

1. Engineering Standards [Phase-Adaptive]

Core Principles (All Phases):
- Architecture: Clean/Domain-Driven/Modular as appropriate
- Code: Null-safe, typed, version-controlled
- Dependencies: Documented, audited for security

Phase-Specific Standards:

Prototype (v0.0.x):
- Quality: Lint-clean preferred, no coverage requirement
- Performance: Functional > optimal
- Security: Basic input validation only
- Testing: Manual testing acceptable
- Documentation: README + inline comments

Alpha (v0.1.x-v0.4.x):
- Quality: ≥50% test coverage, lint-clean
- Performance: <100ms interactions, basic profiling
- Security: Authentication, basic authorization
- Testing: Unit tests for core logic
- Documentation: API docs + architecture diagrams

Beta (v0.5.x-v0.9.x): ← CURRENT PHASE
- Quality: ≥70% test coverage, lint-clean, no warnings
- Performance: <50ms interactions, <2s API, 60 FPS
- Security: OWASP Top 10 addressed, encrypted storage
- Testing: Unit + integration tests, beta user feedback
- Documentation: User guides + API docs

MVP/Production (v1.0.x+):
- Quality: ≥80% test coverage, lint-clean, zero warnings
- Performance: <16ms frames, <1s API, optimized assets
- Security: OWASP compliance, penetration tested, TLS
- Testing: Unit + integration + E2E + load testing
- Documentation: Full user docs + runbooks + SLAs

Growth (v1.x.x-v2.x.x):
- Quality: ≥85% coverage, mutation testing
- Performance: CDN, caching, <10ms API p99
- Security: Regular audits, bug bounty program
- Testing: Automated regression, canary deployments
- Documentation: Changelogs + migration guides

Maturity (v3.x.x+):
- Quality: ≥90% coverage, legacy code refactoring
- Performance: Multi-region, edge computing
- Security: Compliance certifications (SOC2, ISO27001)
- Testing: Chaos engineering, disaster recovery drills
- Documentation: Deprecation notices + sunset plans

---

1.5. Platform-Specific Standards

Mobile (iOS/Android):
- UI: Native feel, gesture support, offline-first
- Performance: <2s cold start, <200MB memory
- Assets: 1x/2x/3x image variants, <100KB per image (Beta phase)
- Testing: Device farm testing (5+ devices for MVP)
- Distribution: App Store + Play Store compliance

Web/PWA:
- UI: Responsive (mobile/tablet/desktop), <5s LCP
- Performance: Lighthouse score >90 (MVP), lazy loading
- Assets: WebP/AVIF images, code splitting
- Testing: Cross-browser (Chrome, Firefox, Safari, Edge)
- Distribution: CDN, SSL, CORS configured

Desktop (Windows/macOS/Linux):
- UI: Native window controls, keyboard shortcuts
- Performance: <1s startup, <100MB base memory
- Assets: Bundled resources, system theme support
- Testing: Installer testing, update mechanisms
- Distribution: Signed binaries, auto-updates

API/Backend:
- Architecture: RESTful/GraphQL/gRPC standards
- Performance: <100ms p95, rate limiting
- Security: JWT/OAuth2, API versioning
- Testing: Contract tests, load testing (1000+ RPS for Production)
- Distribution: Docker, k8s, health checks

Multi-Platform (Current):
- UI: Shared design system, platform adaptations
- Performance: Meet strictest platform requirement
- Assets: Platform-specific bundles
- Testing: All target platform test suites
- Distribution: Coordinated releases

---

2. Response Templates

Feature Complete:
✅ [Feature Name] v[X.Y.Z]
Files: [count] modified
Branch: feature/[name]
Coverage: [%]
Next: [action]

Bug Fix:
🔧 Fixed: [issue]
File: [path]
Change: [summary]
Verified: ✓

Code Delivery:
📦 [Description]
Changed: [file1, file2...]
Tests: [pass/fail]
Version: [X.Y.Z]

Commits:
- feat: add login screen
- fix: resolve navigation bug
- update: upgrade dependencies

---

3. Conventional Commits and Semantic Versioning

Use conventional commit format for all commits. Each commit type determines the version change:

Patch version (+0.0.1): fix, update, perf, build
Minor version (+0.1.0): feat
Major version (+1.0.0): feat! or commits with BREAKING CHANGE
No version change: docs, style, refactor, test, chore, ci
Special: revert varies based on what's being reverted

Auto-Commit Rules:
- One file = One commit (atomic commits)
- Max 50 chars in commit message
- Present tense (add, not added)
- No period at end
- Scope optional: feat(auth): add OAuth2 login

Auto-Action Triggers:
- New feature → Create feature branch → feat: [description]
- Bug fix → Update CHANGELOG → fix: [description]
- Breaking change → Migration guide + ! → feat!: [description]
- Performance fix → Profile metrics → perf: [description]
- Every major changes → suggest branch name in the beginning: "username/branch-description"

---

4. PROJECT_STRUCTURE.md and Export History

Claude maintains and auto updates PROJECT_STRUCTURE.md with:
- Folder tree (auto-updated on changes)
- Feature matrix (name|status|version|branch)
- Tech debt log (priority ranked)
- Performance baseline (FPS, memory, startup)
- Dependency map (package:version:last-updated)

---

5. Workflow Optimization

Quick Commands:
@verify - Run tests + lint
@profile - Check performance metrics
@deps - Audit dependencies
@export - Generate PR summary with commits
@next - Suggest next task
@commit - Generate commit messages for all changes
@update-context - Update CLAUDE.md project info

Auto-Commit Workflow:
For each changed file:
1. Analyze change type
2. Generate semantic commit: [type]: [concise description under 50 chars]
3. Group related changes if needed
4. Update version based on highest impact change

Decision Tree:
Issue reported?
├─ Critical? → Hotfix branch → fix: [message] → Patch
├─ Feature? → Feature branch → feat: [message] → Minor
└─ Refactor? → Chore branch → refactor: [message] → No change

---

6. Code Patterns

State Management (Riverpod):
@riverpod
class FeatureController extends _$FeatureController {
  @override
  FutureOr<State> build() => repository.fetch();
}

Repository Pattern:
// Domain layer - pure abstraction
abstract class IRepository {
  Future<Entity> fetch(String id);
}

// Data layer - implementation
class RepositoryImpl implements IRepository {
  // API/Cache logic here
}

Error Handling:
// Consistent Result type
sealed class Result<T> {
  const Result();
}
class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}
class Failure<T> extends Result<T> {
  final String message;
  const Failure(this.message);
}

---

7. Minimal Output Rules

1. No explanations unless asked
2. No bash commands unless debugging
3. No redundant comments in code
4. Use shortcuts: 
   - STD = passes all standards
   - CA = follows Clean Architecture
   - ✓ = verified working

---

8. Performance Checklist

- Widget rebuilds minimized (const widgets)
- Images optimized (<100KB per image)
- Lazy loading implemented
- Memory leaks checked (dispose controllers)
- Network calls cached
- Animations at 60 FPS

---

9. Release Checklist [Phase-Adaptive]

Prototype → Alpha (v0.0.x → v0.1.0):
- [ ] Core functionality works
- [ ] Basic error handling
- [ ] README with setup instructions
- [ ] Tag: v0.1.0-alpha.1

Alpha → Beta (v0.4.x → v0.5.0):
- [ ] All planned features implemented
- [ ] ≥50% test coverage
- [ ] Lint-clean, no critical warnings
- [ ] Security basics in place (auth, input validation)
- [ ] Beta user feedback process ready
- [ ] Tag: v0.5.0-beta.1

Beta → MVP (v0.9.x → v1.0.0): ← NEXT MILESTONE
- [ ] ≥70% test coverage (Beta standard met)
- [ ] Zero lint warnings
- [ ] Security audit passed (OWASP Top 10)
- [ ] Performance benchmarks met (<50ms interactions, 60 FPS)
- [ ] User documentation complete
- [ ] Production monitoring ready
- [ ] Rollback plan documented
- [ ] Legal/compliance review (if applicable)
- [ ] Tag: v1.0.0

MVP → Growth (v1.0.x → v1.1.0):
- [ ] Analytics instrumented
- [ ] A/B testing framework ready
- [ ] Scalability tested (10x current load)
- [ ] Customer support system operational
- [ ] Feature flagging implemented
- [ ] Tag: v1.1.0

Growth → Maturity (v2.x.x → v3.0.0):
- [ ] Multi-region deployment
- [ ] SLA commitments met (99.9%+ uptime)
- [ ] Disaster recovery tested
- [ ] Technical debt <20%
- [ ] Team knowledge transfer complete
- [ ] Tag: v3.0.0

Pre-Release Commands (All Phases):
- lint: flutter analyze / dart analyze
- format: dart format .
- test: flutter test --coverage (if tests exist)
- build: flutter build [apk|web|windows] --release

Release Commands (All Phases):
- version: bump in pubspec.yaml
- changelog: update CHANGELOG.md
- tag: git tag v[X.Y.Z]
- push: git push origin v[X.Y.Z]

---

10. Context Persistence

Claude automatically maintains:
- Current version from pubspec.yaml
- Project phase (MVP→Scale→Maintenance)
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

Request with: @context to see current state

---

11. Efficiency Shortcuts

+feat = New feature (minor version)
+fix = Bug fix (patch version)
+break = Breaking change (major)
+test = Add tests only
+docs = Documentation only
!perf = Performance critical
!sec = Security critical

---

12. Error Recovery

If something breaks:
1. @rollback - Revert last change
2. @debug - Show detailed logs
3. @clean - Clean rebuild
4. @reset - Reset to last stable

---

Definition of Done

✅ Checklist:
- Feature works as specified
- Tests pass (>80% coverage)
- No lint warnings
- Performance verified
- Docs updated
- Version bumped
- PR ready

---

Project-Specific Notes [Auto-Updated]

Claude will populate this section based on:
- User requirements and preferences
- Discovered patterns in codebase
- Custom business logic rules
- API endpoints and contracts
- Performance bottlenecks found
- Team conventions observed
- Integration requirements

Current Project Patterns:
- Freezed models with abstract class keyword for immutability
- Mock services with realistic delays (instant to 2s) for demo
- Multi-step flows: 8-step KYC, 6-step listing creation, 7-step auction
- Philippine-specific data: locations, payment methods, government IDs
- Material Design 3 with green primary theme (#4CAF50)
- Grid/List view toggles for browsing
- Countdown timers with color-coded urgency (green/orange/red)

User Preferences:
- Prefers concise responses, minimal explanations
- Wants atomic commits per file with semantic versioning
- Expects auto-updates to PROJECT_STRUCTURE.md and CLAUDE.md
- Uses mock services for thesis demo (Firebase integration planned later)
- Solo developer, beginner-friendly approaches preferred

Technical Decisions:
- Hybrid state management: Riverpod + Provider (migrating to full Riverpod)
- Clean Architecture enforced (Presentation → Domain → Data layers)
- All models use Freezed + JSON serialization
- Mock services return realistic Philippine market data
- KYC system requires 8 steps with government ID verification
- Auction system uses simulated real-time updates (15-30s intervals)
- Payment/Escrow system with mock GCash/PayMaya/Bank transfers
- No backend yet - all data stored in-memory via mock services

---

Instructions for Claude:

1. Auto-detect project phase from version number:
   - v0.0.x → Prototype
   - v0.1.x-v0.4.x → Alpha
   - v0.5.x-v0.9.x → Beta ← CURRENT
   - v1.0.x → MVP
   - v1.x.x-v2.x.x → Growth
   - v3.x.x+ → Maturity

2. Apply phase-appropriate standards automatically from Section 1
3. Check platform requirements from Section 1.5 based on Target Platforms
4. Adjust "Definition of Done" based on current phase
5. Always check PROJECT_STRUCTURE.md first before starting work
6. Use templates from Section 2 for responses
7. Auto-generate semantic commits for each file (Section 3)
8. Auto-increment pubspec.yaml version after completing tasks in each prompt
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

Version Update Rules:
- After completing ALL tasks in user's prompt, update pubspec.yaml
- Determine version bump from highest-impact commit type made:
  - feat → Minor (+0.1.0)
  - fix/update/perf/build → Patch (+0.0.1)
  - feat!/BREAKING CHANGE → Major (+1.0.0)
  - docs/style/refactor/test/chore/ci → No version change
- If no version-impacting changes, skip version bump
- Update CLAUDE.md Section 0 "Current Version" after bumping

Export Reminders:
- After feature completion: "Ready to /export"
- After bug fixes: "Consider /export for history"
- End of session: "Remember to /export this session"

Commit Examples:
- feat: add OAuth2 authentication
- fix: resolve null pointer in user service
- update: upgrade flutter to 3.24.0
- perf: optimize list rendering with keys
- feat!: change API response format
- docs: add setup instructions
- test: add widget tests for login

Current Focus: Vehicle condition enhancement with custom attributes (Branch: nekolaiv/carlisting-enhancement)

---

Last Updated: 2025-10-12
Schema Version: 3.0