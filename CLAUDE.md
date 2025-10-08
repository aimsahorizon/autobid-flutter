# CLAUDE.md - AutoBID Project Memory

```markdown
# AutoBID Project Context

## Project Overview
**Name:** AutoBID - Online Car Auction Platform  
**Market:** Philippines  
**Platform:** Flutter (iOS, Android, Web)  
**Stage:** Student thesis project, MVP development  
**Approach:** Frontend-first with mock services, backend-implementable later

**Tech Stack:**
- Flutter + Riverpod 2.x + Freezed + go_router
- Firebase (planned for production)
- Mock services for demo
- Material Design 3, Green primary (#4CAF50)

## Core Features

### ✅ Implemented

**Authentication & KYC (v0.2.1)**
- 7-step mandatory registration with KYC
- Philippine National ID (primary) + secondary government ID required
- Selfie verification holding ID
- Complete address + phone verification
- KYC status tracking

**Car Listings (v0.3.0)**
- Multi-step listing creation (6 steps: Basic → Details → Documents → Condition → Photos → Review)
- My Listings with tabs: Active, Drafts, Sold, Cancelled
- CRUD operations (Create, Edit, Delete)
- Grid/List view toggle
- Image upload (5-15 photos required)
- 50+ car specification fields

**Browse & Search (v0.4.1)**
- 60+ filterable parameters:
  - Mechanical: Engine, transmission, fuel, drivetrain, horsepower
  - Dimensions: Seats, doors, weight, cargo capacity
  - Exterior: Color, paint type, rim size
  - Condition: Mileage, owners, accident/flood history
  - Safety: Airbags, ABS, cameras, assist systems
  - Technology: Infotainment, CarPlay, navigation
  - Location: City, province, region
- Advanced filter system with expandable sections
- Active filter chips (dismissible)
- Multiple sort options
- Search with debounce (300ms)
- Car detail view with image carousel + zoom
- Watchlist feature
- 25-30 mock cars with realistic PH data

**Auction System (v0.5.0)**
- Live bidding with real-time simulation (updates every 15-30 seconds)
- Auto-bid configuration (max amount + increment)
- Buy now option (optional per auction)
- Reserve price system (hidden from buyers)
- Auction watchlist (save without bidding)
- Bid history tracking (all bids per auction)
- My Bids dashboard with tabs:
  - Active: Current bidding auctions
  - Won: Successfully won auctions
  - Lost: Outbid/unsuccessful auctions
  - Watching: Watchlisted auctions
- Countdown timers (color-coded: green >1day, orange 1day-1hr, red <1hr)
- Bid status tracking: active, outbid, winning, won, lost
- Quick bid buttons (+₱1k, +₱5k, +₱10k, +₱20k)

### 🔄 In Progress

**Enhanced KYC - Phase 1 (v0.6.0)**
- Add Step 7: Proof of Address upload
  - Document types: Utility bill, bank statement, govt letter, rental contract, barangay certificate
  - Must be issued within 3 months
  - Address must match registration address
- Registration becomes 8 steps total
- Create verification level system:
  - Level 0 (Unverified): Browse only, ₱0 limits
  - Level 1 (Verified): ₱500k buy/sell limits (default after registration)
  - Level 2 (Enhanced): ₱2M buy/sell limits (upgrade later)
  - Level 3 (Premium): Unlimited (upgrade later)
  - Dealer: Unlimited selling (upgrade later)
- Verification Levels info screen (shows all levels + requirements)
- Update Profile screen:
  - Display current verification level badge
  - Show buy/sell limits
  - Trust badges: email✓, phone✓, ID✓, address✓
  - "Upgrade Verification" button
- Update User model: verificationLevel, verificationLimits, proofOfAddress fields

### ⏳ Planned

**Enhanced KYC - Phase 2 (v0.6.1): Vehicle Documentation & Limit Enforcement**
- VehicleDocuments model: OR/CR, emission test, deed of sale, vehicle photo with plate
- Add Step 4 to listing creation: Vehicle Documents upload (mandatory for sellers)
  - OR/CR number + image (front/back)
  - Emission test certificate + expiry date
  - Deed of sale (if not original owner)
  - Vehicle photo with visible plate number
- Listing creation becomes 7 steps: Basic → Details → Location → Vehicle Docs → Condition → Photos → Review
- VerificationLimitChecker service: Validate transactions against user's verification level
- Enforce limits in real-time:
  - Block bids exceeding buy limit → Show "Upgrade Required" dialog
  - Block listing prices exceeding sell limit → Show banner + disable publish
  - Display exact current limit, required level, upgrade path
- Car detail screen enhancements:
  - Display seller verification level badges
  - Show vehicle document verification status
  - Trust score indicators
- My Listings updates:
  - "Docs Pending" badges on listings awaiting verification
  - "Price Over Limit" warnings on drafts exceeding current sell limit
  - Disable publish if docs incomplete or over limit
- Vehicle docs status widget: ✓ Verified, ⏳ Pending, ✗ Rejected with reasons
- UpgradeVerificationDialog: Reusable modal (current level → required level → benefits)

**Enhanced KYC - Phase 3 (v0.6.2): Progressive Verification Upgrades**
- UpgradeApplication model: Track upgrade requests (pending, underReview, approved, rejected)
- User model extensions: level2Documents, level3Documents, dealerDocuments, upgradeApplications

**Level 2 Upgrade Flow (₱500k → ₱2M limits):**
- Multi-step form (4 steps):
  1. NBI Clearance upload (number, issue/expiry dates, within 6 months validity)
  2. TIN Verification (XXX-XXX-XXX-XXX format, 12 digits)
  3. Proof of Income (choose one):
     - ITR (Income Tax Return)
     - Certificate of Employment with salary
     - Bank statements (last 3 months)
     - Business registration + financial statements
  4. Review & Submit
- Auto-approve after 5 seconds (demo mode)
- Limits increase to ₱2M buy/sell upon approval

**Level 3 Upgrade Flow (₱2M → Unlimited):**
- Multi-step form (3 steps):
  1. Source of Funds Declaration:
     - Notarized affidavit upload
     - Source type: Employment, Business, Investment, Inheritance, Property Sale
     - Supporting documents matching source type
     - Amount range selection
  2. Video KYC Scheduling:
     - Calendar date/time picker
     - Preparation checklist (IDs ready, stable internet, quiet room)
     - Video call link sent via email (Zoom/Meet)
  3. Enhanced Background Check Consent:
     - Credit bureau check authorization
     - Watchlist screening consent
     - Reference verification consent
- Success: "Application Submitted! Video KYC scheduled for [date/time]"
- Auto-approve after 5 seconds (demo, skips actual video call)
- Unlimited buy/sell upon approval

**Dealer Upgrade Flow (Unlimited selling only):**
- Multi-step form (4 steps):
  1. Business Information:
     - Business name, type (Sole Proprietor/Partnership/Corporation)
     - DTI/SEC registration number + certificate upload
     - Date of registration
  2. Government Permits:
     - Mayor's Business Permit (upload + number + issue/expiry dates)
     - BIR Form 2303 upload
     - Business TIN
  3. LTO Dealer Registration (optional):
     - LTO dealer permit upload
     - Permit number
     - Surety bond details
  4. Business Address Verification:
     - Physical address (must match permits)
     - Storefront photo upload
     - Landline number, business hours
- Success: "Dealer Application Submitted! Site verification scheduled"
- Auto-approve after 5 seconds (demo)
- Unlimited selling, dealer badge upon approval

**Supporting Features for Phase 3:**
- Upgrade Status Screen: View pending applications, timeline, approval/rejection status
- Verification Levels Screen: "Upgrade" buttons navigate to respective upgrade flows
- Profile banner: "Upgrade In Progress" when application pending
- MockVerificationService: Handle submit/approve/reject upgrade applications
- DocumentUploadCard widget: Reusable component for all document uploads
- Notifications: Submitted, Under Review, Approved, Rejected alerts

**Payment & Escrow System (v0.7.0)**
- Transaction model: Escrow status tracking (pending, held, released, refunded, disputed)
- Payment methods: GCash, PayMaya, Bank Transfer, Cash on Pickup
- Payment screen: Select method, upload proof, submit payment
- Escrow flow:
  1. Winner pays → Escrow holds funds
  2. Seller ships vehicle
  3. Buyer confirms receipt → Escrow releases to seller
  4. Auto-release after 7 days if no dispute
- Transaction history: As Buyer, As Seller tabs
- Transaction detail: Timeline, payment proof, actions (confirm receipt, request refund)
- Platform fee calculation: 3% + ₱50
- Payment summary: Itemized breakdown (car price + fee = total)

**Notifications System (v0.7.1)**
- In-app notification center
- Push notifications (Firebase Cloud Messaging)
- Notification types:
  - Auction: Outbid, winning, won, lost, ending soon
  - Payment: Payment received, escrow held, released, refund processed
  - KYC: Approved, rejected, additional docs needed
  - Listing: Approved, rejected, sold
  - Messages: New message from buyer/seller
- Badge count on notification icon
- Mark as read/unread
- Clear all notifications

**Messaging/Chat System (v0.7.2)**
- In-app chat between buyers and sellers
- Chat list screen (conversations)
- Chat detail screen (messages)
- Send text messages
- Send images
- Typing indicators
- Read receipts
- Online/offline status
- Block/report user

**Ratings & Reviews (v0.8.0)**
- Rate seller after transaction (1-5 stars)
- Written review (optional, max 500 chars)
- Review categories: Communication, Accuracy, Condition, Process
- Display average rating on seller profile
- Review history on car detail page
- Flag inappropriate reviews
- Seller response to reviews

**Admin & Moderator Panel (v0.9.0)**

**Core Admin Features:**
- KYC Verification Dashboard:
  - Pending applications queue (FIFO)
  - Document viewer (zoom, side-by-side comparison)
  - Approve/Reject with reason field
  - Flag suspicious documents
  - Review history & audit trail
  - Average review time metrics, SLA tracking
- User Management:
  - Search users (name, email, phone, ID number)
  - View full user profile + all documents
  - Account actions: Suspend, Ban, Reinstate, Delete
  - Manual verification level override
  - View transaction history per user
  - Add internal notes/flags
- Listing Moderation:
  - Pending listings review queue
  - Vehicle document verification
  - Image quality validation
  - Approve/Reject/Request Changes
  - Flag duplicate/fake listings
  - Price reasonability check
- Auction Monitoring:
  - Live auctions dashboard (real-time view)
  - Suspicious bidding detection (shill bidding patterns)
  - Emergency auction suspension
  - Manual bid removal (fraud cases)
  - Auction dispute resolution
- Transaction Oversight:
  - All transactions list with filters
  - Escrow status monitoring
  - Payment verification review
  - Manual escrow release/refund
  - Transaction dispute handling
  - Fraud pattern detection
- Reports & Analytics:
  - User growth metrics
  - KYC approval rates & average times
  - Listing approval rates
  - Transaction volume & value
  - Platform fees collected
  - Fraud incidents tracking
  - Export to CSV/PDF
- System Settings:
  - Platform fee configuration
  - Verification level limits adjustment
  - Feature toggles (enable/disable features)
  - Maintenance mode
  - Email/SMS templates editor
- Audit Logs:
  - All admin/moderator actions logged
  - User action history
  - System changes tracking
  - Compliance reporting

**Core Moderator Features:**
- KYC review (same as admin)
- Listing moderation (same as admin)
- Auction monitoring (same as admin)
- Support ticket system:
  - User-submitted tickets queue
  - Ticket assignment & status tracking
  - Internal chat/notes
  - Response templates
  - SLA tracking
- Notifications & alerts:
  - Real-time alerts for urgent actions
  - Daily summary emails
  - Escalation system (24hr pending items)

**Analytics Dashboard (v1.0.0)**
- User metrics: Registrations, active users, retention
- Listing metrics: Total listings, approved/rejected rates
- Auction metrics: Total auctions, average bids, conversion rates
- Transaction metrics: Volume, value, payment methods breakdown
- Revenue metrics: Platform fees collected, projections
- Geographic distribution: Users by province/city
- Popular car brands/models
- Search analytics: Top keywords, filter usage
- Performance metrics: Average review times, response times
- Charts & graphs: Line, bar, pie charts with date range filters

**Future Enhancements (Post-Thesis)**
- AI price valuation (machine learning model for car pricing)
- LTO integration (real-time vehicle history check)
- Real payment gateway integration (PayMongo API)
- Real KYC verification APIs (NBI, BIR, LTO)
- SMS notifications (Twilio/Semaphore)
- Email service (SendGrid/AWS SES)
- Advanced fraud detection (ML-based patterns)
- Insurance integration (coverage options)
- Financing integration (loan calculators, bank partnerships)
- Logistics integration (vehicle delivery services)
- 3rd-party inspection services
- Gamification: Badges, achievements, loyalty rewards
- Premium dealer subscriptions
- Featured listings (paid promotion)
- Mobile app optimization
- Web app SEO optimization

Critical Code Standards
✅ ALWAYS Use
dart// Freezed models
abstract class ModelName with _$ModelName { }
// Color opacity
color.withValues(alpha: 0.5)

❌ NEVER Use
dart// Missing abstract keyword
class ModelName with _$ModelName { }
// Deprecated method
color.withOpacity(0.5)

File Structure
lib/presentation/screens/{feature}/
├── {feature}_screen.dart      // <250 lines
├── tabs/
│   └── {tab}_tab.dart
└── widgets/
    └── {widget}.dart
Development Constraints

Solo beginner developer
Self-funded, minimal budget (free tier services)
No hard timeline, iterative development
Keep files under 250 lines
Material 3, green theme
Mock services with instant/short delays

Communication Style

Concise, actionable only
No praise or unnecessary text
Focus on: tasks, explanations, code
Minimize tokens without omitting details

Philippine Context

Popular brands: Toyota, Honda, Mitsubishi, Nissan, Ford
Payment: GCash, PayMaya, bank transfer
IDs: National ID (primary), Driver's License, SSS, Passport
Agencies: LTO (vehicles), BIR (tax), NBI (clearance)
