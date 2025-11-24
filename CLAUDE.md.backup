CLAUDE.md - Optimized Engineering Standards v2.0

0. Project Context [Auto-Updated]
Project: AutoBID - Online Reused Car Auction
Type: Mobile App
Phase: MVP Development
Stack: Flutter 3.9.2, Riverpod 3.0.1, Firebase (planned), Mock Services
Current Version: 0.8.3+11
Last Updated: 2025-10-12

---

1. Engineering Standards
- Architecture: Clean (Presentation→Domain→Data), SOLID, DRY, KISS
- Code: Null-safe, immutable, testable, no deprecated APIs
- Quality: ≥80% coverage, lint-clean, <16ms frames, <2s API
- Security: OWASP Mobile, TLS, secure storage, no hardcoded secrets
- Access: WCAG 2.1 AA, i18n via ARB, responsive design
- Dependencies: Verified packages only, regular security audits

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

9. Release Checklist

pre_release:
- lint: dart analyze
- format: dart format .
- test: flutter test --coverage
- build: flutter build apk --release

release:
- version: bump in pubspec.yaml
- changelog: update with changes
- tag: git tag v[X.Y.Z]
- branch: merge to main

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
1. Always check PROJECT_STRUCTURE.md first
2. Use templates for responses
3. Auto-generate semantic commits for each file
4. Auto-increment pubspec.yaml version after completing tasks in each prompt
5. Auto-update CLAUDE.md Section 0 on changes
6. Remind user to /export conversation after major work
7. Update Project-Specific Notes from learnings
8. Maintain single source of truth
9. Optimize for production deployment
10. Never explain unless asked
11. Focus on deliverables only
12. Follow conventional commit format strictly
13. One atomic commit per logical change

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
Schema Version: 2.0