# AutoBID - Project Structure

**Last Updated:** 2025-10-15
**Version:** 0.12.0+21
**Phase:** Beta Development

---

## 📁 Folder Tree

```
lib/
├── config/
│   └── app_config.dart
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── auction_durations.dart
│   │   ├── bid_increments.dart
│   │   ├── car_brands.dart
│   │   ├── car_features.dart
│   │   ├── color_constants.dart
│   │   ├── escrow_statuses.dart
│   │   ├── id_types.dart
│   │   ├── payment_methods.dart
│   │   ├── ph_cities.dart
│   │   ├── ph_locations.dart
│   │   ├── ph_provinces.dart
│   │   ├── price_ranges.dart
│   │   ├── proof_of_address_types.dart
│   │   ├── string_constants.dart
│   │   └── verification_levels.dart
│   ├── router/
│   │   └── app_router.dart
│   ├── theme/
│   │   └── app_theme.dart
│   ├── utils/
│   │   ├── bid_validator.dart
│   │   ├── car_enum_extensions.dart
│   │   ├── dev_autofill.dart
│   │   ├── distance_calculator.dart
│   │   ├── enum_extensions.dart
│   │   ├── escrow_rules.dart
│   │   ├── fee_calculator.dart
│   │   ├── listing_autofill_helpers.dart
│   │   ├── listing_status_extensions.dart
│   │   ├── price_formatter.dart
│   │   ├── time_formatter.dart
│   │   └── validators.dart
│   └── validators/
│       └── car_image_validator.dart
├── data/
│   ├── models/
│   │   ├── auction_model.dart
│   │   ├── auto_bid_config.dart
│   │   ├── bid_model.dart
│   │   ├── car_image_category.dart
│   │   ├── car_model.dart
│   │   ├── dispute_model.dart
│   │   ├── kyc_model.dart
│   │   ├── kyc_model_new.dart
│   │   ├── notification_model.dart
│   │   ├── payment_method.dart
│   │   ├── pricing_config.dart
│   │   ├── required_car_images.dart
│   │   ├── review_model.dart
│   │   ├── search_filters.dart
│   │   ├── transaction_model.dart
│   │   ├── transaction_timeline.dart
│   │   ├── transfer_evidence_model.dart
│   │   ├── user_model.dart
│   │   ├── vehicle_condition_attribute.dart
│   │   └── verification_level_model.dart
│   ├── repositories/
│   │   └── auth_repository.dart
│   └── services/
│       ├── local/
│       │   └── local_storage_service.dart
│       ├── mock/
│       │   ├── mock_auction_service.dart
│       │   ├── mock_auth_service.dart
│       │   ├── mock_car_service.dart
│       │   ├── mock_kyc_service.dart
│       │   ├── mock_notification_service.dart
│       │   ├── mock_otp_service.dart
│       │   ├── mock_payment_service.dart
│       │   └── mock_review_service.dart
│       └── mock_vehicle_conditions_service.dart
├── domain/
│   ├── entities/
│   ├── repositories/
│   │   └── auction_repository.dart
│   ├── services/
│   │   └── pricing_calculator.dart
│   └── use_cases/
├── presentation/
│   ├── providers/
│   │   ├── auction_provider.dart
│   │   ├── auth_provider.dart
│   │   ├── bid_provider.dart
│   │   ├── browse_provider.dart
│   │   ├── kyc_provider.dart
│   │   ├── listing_provider.dart
│   │   ├── notification_provider.dart
│   │   ├── payment_provider.dart
│   │   ├── signup_provider.dart
│   │   ├── theme_provider.dart
│   │   ├── transaction_provider.dart
│   │   └── watchlist_provider.dart
│   ├── screens/
│   │   ├── auction/
│   │   │   ├── auction_detail_screen.dart
│   │   │   ├── tabs/
│   │   │   │   ├── bid_history_tab.dart
│   │   │   │   └── car_info_tab.dart
│   │   │   └── widgets/
│   │   │       ├── auto_bid_dialog.dart
│   │   │       ├── bid_history_item.dart
│   │   │       ├── bid_input_widget.dart
│   │   │       ├── car_image_gallery.dart
│   │   │       ├── categorized_image_gallery.dart
│   │   │       ├── countdown_timer.dart
│   │   │       ├── current_bid_card.dart
│   │   │       └── fullscreen_image_viewer.dart
│   │   ├── admin/
│   │   │   └── admin_debug_panel.dart
│   │   ├── auth/
│   │   │   ├── dual_otp_verification_screen.dart
│   │   │   ├── entry_screen.dart
│   │   │   ├── forgot_password_screen.dart
│   │   │   ├── login_screen.dart
│   │   │   ├── otp_verification_screen.dart
│   │   │   ├── reset_password_screen.dart
│   │   │   ├── signup_screen.dart
│   │   │   └── signup/
│   │   │       ├── signup_step_mixin.dart
│   │   │       ├── signup_step1_account.dart
│   │   │       ├── signup_step2_otp.dart
│   │   │       ├── signup_step2_personal.dart
│   │   │       ├── signup_step3_address.dart
│   │   │       ├── signup_step4_primary_id.dart
│   │   │       ├── signup_step5_secondary_id.dart
│   │   │       ├── signup_step6_selfie.dart
│   │   │       ├── signup_step7_proof_address.dart
│   │   │       ├── signup_step8_review.dart
│   │   │       └── signup_success_screen.dart
│   │   ├── browse/
│   │   │   ├── auction_filter_bottom_sheet.dart
│   │   │   ├── browse_cars_screen.dart
│   │   │   ├── car_detail_screen.dart
│   │   │   ├── filter_bottom_sheet.dart
│   │   │   └── search_screen.dart
│   │   ├── guest/
│   │   │   ├── guest_view_screen.dart
│   │   │   ├── tabs/
│   │   │   │   ├── account_tab.dart
│   │   │   │   └── browse_tab.dart
│   │   │   └── widgets/
│   │   │       └── account_status_card.dart
│   │   ├── home/
│   │   │   ├── home_screen.dart
│   │   │   ├── tabs/
│   │   │   │   ├── browse_tab.dart
│   │   │   │   ├── my_bids_tab.dart
│   │   │   │   ├── my_listings_tab.dart
│   │   │   │   ├── profile_tab.dart
│   │   │   │   └── watchlist_tab.dart
│   │   │   └── widgets/
│   │   │       ├── profile_action_button.dart
│   │   │       ├── profile_info_tile.dart
│   │   │       └── profile_stat_item.dart
│   │   ├── kyc/
│   │   │   ├── kyc_intro_screen.dart
│   │   │   ├── kyc_status_screen.dart
│   │   │   └── kyc_upload_screen.dart
│   │   ├── listings/
│   │   │   ├── car_detail_screen.dart
│   │   │   ├── create/
│   │   │   │   ├── create_listing_step1_basic.dart
│   │   │   │   ├── create_listing_step2_details.dart
│   │   │   │   ├── create_listing_step2_mechanical.dart
│   │   │   │   ├── create_listing_step3_dimensions.dart
│   │   │   │   ├── create_listing_step3_documents.dart
│   │   │   │   ├── create_listing_step4_condition.dart
│   │   │   │   ├── create_listing_step4_exterior.dart
│   │   │   │   ├── create_listing_step5_condition.dart
│   │   │   │   ├── create_listing_step5_photos.dart
│   │   │   │   ├── create_listing_step6_documentation.dart
│   │   │   │   ├── create_listing_step6_review.dart
│   │   │   │   ├── create_listing_step7_photos.dart
│   │   │   │   ├── create_listing_step8_review.dart
│   │   │   │   ├── create_listing_step9_summary.dart
│   │   │   │   ├── listing_success_screen.dart
│   │   │   │   └── widgets/
│   │   │   │       └── auction_settings_dialog.dart
│   │   │   └── my_listings/
│   │   │       └── pending_listings_screen.dart
│   │   ├── notifications/
│   │   │   └── notifications_screen.dart
│   │   ├── payment/
│   │   │   ├── payment_screen.dart
│   │   │   ├── transactions_screen.dart
│   │   │   ├── tabs/
│   │   │   │   ├── payment_history_tab.dart
│   │   │   │   └── payment_method_tab.dart
│   │   │   └── widgets/
│   │   │       ├── escrow_status_card.dart
│   │   │       ├── payment_method_card.dart
│   │   │       ├── payment_summary.dart
│   │   │       └── transaction_item.dart
│   │   ├── profile/
│   │   │   ├── edit_profile_screen.dart
│   │   │   ├── help_support_screen.dart
│   │   │   ├── profile_screen.dart
│   │   │   └── security_settings_screen.dart
│   │   ├── review/
│   │   │   ├── seller_reviews_screen.dart
│   │   │   └── submit_review_screen.dart
│   │   ├── splash/
│   │   │   └── splash_screen.dart
│   │   ├── transaction/
│   │   │   ├── request_refund_screen.dart
│   │   │   ├── submit_transfer_evidence_screen.dart
│   │   │   ├── transaction_detail_screen.dart
│   │   │   └── widgets/
│   │   │       ├── escrow_info_card.dart
│   │   │       └── timeline_widget.dart
│   │   └── verification/
│   │       └── verification_levels_screen.dart
│   └── widgets/
│       ├── active_bid_card.dart
│       ├── auction_card.dart
│       ├── cached_car_image.dart
│       ├── car_card.dart
│       ├── condition_category_section.dart
│       ├── condition_toggle.dart
│       ├── counter_input_field.dart
│       ├── creatable_dropdown.dart
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       ├── date_picker_field.dart
│       ├── filter_widgets.dart
│       ├── image_carousel.dart
│       ├── image_upload_card.dart
│       ├── kyc_status_badge.dart
│       ├── listing_status_badge.dart
│       ├── loading_indicator.dart
│       ├── number_input_field.dart
│       ├── payment/
│       │   ├── mock_card_input.dart
│       │   ├── mock_payment_sheet.dart
│       │   └── test_cards_info.dart
│       ├── reviews/
│       │   ├── rating_badge.dart
│       │   ├── rating_breakdown.dart
│       │   └── review_card.dart
│       ├── save_draft_button.dart
│       ├── seller_info_card.dart
│       ├── signup_stepper.dart
│       ├── spec_info_row.dart
│       └── trust_badges.dart
└── main.dart
```

