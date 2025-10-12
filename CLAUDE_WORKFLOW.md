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
update: upgrade Flutter to 3.24.0
perf: optimize list rendering with keys
feat!: redesign API response format
docs: add deployment guide
test: add integration tests for payment
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

**@verify**
```bash
flutter analyze
flutter test --coverage
```

**@profile**
- Check FPS (60 target)
- Measure startup time
- Memory usage analysis
- API response times

**@deps**
```bash
flutter pub outdated
# Review security advisories
```

**@export**
- Generate PR summary
- List all commits since branch creation
- Show files changed
- Include test results

**@next**
- Check PROJECT_STRUCTURE.md tech debt
- Review current phase checklist progress
- Suggest next priority task

**@commit**
- Analyze all changed files
- Generate semantic commits for each
- Group related changes
- Determine version bump

**@update-context**
- Update CLAUDE.md Section 0
- Refresh version from pubspec.yaml
- Update last updated timestamp

---

## 6. Code Patterns

### State Management (Riverpod)
```dart
@riverpod
class FeatureController extends _$FeatureController {
  @override
  FutureOr<State> build() => repository.fetch();
}
```

### Repository Pattern
```dart
// Domain - abstraction
abstract class IRepository {
  Future<Entity> fetch(String id);
}

// Data - implementation
class RepositoryImpl implements IRepository {
  @override
  Future<Entity> fetch(String id) async {
    // API/Cache logic
  }
}
```

### Error Handling
```dart
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
```

### Freezed Models
```dart
@freezed
abstract class ModelName with _$ModelName {
  const factory ModelName({
    required String id,
    required String name,
  }) = _ModelName;

  factory ModelName.fromJson(Map<String, dynamic> json) =>
      _$ModelNameFromJson(json);
}
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

### UI/Frontend
- [ ] Widget rebuilds minimized (const)
- [ ] Images optimized (<100KB Beta, format appropriate)
- [ ] Lazy loading implemented
- [ ] Memory leaks checked (dispose)
- [ ] Network calls cached
- [ ] Animations 60 FPS

### Backend/API (if applicable)
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
- Current version (pubspec.yaml)
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
   flutter clean
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
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

### Beta (Current)
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
- Freezed models with abstract class keyword for immutability
- Mock services with realistic delays (instant to 2s) for demo
- Multi-step flows: 8-step KYC, 6-step listing creation, 7-step auction
- Philippine-specific data: locations, payment methods, government IDs
- Material Design 3 with green primary theme (#4CAF50)
- Grid/List view toggles for browsing
- Countdown timers with color-coded urgency (green/orange/red)

### User Preferences
- Prefers concise responses, minimal explanations
- Wants atomic commits per file with semantic versioning
- Expects auto-updates to PROJECT_STRUCTURE.md and CLAUDE.md
- Uses mock services for thesis demo (Firebase integration planned later)
- Solo developer, beginner-friendly approaches preferred

### Technical Decisions
- Hybrid state management: Riverpod + Provider (migrating to full Riverpod)
- Clean Architecture enforced (Presentation → Domain → Data layers)
- All models use Freezed + JSON serialization
- Mock services return realistic Philippine market data
- KYC system requires 8 steps with government ID verification
- Auction system uses simulated real-time updates (15-30s intervals)
- Payment/Escrow system with mock GCash/PayMaya/Bank transfers
- No backend yet - all data stored in-memory via mock services

### API Endpoints (Mock)
- Authentication: MockAuthService
- KYC: MockKycService
- Car Listings: MockCarService
- Auctions: MockAuctionService
- Payments: MockPaymentService
- Notifications: MockNotificationService
- Reviews: MockReviewService

### Performance Baseline
- App Startup: ~1.8s cold (target <2s)
- Frame Rate: 55-60 FPS (target 60)
- Build Time: ~25s debug (target <30s)
- Memory: ~150MB average (target <200MB)

---

**File Version:** 3.1
**Last Updated:** 2025-10-12
