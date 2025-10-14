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

## 13. Freezed Code Generation [AUTOMATED]

**CRITICAL: Run AUTOMATICALLY after ANY Freezed model modification**

### Detection Rules
Auto-run `build_runner` when:
- ✅ Any file with `@freezed` annotation is modified
- ✅ Fields added/removed/renamed in Freezed model
- ✅ Enum values added to model-related enums
- ✅ Model file imports change (affects serialization)
- ❌ SKIP if only `.freezed.dart` or `.g.dart` files modified (already generated)
- ❌ SKIP if non-model files modified (services, widgets, etc.)

### Execution Workflow

**Step 1: Detect Changes**
```dart
// Look for files containing:
@freezed
abstract class ModelName with _$ModelName {
  // If THIS file was just modified → proceed to Step 2
}
```

**Step 2: Run Build Runner**
```bash
# Try with dart first (faster if available)
dart run build_runner build --delete-conflicting-outputs

# Fallback to flutter if dart fails
flutter pub run build_runner build --delete-conflicting-outputs

# Timeout: 120 seconds
```

**Step 3: Verify Success**
Check that for each modified model file (`model_name.dart`):
- ✅ `model_name.freezed.dart` exists
- ✅ `model_name.g.dart` exists
- ✅ Both files have matching field count
- ✅ No compilation errors in generated files

**Step 4: Handle Failures**

If `build_runner` fails:
1. **Check error type:**
   - `Flutter not found` → Use `fix_freezed.bat` script
   - `Conflicting outputs` → Already handled by `--delete-conflicting-outputs`
   - `Missing dependencies` → Run `flutter pub get` first
   - `Syntax errors` → Fix source model file first

2. **Fallback options (in order):**
   ```bash
   # Option A: Use project script
   fix_freezed.bat

   # Option B: Manual regeneration
   flutter clean
   flutter pub get
   dart run build_runner build --delete-conflicting-outputs

   # Option C: Manual file fix (last resort)
   # Edit .freezed.dart and .g.dart directly
   ```

3. **Report to user:**
   ```
   ⚠️ Freezed regeneration failed
   Error: [specific error]
   Attempted: [command used]
   Next: [suggested fix]
   ```

### Integration with Workflow

**BEFORE completing task:**
```
1. Complete model modifications
2. → AUTO-RUN: build_runner
3. → VERIFY: Generated files updated
4. → ONLY THEN: Mark task complete
```

**Example Trigger:**
```dart
// User edits: lib/data/models/user_model.dart
// Claude detects: @freezed annotation present
// Claude runs: dart run build_runner build --delete-conflicting-outputs
// Claude verifies: user_model.freezed.dart and user_model.g.dart updated
// Claude continues: with original task
```

### Prevention Checklist

Before modifying ANY Freezed model:
- [ ] Confirm `part 'model_name.freezed.dart';` exists
- [ ] Confirm `part 'model_name.g.dart';` exists
- [ ] Plan to run `build_runner` immediately after changes
- [ ] Reserve 30-60s for regeneration time

After modifying ANY Freezed model:
- [ ] Run `build_runner` (automated)
- [ ] Check for errors in generated files
- [ ] Verify all new fields appear in generated code
- [ ] Run `flutter analyze` to catch issues

### Common Issues

**Issue:** "The named parameter 'fieldName' isn't defined"
**Cause:** Generated files out of sync
**Fix:** Re-run `build_runner`

**Issue:** "Missing required parameters"
**Cause:** New field added but not regenerated
**Fix:** Re-run `build_runner`

**Issue:** "Type 'X' not found"
**Cause:** Missing import or enum not regenerated
**Fix:** Check imports, then re-run `build_runner`

### Performance Notes
- Regeneration takes 15-45s typically
- Run ONCE after ALL model changes (batch edits)
- Use `--delete-conflicting-outputs` to avoid stale files
- Consider `watch` mode for rapid iteration:
  ```bash
  dart run build_runner watch --delete-conflicting-outputs
  ```

---

## 14. Error Resolution Protocol [AUTOMATED - CRITICAL]

**MANDATORY: Resolve ALL RED errors before completing ANY task**

### Error Severity Levels (VS Code Problems Panel)

| Color | Severity | Priority | Action Required |
|-------|----------|----------|-----------------|
| 🔴 **RED** | Error | **CRITICAL** | **MUST FIX - Blocking** |
| 🟡 **YELLOW** | Warning | Medium | Fix if time permits |
| 🔵 **BLUE** | Info | Low | Ignore unless requested |

### Detection & Resolution Workflow

**Step 1: Detect Errors**
```bash
# Run after EVERY code change
flutter analyze

# Or check IDE Problems panel
# RED errors = blocking compilation
```

**Step 2: Categorize Errors**

**Common RED Error Types:**
1. **Undefined reference** - Missing import, typo, or undefined variable
   - Example: `'accountStatus' isn't defined`
   - Fix: Add import, regenerate code, or define variable

2. **Type mismatch** - Wrong type passed to function/constructor
   - Example: `String can't be assigned to int`
   - Fix: Cast, convert, or use correct type

3. **Missing parameter** - Required parameter not provided
   - Example: `The named parameter 'id' is required`
   - Fix: Add parameter to constructor call

4. **Syntax error** - Invalid Dart syntax
   - Example: `Expected to find ')'`
   - Fix: Check brackets, semicolons, commas

5. **Import error** - Cannot resolve import
   - Example: `Target of URI doesn't exist`
   - Fix: Check path, run `flutter pub get`