---

## 📊 Feature Matrix

| Feature | Status | Version | Branch | Notes |
|---------|--------|---------|--------|-------|
| Authentication (Basic) | ✅ Complete | 0.2.0 | main | Login/Signup |
| OTP-Based Auth | 🔄 In Progress | 0.12.0 | nekolaiv/enhance-auth | OTP login/register/reset, Guest mode |
| Signup Flow Enhancement | 🔄 In Progress | 0.12.0 | nekolaiv/enhance-auth | Back navigation, autofill, warnings |
| KYC System | ✅ Complete | 0.2.1 | main | 8-step verification |
| Car Listings | ✅ Complete | 0.3.0 | main | CRUD operations |
| Browse & Search | ✅ Complete | 0.4.1 | main | 60+ filters |
| Auction System | ✅ Complete | 0.5.0 | main | Live bidding, auto-bid |
| Enhanced KYC Phase 1 | ✅ Complete | 0.6.0 | main | Verification levels, proof of address |
| Payment & Escrow | ✅ Complete | 0.7.0 | main | Multiple payment methods |
| Notifications | ✅ Complete | 0.7.1 | main | In-app notifications |
| Ratings & Reviews | ✅ Complete | 0.8.0 | main | Seller reviews |
| Vehicle Condition Enhancement | 🔄 In Progress | 0.8.3 | nekolaiv/carlisting-enhancement | Custom attributes |
| Enhanced KYC Phase 2 | ⏳ Planned | 0.6.1 | - | Vehicle docs, limit enforcement |
| Enhanced KYC Phase 3 | ⏳ Planned | 0.6.2 | - | Progressive upgrades |
| Messaging/Chat | ⏳ Planned | 0.7.2 | - | In-app chat |
| Admin Panel | ⏳ Planned | 0.9.0 | - | Moderation dashboard |
| Analytics | ⏳ Planned | 1.0.0 | - | Metrics & reports |

