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
**Performance:** <50ms interact, <2s API, 60 FPS
**Security:** OWASP Top 10, encrypted storage
**Testing:** Unit + integration, beta feedback
**Docs:** User guides + API docs

### MVP/Production (v1.0.x+)
**Quality:** ≥80% cov, lint ✓, 0 warn
**Performance:** <16ms frames, <1s API, optimized assets
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

### Mobile (iOS/Android)
**UI:** Native feel, gestures, offline-first
**Performance:** <2s cold start, <200MB mem
**Assets:** 1x/2x/3x variants, <100KB (Beta)
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

### Multi-Platform
**UI:** Shared design system, platform adaptations
**Performance:** Meet strictest requirement
**Assets:** Platform-specific bundles
**Testing:** All platform test suites
**Distribution:** Coordinated releases

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

### Flutter/Dart
```bash
# Pre-release
flutter analyze
dart format .
flutter test --coverage
flutter build apk --release  # or web/windows

# Release
# Update version in pubspec.yaml
# Update CHANGELOG.md
git tag v[X.Y.Z]
git push origin v[X.Y.Z]
```

### JavaScript/Node.js
```bash
# Pre-release
npm run lint
npm run format
npm test
npm run build

# Release
npm version [major|minor|patch]
git push origin v[X.Y.Z]
```

### Python
```bash
# Pre-release
pylint src/
black .
pytest --cov
python setup.py build

# Release
# Update version in setup.py
git tag v[X.Y.Z]
git push origin v[X.Y.Z]
```

### Rust
```bash
# Pre-release
cargo clippy
cargo fmt
cargo test
cargo build --release

# Release
# Update version in Cargo.toml
git tag v[X.Y.Z]
git push origin v[X.Y.Z]
```

---

**File Version:** 3.1
**Last Updated:** 2025-10-12