6. **Freezed out of sync** - Generated files stale
   - Example: `Named parameter 'field' isn't defined`
   - Fix: Run `build_runner`

**Step 3: Fix Each Error**

**Resolution Priority Order:**
1. **Fix root cause errors first** (cascading failures)
   - Missing imports → affects multiple files
   - Freezed regeneration → affects all model usages
   - Syntax errors → prevents compilation

2. **Fix dependent errors** (caused by root issues)
   - Undefined references after imports fixed
   - Type mismatches after regeneration

3. **Verify fix** after each change
   ```bash
   flutter analyze
   # Count should decrease
   ```

**Step 4: Verify All Clear**
```bash
# Run final check
flutter analyze

# Expected output:
Analyzing project...
No issues found!

# If any RED errors remain → CONTINUE FIXING
# NEVER mark task complete with RED errors
```

### Automated Resolution Rules

**Rule 1: NEVER COMPLETE TASK WITH RED ERRORS**
```
❌ WRONG:
User: "Add new field to model"
Claude: "Field added! ✓" [but 5 RED errors exist]

✅ CORRECT:
User: "Add new field to model"
Claude: [Adds field]
Claude: [Detects RED errors]
Claude: [Regenerates Freezed]
Claude: [Verifies 0 RED errors]
Claude: "Field added and verified! ✓"
```

**Rule 2: AUTO-FIX BEFORE REPORTING**
```
Do NOT say: "I've made the changes. Please run build_runner."
Instead DO: Run build_runner → Fix errors → Report "Changes complete, 0 errors"
```

**Rule 3: PERSISTENT ERROR RESOLUTION**
```dart
// Loop until all RED errors resolved
while (redErrors > 0) {
  analyzeCode();
  identifyErrors();
  fixErrors();
  verifyFix();
}
// Only then mark task complete
```

### Common Error Patterns & Solutions

#### Pattern 1: Freezed Model Changes
**Symptoms:**
- "The named parameter 'X' isn't defined"
- "The getter 'X' isn't defined for type 'Model'"

**Solution:**
```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze
```

#### Pattern 2: Missing Imports
**Symptoms:**
- "Undefined class 'ClassName'"
- "Undefined name 'function'"

**Solution:**
```dart
// Add missing import at top of file
import 'package:project/path/to/class.dart';
```

#### Pattern 3: Null Safety Violations
**Symptoms:**
- "A value of type 'Type?' can't be assigned to 'Type'"
- "The property 'field' can't be unconditionally accessed"

**Solution:**
```dart
// Add null check
if (value != null) { use(value); }

// Or use null-aware operator
value?.method();

// Or provide default
final result = value ?? defaultValue;
```

#### Pattern 4: Async/Await Missing
**Symptoms:**
- "The await expression can only be used in an async function"
- "A value of type 'Future<T>' can't be returned"

**Solution:**
```dart
// Add async keyword
Future<void> functionName() async {
  await asyncOperation();
}
```

#### Pattern 5: Const Constructor Issues
**Symptoms:**
- "Cannot invoke a non-'const' constructor"
- "The expression is not a constant expression"

**Solution:**
```dart
// Add const keyword
const Widget(
  child: const Text('Hello'),
)

// Or remove const from parent
Widget(
  child: Text('Hello'),
)
```

### Error Resolution Checklist

**Before completing ANY task:**
- [ ] Run `flutter analyze`
- [ ] Count RED errors (must be 0)
- [ ] If RED errors > 0:
  - [ ] Identify error type
  - [ ] Apply appropriate fix
  - [ ] Re-run `flutter analyze`
  - [ ] Repeat until 0 RED errors
- [ ] YELLOW warnings < 5 (ideal)
- [ ] BLUE info ignored (unless relevant)
- [ ] Code compiles successfully
- [ ] ONLY THEN mark task complete

### Reporting Format

**When errors are found and fixed:**
```
⚠️ Detected 3 RED errors after changes
Fixed:
  1. ✓ Regenerated Freezed files (user_model)
  2. ✓ Added missing import (AccountStatus enum)
  3. ✓ Updated constructor calls (5 files)

Verified: flutter analyze
Result: 0 RED errors, 2 YELLOW warnings

✅ Task complete
```

**If errors persist:**
```
⚠️ Unable to resolve 2 RED errors:
  1. lib/path/file.dart:45 - [error description]
  2. lib/path/file.dart:67 - [error description]

Attempted fixes:
  - [what was tried]
  - [what was tried]

Recommendation: [next steps]
```

### Integration with Main Workflow

**Modified Task Completion Flow:**
```
1. Receive user request
2. Analyze requirements
3. Make code changes
4. → Run flutter analyze (AUTO)
5. → If RED errors detected:
     a. Identify errors
     b. Fix ALL RED errors
     c. Re-analyze
     d. Loop until 0 RED
6. → Verify 0 RED errors
7. Complete other post-task checks
8. Report to user
```

**CRITICAL: Step 5-6 BLOCKS task completion**

### Performance Considerations

**Optimization Tips:**
- Run `flutter analyze` once after ALL changes (not per file)
- Group related fixes (e.g., all Freezed regenerations together)
- Fix root causes first (reduces cascading errors)
- Cache analyze results for 30s (avoid redundant runs)

**Typical Error Resolution Times:**
- Freezed regeneration: 30-60s
- Import fixes: 5-10s per file
- Type fixes: 10-30s per error
- Syntax fixes: Instant
- **Total budget: 2-5 minutes** for typical error batch

---

**File Version:** 3.3
**Last Updated:** 2025-10-14