**Legend:**
✅ Complete | 🔄 In Progress | ⏳ Planned | 🐛 Bug | 🔥 Critical

---

## 🔧 Tech Debt Log

| Priority | Issue | Impact | File(s) | Created |
|----------|-------|--------|---------|---------|
| P1 | Duplicate KYC models | Confusion, maintenance burden | kyc_model.dart, kyc_model_new.dart | 2025-10-12 |
| P2 | Multiple listing step files | Unclear flow, duplicate code | create_listing_step*.dart | 2025-10-12 |
| P2 | Mock services hardcoded delays | Testing difficulty | mock_*_service.dart | 2025-10-12 |
| P3 | No error logging service | Hard to debug production issues | All screens | 2025-10-12 |
| P3 | Image caching strategy | Performance concerns | Image-heavy screens | 2025-10-12 |

**Priorities:**
P0 = Critical (blocks release) | P1 = High (fix soon) | P2 = Medium (next sprint) | P3 = Low (backlog)

---

## ⚡ Performance Baseline

| Metric | Target | Current | Status | Notes |
|--------|--------|---------|--------|-------|
| App Startup | <2s | ~1.8s | ✅ Pass | Cold start on mid-range device |
| Frame Rate | 60 FPS | 55-60 FPS | ⚠️ Monitor | Drops on image-heavy screens |
| Build Time | <30s | ~25s | ✅ Pass | Debug build on dev machine |
| Memory Usage | <200MB | ~150MB | ✅ Pass | Average during normal use |
| Bundle Size | <50MB | TBD | ⏳ Todo | Not measured yet |
| API Response | <2s | <500ms | ✅ Pass | Mock services (instant) |

**Last Profiled:** Not yet measured (manual estimates)
**Device:** Mid-range Android (estimate)

---

## 📦 Dependency Map

| Package | Version | Last Updated | Purpose | Status |
|---------|---------|--------------|---------|--------|
| flutter_riverpod | 3.0.1 | 2025-10-12 | State management | ✅ Latest |
| riverpod_annotation | 3.0.1 | 2025-10-12 | Code generation | ✅ Latest |
| go_router | 16.2.4 | 2025-10-12 | Navigation | ✅ Latest |
| google_fonts | 6.1.0 | 2025-10-12 | Typography | ✅ Latest |
| firebase_core | 4.1.1 | 2025-10-12 | Firebase init | ✅ Latest |
| firebase_auth | 6.1.0 | 2025-10-12 | Authentication | ✅ Latest |
| cloud_firestore | 6.0.2 | 2025-10-12 | Database | ✅ Latest |
| google_sign_in | 7.2.0 | 2025-10-12 | Google auth | ✅ Latest |
| image_picker | 1.0.4 | 2025-10-12 | Image selection | ✅ Latest |
| cached_network_image | 3.4.1 | 2025-10-12 | Image caching | ✅ Latest |
| intl | 0.20.2 | 2025-10-12 | Internationalization | ✅ Latest |
| uuid | 4.2.1 | 2025-10-12 | UUID generation | ✅ Latest |
| provider | 6.1.1 | 2025-10-12 | Legacy state mgmt | ⚠️ Review |
| freezed | 3.0.0 | 2025-10-12 | Immutable models | ✅ Latest |
| json_serializable | 6.7.1 | 2025-10-12 | JSON serialization | ✅ Latest |

**Status:**
✅ Latest | ⚠️ Review (consider removing/updating) | 🔴 Outdated

**Notes:**
- `provider` package used alongside `flutter_riverpod` - consider migrating fully to Riverpod
- All Firebase packages ready but currently using mock services

---

## 📈 Project Statistics

- **Total Dart Files:** 240+ (including generated)
- **Total Models:** 18 (with Freezed generation)
- **Total Screens:** 70+
- **Total Providers:** 12
- **Total Services:** 9 mock + 1 local = 10 total
- **Lines of Code:** ~17,000+ (estimate)

---

## 🎯 Current Focus

**Branch:** nekolaiv/enhance-auth
**Task:** OTP-based authentication system + Signup flow enhancements
**Status:** In progress - Testing & refinement
**Recent Work:**
1. ✅ OTP authentication system (login, register, forgot password)
2. ✅ Admin Debug Panel for KYC testing
3. ✅ Entry/Welcome screen with guest mode
4. 🔄 Signup flow refinements (back navigation, warnings)
5. 🔄 Enhanced signup steps with autofill and validation
**Pending:**
1. Final testing of all auth flows
2. Integration testing with signup → KYC flow
3. Documentation updates
4. Code review and cleanup

---

## 📝 Notes

- **Architecture:** Clean Architecture (Presentation → Domain → Data)
- **State Management:** Riverpod + Provider (hybrid, migrating to Riverpod)
- **Code Generation:** Freezed, JSON Serializable, Riverpod Generator
- **Design System:** Material Design 3, Green primary theme (#4CAF50)
- **Target Market:** Philippines
- **Development Stage:** Student thesis project, Beta phase
- **Mock Data:** All services use mock implementations for demo purposes

---

## 📚 Documentation Structure

**Core Documentation:**
- **CLAUDE.md** - Optimized core instructions (always loaded)
- **CLAUDE_PHASES.md** - All phase standards & platform requirements
- **CLAUDE_WORKFLOW.md** - Templates, patterns, commands & project notes
- **PROJECT_STRUCTURE.md** - This file (folder tree, features, tech debt)

**Archives:**
- **CLAUDE_v3.0_FULL.md** - Full v3.0 before optimization
- **CLAUDE_TEMPLATE.md** - Universal template for any project

**Usage:** Claude auto-reads extended docs when triggered (see CLAUDE.md Section 3)

---

*This file is auto-maintained by Claude. Last schema version: 1.1*
