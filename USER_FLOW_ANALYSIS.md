# AutoBID - User Flow Analysis (Revenue Model Integrated)

**Generated:** 2025-10-22
**Version:** 0.13.0+22
**Purpose:** Clear user journey mapping for dataflow diagram revision
**Focus:** User actions, screens, and subscription-based access control

---

## SUBSCRIPTION TIERS & ACCESS CONTROL

### Tier 1: Free Tier (₱0)
- **Access:** Browse auctions, place bids (requires ₱10,000 refundable deposit)
- **Limits:**
  - Max 3 active bids
  - Max 1 active listing
  - No premium fee discount
  - No priority notifications
  - No badge
- **Deposit:** ₱10,000 refundable (required before first bid)

### Tier 2: Pro Basic (₱199/month or ₱1,999/year)
- **Access:** Unlimited active bids, 2x listing exposure
- **Benefits:**
  - 0.5% discount on Buyer's Premium
  - Priority bid notifications (push & in-app)
  - "Pro Basic" badge on profile and listings
  - Monthly summary reports
  - Early access to low-to-medium value auctions
- **No Deposit Required**

### Tier 3: Pro Plus (₱499/month or ₱4,999/year)
- **Access:** Unlimited active bids, featured placement, waived re-list fee
- **Benefits:**
  - 1.0% discount on Buyer's Premium
  - Early access to high-demand listings (2 hours early)
  - "Pro Plus" badge (premium)
  - Featured listing placement
  - Waived re-list fee
  - Advanced analytics
- **No Deposit Required**

---

## USER FLOW 1: NEW USER REGISTRATION & KYC

### Step-by-Step Journey

```
[START] User opens app
    ↓
SPLASH SCREEN (3 seconds)
    ↓
First-time user? → ONBOARDING SLIDES (3-5 screens explaining AutoBID)
    ↓
ENTRY SCREEN
    ├─ [Login] → Go to Flow 2
    └─ [Sign Up] → Continue below
         ↓
SIGNUP STEP 1: ACCOUNT SETUP
    - Enter email
    - Create password
    - Enter phone number
    - Accept Terms & Conditions
    - Accept Privacy Policy
    ↓
SIGNUP STEP 2: PERSONAL INFO
    - Enter first name, middle name, last name
    - Select date of birth
    - Select gender
    ↓
SIGNUP STEP 3: ADDRESS
    - Select region
    - Select province (filtered by region)
    - Select city (filtered by province)
    - Select barangay (filtered by city)
    - Enter street address
    - Enter ZIP code
    ↓
SIGNUP STEP 4: PRIMARY ID UPLOAD
    - Upload Philippine National ID (front)
    - Upload Philippine National ID (back)
    - Enter ID number
    ↓
SIGNUP STEP 5: SECONDARY ID UPLOAD
    - Select ID type (Driver's License, Passport, SSS, GSIS)
    - Upload secondary ID image
    - Enter ID number
    ↓
SIGNUP STEP 6: SELFIE VERIFICATION
    - Take/upload selfie with ID visible
    ↓
SIGNUP STEP 7: PROOF OF ADDRESS
    - Select document type (Utility Bill, Bank Statement, Barangay Certificate)
    - Upload proof of address image
    ↓
SIGNUP STEP 8: REVIEW ALL INFORMATION
    - Display all entered data
    - Allow editing of any step
    - [Submit] button
    ↓
[SUBMIT SIGNUP]
    ↓
SIGNUP SUCCESS SCREEN
    - "Account created! KYC under review (2-24 hours)"
    - Assigned Free Tier by default
    ↓
DIRECT TO GUEST OR LOGIN
```

**Data Created:**
- User profile with all personal info
- KYC documents pending verification
- Account Status: "Pending Verification"
- Subscription: Free Tier (₱0)
- Verification Level: Unverified

**Post-Signup:**
- User can browse auctions (read-only)
- Cannot bid until KYC approved
- Cannot list until KYC approved

---

## USER FLOW 2: LOGIN & AUTHENTICATION

```
ENTRY SCREEN → [Login]
    ↓
LOGIN SCREEN
    - Enter email
    - Enter password
    - [Forgot Password?] → Password recovery flow
    ↓
[LOGIN BUTTON]
    ↓
Account Status Check:
    ├─ Status = "Locked" → Error: "Account locked, contact support"
    ├─ Status = "Rejected" → Error: "KYC rejected: [reason]"
    └─ Status = "Verified" or "Pending" → Continue
         ↓
HOME SCREEN (with bottom navigation)
```

**Authentication States:**
- **Unverified:** Can browse only
- **Pending:** Can browse, limited actions
- **Verified:** Full access based on subscription tier
- **Locked:** No access

---

## USER FLOW 3: BROWSE AUCTIONS & SEARCH

```
HOME SCREEN → Browse Tab (default)
    ↓
BROWSE AUCTIONS SCREEN
    - Grid/List view toggle (top-right)
    - Each auction card shows:
        * Car image
        * Brand, Model, Year
        * Current Bid (₱)
        * Time Remaining (countdown timer)
        * Number of Bids
        * Seller badge (Free/Pro Basic/Pro Plus)
    ↓
USER ACTIONS:
    ├─ [Filter Icon] → FILTER BOTTOM SHEET
    │   - Select brands (multi-select)
    │   - Year range (slider)
    │   - Mileage max (input)
    │   - Transmission type (auto/manual/cvt)
    │   - Fuel type (gasoline/diesel/electric/hybrid)
    │   - Body type (sedan/suv/pickup/etc.)
    │   - Location (province/city)
    │   - Price range (slider)
    │   - [Apply Filters] → Filtered results
    │
    ├─ [Search Icon] → SEARCH SCREEN
    │   - Keyword search
    │   - Search history
    │   - Popular searches
    │
    ├─ [Sort] → Sort options:
    │   - Price: Low to High
    │   - Price: High to Low
    │   - Ending Soon
    │   - Newest
    │
    └─ [Tap Auction Card] → Go to Flow 4 (Auction Detail)
```

**Subscription-Based Display:**
- **Free Tier:** Normal listing order
- **Pro Basic:** See "Pro Basic Early Access" badge on eligible auctions
- **Pro Plus:** Featured auctions appear at top + "Pro Plus Early Access" (2 hours before others)

---

## USER FLOW 4: VIEW AUCTION & PLACE BID

```
Tap auction card → AUCTION DETAIL SCREEN
    ↓
SCREEN DISPLAYS:
    - Image gallery (swipeable, categorized: Exterior/Interior/Engine/Details)
    - Car title (Brand Model Variant Year)
    - Seller info:
        * Name
        * Subscription badge (Free/Pro Basic/Pro Plus)
        * Rating (stars)
        * "View Reviews" link
    - Countdown timer (large, color-coded: green >24h, yellow 1-24h, red <1h)
    - Current Bid: ₱XXX,XXX
    - Starting Price: ₱XXX,XXX
    - Reserve Price: Hidden/Met indicator
    - Buy Now Price: ₱XXX,XXX (if set)
    - Number of Bids: XX
    - [Watch Auction] button (heart icon)
    ↓
TABS (swipeable):
    ├─ CAR INFO TAB (default)
    │   - Complete vehicle specifications (100+ fields)
    │   - Condition details
    │   - Documentation status
    │   - Features list
    │
    └─ BID HISTORY TAB
        - List of all bids (newest first)
        - Each entry shows:
            * Bidder name (anonymized: "User ***123")
            * Bid amount
            * Time placed
            * Auto-bid indicator (if applicable)
        - Current user's bids highlighted
    ↓
BOTTOM FIXED BAR:
    ├─ Current Bid display (large)
    ├─ [PLACE BID] button (primary, green)
    └─ [AUTO BID] button (secondary, outlined)
```

### 4A: PLACE MANUAL BID

```
User taps [PLACE BID]
    ↓
BID INPUT DIALOG
    - Display current bid: ₱XXX,XXX
    - Display minimum next bid: ₱XXX,XXX (current + ₱1,000)
    - Input field with ₱ prefix
    - Quick bid buttons: [+₱1K] [+₱5K] [+₱10K]
    - [Buy Now] button (if buyNowPrice set)
    ↓
User enters bid amount
    ↓
VALIDATION CHECKS:
    ├─ Amount > current bid + ₱1,000? → Continue
    ├─ Amount < buyNowPrice? → Continue
    ├─ User is not seller? → Continue
    ├─ Auction status = "Live"? → Continue
    └─ Any fail → Show error message
         ↓
SUBSCRIPTION-BASED CHECKS (Free Tier only):
    ├─ Check active bid count
    ├─ If >= 3 active bids → SHOW UPGRADE PROMPT:
    │   "You've reached your limit of 3 active bids."
    │   "Upgrade to Pro Basic for unlimited bids + 0.5% fee discount"
    │   [Upgrade Now] [Cancel]
    └─ If < 3 → Continue
         ↓
DEPOSIT CHECK (Free Tier only, first bid):
    ├─ Has ₱10,000 deposit? → Continue
    └─ No deposit → DEPOSIT REQUIRED SCREEN:
        "To place your first bid, a refundable ₱10,000 deposit is required."
        "Deposit will be returned when you upgrade or after your first completed transaction."
        [Pay Deposit] → Payment gateway
        ↓
[CONFIRM BID]
    ↓
System Processing:
    - Create bid record
    - Update auction current bid
    - Update auction top bidder
    - Send notification to previous top bidder: "You've been outbid!"
    - If auto-bid active for other users → Trigger auto-bid logic
    ↓
SUCCESS:
    - Dialog: "Bid placed successfully!"
    - Auction detail updates in real-time
    - Bid history refreshes
    ↓
NOTIFICATION SENT (based on tier):
    - Free Tier: In-app notification only
    - Pro Basic: Push notification + in-app (priority)
    - Pro Plus: Push notification + in-app (priority) + SMS (optional)
```

### 4B: SETUP AUTO-BID

```
User taps [AUTO BID]
    ↓
AUTO-BID DIALOG
    - Explain: "We'll automatically bid on your behalf up to your maximum"
    - Current bid: ₱XXX,XXX
    - Minimum auto-bid: ₱XXX,XXX (current + ₱2,000)
    - Input: "Your maximum bid"
    - Increment: ₱1,000 (system-managed)
    ↓
User enters maximum bid (e.g., ₱150,000)
    ↓
VALIDATION:
    - Max bid > current bid + ₱2,000? → Continue
    - Max bid < buyNowPrice? → Continue
    ↓
SUBSCRIPTION CHECK (Free Tier):
    - Check active bid count (auto-bid counts as active)
    - If >= 3 → Show upgrade prompt
    ↓
[ACTIVATE AUTO-BID]
    ↓
System stores auto-bid config:
    - User ID
    - Auction ID
    - Max bid: ₱150,000
    - Enabled: true
    ↓
AUTO-BID ACTIVE INDICATOR
    - Green badge on auction detail: "Auto-bid active (max: ₱150,000)"
    - User can view/edit/cancel anytime
    ↓
WHEN OTHER USER BIDS:
    - System checks: other bid < user's max bid?
    - If yes → Auto-place bid at (other bid + ₱1,000)
    - If no → Auto-bid stops, notify user "Auto-bid limit reached"
    - Continue until max bid reached or auction ends
```

---

## USER FLOW 5: CREATE VEHICLE LISTING (SELLER FLOW)

```
HOME SCREEN → My Listings Tab → [+ CREATE LISTING]
    ↓
KYC VERIFICATION CHECK:
    ├─ Not verified → Error: "Complete KYC verification first" → Go to KYC flow
    └─ Verified → Continue
         ↓
SUBSCRIPTION-BASED LISTING LIMIT:
    ├─ Free Tier: Check active listings count
    │   └─ If >= 1 → UPGRADE PROMPT:
    │       "Free users can only have 1 active listing."
    │       "Upgrade to Pro Basic for unlimited listings + 2x exposure"
    │       [Upgrade] [Cancel]
    │
    ├─ Pro Basic/Plus: No limit → Continue
    │
    └─ Continue to listing creation
         ↓
LISTING CREATION STEP 1: BASIC INFO
    - Select brand (dropdown, 200+ brands)
    - Select model (filtered by brand)
    - Enter variant (text input)
    - Select year (dropdown, 1990-2025)
    - [Next]
    ↓
STEP 2: MECHANICAL SPECS
    - Enter engine size (e.g., "1.5L")
    - Select engine type (Inline, V-type, Boxer, Rotary, Electric)
    - Enter cylinders (number)
    - Enter horsepower (number)
    - Enter torque (number)
    - Select transmission (Automatic, Manual, CVT, DCT, AMT)
    - Enter transmission speeds (e.g., "6-speed")
    - Select drive type (FWD, RWD, AWD, 4WD)
    - Select fuel type (Gasoline, Diesel, Electric, Hybrid, Plug-in Hybrid)
    - Enter fuel consumption (L/100km)
    - Electric vehicles: Enter range, battery capacity, charging time
    - [Next]
    ↓
STEP 3: DIMENSIONS & CAPACITY
    - Select body type (Sedan, SUV, Hatchback, Pickup, Van, Coupe, etc.)
    - Enter doors (2-5)
    - Enter seats (2-9)
    - Enter curb weight (kg)
    - Enter gross weight (kg)
    - Enter cargo capacity (liters)
    - Enter towing capacity (kg, optional)
    - Enter ground clearance (mm, optional)
    - Enter dimensions: length, width, height, wheelbase (mm)
    - [Next]
    ↓
STEP 4: EXTERIOR
    - Select color (dropdown or color picker)
    - Select paint type (Solid, Metallic, Pearlescent, Matte)
    - Enter rim size (inches)
    - Select rim type (Steel, Alloy, Forged)
    - Select tire condition (New, Good, Fair, Needs Replacement)
    - [Next]
    ↓
STEP 5: CONDITION & HISTORY
    - Select overall condition:
        * Brand New (0 km)
        * Almost New (<5,000 km)
        * Used
        * Certified Pre-Owned
        * For Parts
    - Enter mileage (km)
    - Enter number of previous owners
    - Checkboxes for history:
        [ ] Accident history
        [ ] Flood damage
        [ ] Fire damage
        [ ] Frame damage
        [ ] Repainted
        [ ] Modified
        [ ] All original parts
        [ ] Commercial use (taxi, rental, etc.)
        [ ] Smoker vehicle
    - Toggles:
        [x] Service history complete
        [x] Warranty remaining
    - Select registration expiry date
    - [Next]
    ↓
STEP 6: DOCUMENTATION
    - Enter plate number
    - Enter ORCR (Official Receipt & Certificate of Registration) number
    - Select registration status:
        * Current
        * Expiring Soon (within 30 days)
        * Expired
    - Toggles:
        [x] Emission test valid
        [x] Comprehensive insurance
    - [Next]
    ↓
STEP 7: PHOTOS (CATEGORIZED UPLOAD)
    - EXTERIOR (min 4 photos):
        * Front view
        * Rear view
        * Left side
        * Right side
        [Upload] or drag-drop

    - INTERIOR (min 3 photos):
        * Dashboard
        * Front seats
        * Rear seats
        [Upload]

    - ENGINE (min 2 photos):
        * Engine bay
        * Under chassis (optional)
        [Upload]

    - DETAILS (min 2 photos):
        * Odometer
        * OR/CR document
        * Any defects/damage
        [Upload]

    - Total: Minimum 11 photos required
    - [Next]
    ↓
STEP 8: REVIEW ALL DATA
    - Display summary of all entered info (8 sections)
    - [Edit] buttons for each section → Go back to that step
    - "Everything looks good?" message
    - [Next]
    ↓
STEP 9: SUMMARY & AUCTION SETTINGS
    - Display car summary card
    - Toggle: [ ] List as auction

    IF AUCTION ENABLED:
        - Enter starting price (₱, min ₱10,000)
        - Enter reserve price (₱, minimum you'll accept)
        - Enter buy now price (₱, optional, instant purchase)
        - Select auction duration:
            * 3 days
            * 5 days
            * 7 days
            * 10 days
        - Display listing fee:
            * ₱300 (vehicles <₱500k)
            * ₱400 (vehicles ₱500k-₱1M)
            * ₱500 (vehicles >₱1M)
        - Pro Plus: "Listing fee waived! (Pro Plus benefit)"

    - Seller preferences:
        [ ] Accepts trade-ins
        [ ] Financing available
        [ ] Price negotiable (if no auction)
        [ ] Available for test drive
        [ ] Delivery available

    - Location:
        - Confirm city/province from profile
        - [Change location] (optional)

    - Description (optional, max 500 chars):
        [Text area for additional details]

    - Issues/Concerns (optional, max 300 chars):
        [Text area for known issues]
    ↓
[SAVE AS DRAFT] or [SUBMIT FOR REVIEW]
    ↓
IF DRAFT:
    - Save all data
    - Can resume anytime from My Listings
    - Status: "Draft"

IF SUBMIT:
    ↓
    LISTING FEE PAYMENT (if not Pro Plus):
        - Payment method selection:
            * GCash
            * Maya
            * Bank Transfer
            * Credit Card
        - Pay ₱300-500
        ↓
    LISTING SUBMITTED
        - Status: "Pending Review"
        - Admin review: 2-24 hours
        - Notification: "Listing submitted for review"
        ↓
    LISTING SUCCESS SCREEN
        - "Your listing is under review!"
        - Expected approval time: 2-24 hours
        - [View My Listings] button
        ↓
    GO TO MY LISTINGS TAB
```

**Post-Approval (Admin Side):**
- Listing status → "Active"
- If auction enabled → Auction goes live immediately
- Notification sent: "Your listing is now live!"
- Listing exposure based on subscription:
    - Free Tier: Normal placement
    - Pro Basic: 2x exposure (appears in "Featured" section + normal)
    - Pro Plus: Featured at top + 2x exposure + early access for Pro Plus users

---

## USER FLOW 6: AUCTION ENDS & PAYMENT

```
AUCTION COUNTDOWN REACHES 00:00:00
    ↓
System automatically:
    - Set auction status → "Ended"
    - Determine winner:
        * Top bidder ID
        * Winning bid amount
        * Check: Winning bid >= reserve price?
    ↓
IF RESERVE NOT MET:
    - Auction status → "Ended - Reserve Not Met"
    - Notification to seller: "Auction ended, reserve price not met"
    - Notification to top bidder: "Auction ended, reserve not met. Seller may contact you."
    - Listing returns to seller
    - [END]

IF RESERVE MET:
    - Auction status → "Sold"
    ↓
NOTIFICATIONS SENT:
    ├─ To WINNER:
    │   "Congratulations! You won [Car Title]"
    │   "Winning bid: ₱XXX,XXX"
    │   "Complete payment within 48 hours"
    │   [Pay Now] button
    │
    └─ To SELLER:
        "Your auction sold!"
        "Winning bid: ₱XXX,XXX"
        "Buyer: [Name]"
        "Awaiting payment..."
    ↓
WINNER'S HOME SCREEN → My Bids Tab
    - Shows "WON" badge on auction
    - [Complete Payment] button (prominent)
    ↓
Winner taps [Complete Payment]
    ↓
TRANSACTION CREATED:
    - Transaction ID generated
    - Status: "Awaiting Payment"
    - Breakdown:
        * Winning Bid: ₱XXX,XXX
        * Buyer's Premium (5%): ₱XX,XXX
        * DISCOUNT (Subscription-based):
            - Free Tier: ₱0 (0%)
            - Pro Basic: ₱XXX (0.5% discount)
            - Pro Plus: ₱XXX (1.0% discount)
        * TOTAL: ₱XXX,XXX
    ↓
PAYMENT SCREEN
    - Transaction summary
    - Platform fee breakdown with discount highlighted
    - Select payment method:
        [ ] Bank Transfer
        [ ] Credit Card
        [ ] GCash
        [ ] Maya
        [ ] Cryptocurrency
        [ ] Cash on Delivery (COD)
    ↓
User selects payment method
    ↓
PAYMENT DETAILS ENTRY:
    - Bank Transfer:
        * Display AutoBID bank account
        * Reference number: [Transaction ID]
        * [Upload Receipt] button

    - Credit Card:
        * Card number
        * Expiry date
        * CVV
        * [Pay Now] → Payment gateway

    - GCash/Maya:
        * Phone number
        * [Send Payment Request]
        * [Upload Receipt]

    - COD:
        * Confirmation only
        * "Payment will be collected during handover"
    ↓
[SUBMIT PAYMENT]
    ↓
PAYMENT PROCESSING (2-5 seconds)
    ↓
IF PAYMENT SUCCESSFUL:
    - Transaction status → "Payment Submitted - In Escrow"
    - Escrow account holds funds
    - Timeline updated: "Payment received and verified"
    ↓
    NOTIFICATIONS:
        ├─ To BUYER:
        │   "Payment confirmed! (₱XXX,XXX in escrow)"
        │   "Proceed to Pre-Transaction Discussion"
        │   [Start Discussion] button
        │
        └─ To SELLER:
            "Payment received and held in escrow!"
            "Amount: ₱XXX,XXX (minus 5% platform fee)"
            "You'll receive: ₱XXX,XXX after handover"
            "Buyer will contact you soon"
    ↓
AUTO-REDIRECT TO PRE-TRANSACTION SCREEN
```

---

## USER FLOW 7: PRE-TRANSACTION DISCUSSION & AGREEMENT

```
PAYMENT CONFIRMED → PRE-TRANSACTION SCREEN
    ↓
SCREEN DISPLAYS 4 TABS:
    ├─ 1. CHAT
    ├─ 2. VERIFICATION
    ├─ 3. AGREEMENT
    └─ 4. PAYMENT STATUS
```

### 7A: CHAT TAB (Default Active)

```
CHAT INTERFACE:
    - Buyer and Seller conversation
    - Real-time messaging
    - Typing indicators
    - Message bubbles:
        * Buyer messages: Blue (right-aligned)
        * Seller messages: Green (left-aligned)
    - Timestamp for each message
    ↓
PRE-POPULATED SYSTEM MESSAGE:
    "You are now connected with [Other Party Name]"
    "Discuss meeting location, inspection schedule, and handover details."
    "All messages are recorded for security."
    ↓
BUYER/SELLER CONVERSATION:
    - Buyer: "Hi! When can I inspect the vehicle?"
    - Seller: "Hello! Available this weekend. Location: [Address]"
    - Buyer: "Perfect! Saturday 2 PM works?"
    - Seller: "Confirmed. See you then!"
    ↓
INPUT FIELD AT BOTTOM:
    - Text input: "Type a message..."
    - [Send] button
    - Attachment option: [📷 Photo] [📎 File]
```

### 7B: VERIFICATION TAB

```
VERIFICATION STATUS DISPLAY:
    ↓
BUYER VERIFICATION:
    - Name: [Full Name]
    - Verification Level: [Level 1/2/3/Dealer]
    - Verification Badge: [✓ Verified] or [⚠ Unverified]
    - KYC Status: [Approved/Pending/Rejected]
    - Subscription Tier: [Free/Pro Basic/Pro Plus]
    - Rating: ⭐⭐⭐⭐⭐ (X reviews)
    - [View Profile] button
    ↓
SELLER VERIFICATION:
    - Name: [Full Name]
    - Verification Level: [Level 1/2/3/Dealer]
    - Verification Badge: [✓ Verified]
    - KYC Status: [Approved]
    - Subscription Tier: [Free/Pro Basic/Pro Plus]
    - Rating: ⭐⭐⭐⭐ (X reviews)
    - [View Reviews] button
    ↓
IDENTITY VERIFICATION REMINDER:
    "Both parties are KYC-verified."
    "Always verify government-issued ID during in-person meeting."
    "Report suspicious activity immediately."
```

### 7C: AGREEMENT TAB (RA 8792 Digital Agreement)

```
DIGITAL AGREEMENT SCREEN:
    ↓
HEADER:
    "Digital Transaction Agreement"
    "Compliant with RA 8792 (E-Commerce Act of 2000)"
    ↓
AGREEMENT TEXT (scrollable):
    "VEHICLE SALE AGREEMENT

    This agreement is made on [Date] between:

    SELLER: [Seller Full Name]
    BUYER: [Buyer Full Name]

    VEHICLE DETAILS:
    - Brand: [Brand]
    - Model: [Model]
    - Year: [Year]
    - Plate Number: [Plate]
    - OR/CR Number: [ORCR]

    AGREED PRICE: ₱[Winning Bid]

    TERMS:
    1. The Seller warrants that the vehicle is free from liens and encumbrances.
    2. The Buyer has inspected the vehicle and accepts its current condition.
    3. Payment of ₱[Amount] is held in escrow by AutoBID.
    4. Escrow will be released to Seller upon confirmed handover.
    5. Both parties agree to complete handover within 7 days.
    6. Disputes will be resolved through AutoBID mediation.

    DIGITAL SIGNATURES:
    This agreement is legally binding under RA 8792.
    Document Hash: [SHA-256 hash]
    "
    ↓
SIGNATURE SECTION:
    ├─ BUYER SIGNATURE:
    │   [ ] "I accept the terms and conditions"
    │   [SIGN & ACCEPT] button (blue, disabled until checkbox)
    │   Status: ⏳ Pending or ✓ Signed on [Date]
    │
    └─ SELLER SIGNATURE:
        [ ] "I accept the terms and conditions"
        [SIGN & ACCEPT] button (green, disabled until checkbox)
        Status: ⏳ Pending or ✓ Signed on [Date]
    ↓
WHEN BUYER CLICKS [SIGN & ACCEPT]:
    - Confirm dialog: "This is a legally binding agreement. Proceed?"
    - [Confirm] → Digital signature recorded
    - Timestamp saved
    - Document hash generated
    - Buyer status: ✓ Signed
    ↓
WHEN SELLER CLICKS [SIGN & ACCEPT]:
    - Same confirmation process
    - Seller status: ✓ Signed
    ↓
WHEN BOTH SIGNED:
    - Pre-Transaction status → "Agreed"
    - System message in Chat: "Both parties have signed the agreement. Proceed to vehicle handover."
    - Notification to both: "Agreement signed! Arrange handover within 7 days."
```

### 7D: PAYMENT STATUS TAB

```
PAYMENT STATUS SCREEN:
    ↓
ESCROW STATUS CARD:
    - Icon: 🔒 Locked (green)
    - Title: "Payment Secured in Escrow"
    - Amount: ₱XXX,XXX
    - Status: "Held by AutoBID"
    - Message: "Funds will be released to seller after handover confirmation"
    ↓
TIMELINE VISUALIZATION:
    ✓ 1. Auction Won (Date/Time)
    ✓ 2. Payment Submitted (Date/Time)
    ✓ 3. Escrow Secured (Date/Time)
    ⏳ 4. Agreement Signed (Waiting... or ✓ Date/Time)
    ⏳ 5. Handover Confirmed (Pending)
    ⏳ 6. Escrow Released (Pending)
    ↓
NEXT STEPS:
    "What happens next?"
    1. Sign the digital agreement (Agreement tab)
    2. Arrange in-person meeting (Chat tab)
    3. Inspect vehicle and complete handover
    4. Submit handover evidence
    5. Seller receives payment
    ↓
HELP SECTION:
    - "What is escrow?" → FAQ link
    - "How long does release take?" → FAQ link
    - "Report an issue" → Support form
```

---

## USER FLOW 8: VEHICLE INSPECTION & HANDOVER

```
BUYER & SELLER MEET IN PERSON
    ↓
BUYER INSPECTS VEHICLE:
    - Check exterior condition
    - Check interior condition
    - Test drive (if agreed)
    - Verify OR/CR documents
    - Verify plate number matches
    - Check odometer reading
    ↓
INSPECTION OUTCOME:
    ├─ NOT SATISFIED:
    │   - Buyer can request refund
    │   - Go to DISPUTE FLOW (separate)
    │   - Escrow held pending resolution
    │
    └─ SATISFIED:
        - Proceed to handover
        ↓
HANDOVER PROCESS:
    1. Seller hands over:
        - Vehicle keys
        - OR/CR original documents
        - Service records
        - Insurance papers
        - Spare keys (if any)

    2. Buyer receives all items

    3. Both parties take photos:
        - Vehicle from all angles
        - OR/CR documents
        - Odometer reading
        - Both parties together with vehicle (optional)

    4. Seller signs OR/CR transfer section
    ↓
BUYER OPENS APP → Transaction Detail Screen
    ↓
[SUBMIT HANDOVER EVIDENCE] button
    ↓
HANDOVER EVIDENCE SCREEN:
    ↓
PHOTO UPLOADS (required):
    - "Upload photos of vehicle (min 4)"
        [ ] Front view
        [ ] Rear view
        [ ] Left side
        [ ] Right side
        [Upload] button

    - "Upload photo of OR/CR document"
        [Upload] button

    - "Upload photo of odometer"
        [Upload] button
    ↓
HANDOVER DETAILS FORM:
    - Date of handover: [Date picker]
    - Time of handover: [Time picker]
    - Location: [Text input]
    - Odometer reading: [Number input] km
    - Condition notes (optional): [Text area]
        "Any damage or issues noticed during handover?"
    ↓
BUYER CONFIRMATION:
    - Checkbox: [ ] "I confirm that I have received the vehicle and all documents in satisfactory condition"
    - Checkbox: [ ] "I authorize AutoBID to release escrow payment to the seller"
    ↓
[SUBMIT HANDOVER] button (enabled only if all required fields filled)
    ↓
SUBMIT CONFIRMATION DIALOG:
    "This action will release ₱XXX,XXX from escrow to the seller."
    "This cannot be undone. Are you sure?"
    [Cancel] [Confirm Release]
    ↓
[CONFIRM RELEASE]
    ↓
PROCESSING (2-3 seconds)
    ↓
ESCROW RELEASE:
    - Transaction status → "Completed"
    - Escrow funds transferred to seller's account
    - Platform fee deducted (5% - discount if Pro)
    - Seller receives: ₱XXX,XXX (winning bid - platform fee)
    - Timeline updated: "Handover confirmed, escrow released"
    ↓
NOTIFICATIONS SENT:
    ├─ To SELLER:
    │   "Handover confirmed! ₱XXX,XXX has been released to your account."
    │   "Transaction completed. Thank you for using AutoBID!"
    │   [View Transaction] [Leave Review for Buyer]
    │
    └─ To BUYER:
        "Handover submitted! Escrow released to seller."
        "Transaction completed. Enjoy your new vehicle!"
        [Leave Review for Seller]
    ↓
AUTO-REDIRECT TO REVIEW SCREEN
```

---

## USER FLOW 9: LEAVE REVIEW & RATING

```
TRANSACTION COMPLETED → REVIEW SCREEN
    ↓
REVIEW SUBMISSION FORM:
    ↓
HEADER:
    "How was your experience with [Other Party Name]?"
    ↓
STAR RATING (required):
    ⭐⭐⭐⭐⭐ (tap to select 1-5 stars)
    - 5 stars: Excellent
    - 4 stars: Good
    - 3 stars: Average
    - 2 stars: Below Average
    - 1 star: Poor
    ↓
REVIEW TITLE (optional):
    [Text input, max 50 chars]
    Placeholder: "Great seller!" or "Smooth transaction"
    ↓
REVIEW TEXT (required):
    [Text area, max 500 chars]
    Placeholder: "Share your experience..."
    Counter: 0/500 characters
    ↓
TAGS (select all that apply):
    For SELLER:
        [ ] Honest description
        [ ] Vehicle as advertised
        [ ] Responsive
        [ ] Professional
        [ ] On-time handover
        [ ] Complete documents
        [ ] Flexible

    For BUYER:
        [ ] Reliable
        [ ] On-time payment
        [ ] Respectful
        [ ] Easy communication
        [ ] Smooth transaction
    ↓
[SUBMIT REVIEW] button
    ↓
REVIEW PROCESSING:
    - Save review to database
    - Link to transaction ID
    - Update seller/buyer's aggregate rating
    - New rating = (old rating × old count + new rating) / (old count + 1)
    ↓
SUCCESS DIALOG:
    "Thank you for your feedback!"
    "Your review helps build trust in the AutoBID community."
    [Close]
    ↓
NOTIFICATION SENT TO REVIEWED PARTY:
    "You received a new review!"
    "[Reviewer Name] left you X stars"
    [View Review]
    ↓
RETURN TO HOME SCREEN
```

**Review Display:**
- Reviews appear on user profiles
- Visible to all users browsing auctions
- Aggregate rating shown as stars (e.g., 4.7 ⭐ from 23 reviews)
- Recent reviews displayed first
- Verified purchase badge on reviews from completed transactions

---

## USER FLOW 10: SUBSCRIPTION UPGRADE

```
USER ENCOUNTERS LIMITATION:
    - Free Tier: 4th active bid attempt → Blocked
    - Free Tier: 2nd active listing attempt → Blocked
    - Wants priority notifications
    - Wants early access to auctions
    ↓
UPGRADE PROMPT APPEARS:
    "Unlock More with Pro!"

    COMPARE TIERS:
    ┌─────────────┬─────────────┬─────────────┐
    │ Free        │ Pro Basic   │ Pro Plus    │
    ├─────────────┼─────────────┼─────────────┤
    │ 3 bids      │ Unlimited   │ Unlimited   │
    │ 1 listing   │ Unlimited   │ Unlimited   │
    │ No discount │ 0.5% off    │ 1.0% off    │
    │ No badge    │ Badge       │ Premium     │
    │ Basic       │ Priority    │ Priority+   │
    └─────────────┴─────────────┴─────────────┘

    [Select Pro Basic - ₱199/mo] [Select Pro Plus - ₱499/mo]

    OR: User goes to Profile → Subscription Settings
    ↓
SELECT SUBSCRIPTION TIER
    ↓
SUBSCRIPTION DETAIL SCREEN:
    ↓
PRO BASIC (₱199/month or ₱1,999/year):
    ✓ Unlimited active bids
    ✓ Unlimited active listings
    ✓ 2x listing exposure
    ✓ 0.5% discount on Buyer's Premium
    ✓ Priority bid notifications (push + in-app)
    ✓ "Pro Basic" badge on profile
    ✓ Monthly summary reports
    ✓ Early access to low-medium value auctions
    ✓ No ₱10,000 deposit required

    Billing options:
    [ ] Monthly: ₱199/month (cancel anytime)
    [x] Yearly: ₱1,999/year (Save ₱389! - 16% off)

    [Subscribe Now]

PRO PLUS (₱499/month or ₱4,999/year):
    ✓ All Pro Basic benefits
    ✓ 1.0% discount on Buyer's Premium (double Pro Basic)
    ✓ Featured listing placement (top of browse page)
    ✓ "Pro Plus" premium badge
    ✓ Early access to ALL high-demand listings (2 hours early)
    ✓ Waived listing re-list fee
    ✓ Advanced analytics dashboard
    ✓ Dedicated customer support
    ✓ Priority dispute resolution

    Billing options:
    [ ] Monthly: ₱499/month
    [x] Yearly: ₱4,999/year (Save ₱989! - 17% off)

    [Subscribe Now]
    ↓
[SUBSCRIBE NOW]
    ↓
PAYMENT SCREEN:
    - Select payment method:
        [ ] Credit Card (recurring billing)
        [ ] Debit Card (recurring billing)
        [ ] GCash (one-time, manual renewal)
        [ ] Maya (one-time, manual renewal)
        [ ] Bank Transfer (one-time, manual renewal)
    ↓
PAYMENT DETAILS:
    - Card number
    - Expiry date
    - CVV
    - Name on card
    - Billing address
    ↓
TERMS & CONDITIONS:
    [ ] "I agree to AutoBID's subscription terms and conditions"
    [ ] "I authorize recurring payments for monthly/yearly subscription"
    ↓
[CONFIRM SUBSCRIPTION]
    ↓
PROCESSING (2-5 seconds)
    ↓
SUBSCRIPTION ACTIVATED:
    - User subscription tier updated → Pro Basic or Pro Plus
    - Billing cycle starts
    - Next billing date: [Date]
    - If Free Tier user had ₱10,000 deposit → Refunded immediately
    ↓
SUCCESS SCREEN:
    "Welcome to [Pro Basic/Pro Plus]!"

    Your benefits are now active:
    ✓ Unlimited bids and listings
    ✓ [Tier]-specific features unlocked
    ✓ Badge added to your profile

    [Explore Features] [Go to Home]
    ↓
NOTIFICATION:
    "Subscription activated! Your [Pro Basic/Pro Plus] benefits are now active."
    ↓
PROFILE UPDATED:
    - Badge displayed: "Pro Basic" or "Pro Plus" (colored)
    - Visible on:
        * User profile
        * All listings
        * Auction cards
        * Chat/messaging
        * Reviews
```

**Subscription Management:**
- User can view subscription in Profile → Subscription Settings
- Shows current tier, next billing date, payment method
- Options:
    - [Change Plan] (upgrade/downgrade)
    - [Update Payment Method]
    - [Cancel Subscription] (downgrade to Free at end of billing cycle)

---

## USER FLOW 11: WATCHLIST MANAGEMENT

```
USER BROWSING AUCTIONS → Sees interesting auction
    ↓
Tap [♡ Watch] button on auction card or detail screen
    ↓
WATCHLIST ACTION:
    - If not watched: Add to watchlist
        * Heart icon fills (♥)
        * Toast message: "Added to Watchlist"

    - If already watched: Remove from watchlist
        * Heart icon unfills (♡)
        * Toast message: "Removed from Watchlist"
    ↓
WATCHLIST UPDATED (real-time)
    ↓
USER NAVIGATES TO HOME → Watchlist Tab
    ↓
WATCHLIST SCREEN:
    - Display all watched auctions (grid/list view)
    - Each card shows:
        * Car image
        * Title (Brand Model Year)
        * Current bid
        * Time remaining (countdown)
        * [Remove from Watchlist] (♥ icon)
        * Seller badge
    - Sort options:
        * Ending Soon (default)
        * Price: Low to High
        * Price: High to Low
        * Recently Added
    ↓
REAL-TIME UPDATES:
    - Countdown timers update every second
    - Current bid updates when others bid
    - Color-coding:
        * Green: >24 hours remaining
        * Yellow: 1-24 hours remaining
        * Red: <1 hour remaining
    ↓
USER ACTIONS:
    - Tap auction → Go to Auction Detail
    - Tap ♥ → Remove from watchlist (with confirm dialog)
    - Tap [Filter] → Filter watchlist by brand, price range, etc.
    ↓
NOTIFICATIONS (Subscription-based):
    - Free Tier:
        * In-app notification when auction ending in 1 hour
        * Daily digest of watchlist updates

    - Pro Basic:
        * Push notification when auction ending in 2 hours
        * Push notification when new bid placed
        * In-app real-time updates

    - Pro Plus:
        * All Pro Basic notifications
        * SMS notification for ending auctions (optional)
        * Custom notification preferences
```

---

## USER FLOW 12: MY BIDS TRACKING

```
HOME SCREEN → My Bids Tab
    ↓
MY BIDS SCREEN (3 sections, swipeable tabs):
    ↓
TAB 1: ACTIVE BIDS
    - List of auctions where user has active bids
    - Each card shows:
        * Car image
        * Title
        * YOUR BID: ₱XXX,XXX
        * CURRENT BID: ₱XXX,XXX (highlighted if outbid)
        * Status badge:
            - 🟢 "WINNING" (green) - your bid is highest
            - 🔴 "OUTBID" (red) - someone bid higher
            - 🔵 "AUTO-BID ACTIVE" (blue) - auto-bid running
        * Time remaining (countdown)
        * [Place New Bid] or [View Auction] button
    - Real-time updates
    ↓
TAB 2: WON AUCTIONS
    - List of auctions user has won
    - Each card shows:
        * Car image
        * Title
        * WINNING BID: ₱XXX,XXX
        * Status:
            - "Payment Pending" (yellow) → [Pay Now] button
            - "In Escrow" (blue) → [View Transaction] button
            - "Completed" (green) → [View Details] button
        * Next action button
    ↓
TAB 3: LOST AUCTIONS
    - List of auctions where user was outbid and lost
    - Each card shows:
        * Car image (grayed out)
        * Title
        * YOUR HIGHEST BID: ₱XXX,XXX
        * WINNING BID: ₱XXX,XXX
        * Status: "AUCTION ENDED"
        * Date ended
    - Filter: Last 30 days, Last 90 days, All time
    ↓
SUBSCRIPTION-BASED LIMITS (Free Tier):
    - Active Bids tab shows count: "2/3 Active Bids"
    - If at limit (3/3):
        * [Place New Bid] disabled
        * Message: "Upgrade to Pro for unlimited bids"
        * [Upgrade] button
```

---

## USER FLOW 13: MY LISTINGS MANAGEMENT

```
HOME SCREEN → My Listings Tab
    ↓
MY LISTINGS SCREEN (4 sections, filterable):
    ↓
SECTION 1: ACTIVE LISTINGS
    - Listings currently live and accepting bids
    - Each card shows:
        * Car image
        * Title
        * Current Bid: ₱XXX,XXX
        * Starting Price: ₱XXX,XXX
        * Number of Bids: XX
        * Time Remaining: X days X hours
        * Views: XXX (Pro Basic/Plus only)
        * [View Auction] [Edit] [Cancel Listing]
    - Subscription-based features:
        * Free Tier: "1/1 Active Listing" (limit reached message if 1 active)
        * Pro Basic: "Featured" badge on 2x exposure listings
        * Pro Plus: "Featured ⭐" badge + placement indicator
    ↓
SECTION 2: PENDING REVIEW
    - Listings submitted but awaiting admin approval
    - Each card shows:
        * Car image
        * Title
        * Status: "Under Review"
        * Submitted: [Date/Time]
        * Expected approval: 2-24 hours
        * [View Details] [Cancel]
    ↓
SECTION 3: SOLD LISTINGS
    - Auctions that have ended and sold
    - Each card shows:
        * Car image (with "SOLD" overlay)
        * Title
        * Sold For: ₱XXX,XXX
        * Buyer: [Name]
        * Status:
            - "Awaiting Payment" → Countdown: 48 hours
            - "In Escrow" → [View Transaction]
            - "Completed" → Date completed
        * Your Proceeds: ₱XXX,XXX (after platform fee)
        * [View Transaction]
    ↓
SECTION 4: CANCELLED/EXPIRED
    - Listings that didn't sell or were cancelled
    - Each card shows:
        * Car image (grayed out)
        * Title
        * Reason:
            - "Reserve Not Met" (highest bid < reserve)
            - "No Bids Received"
            - "Cancelled by Seller"
            - "Expired"
        * Date ended
        * [Re-List] button (Free if Pro Plus, ₱300-500 for others)
    ↓
ACTIONS:
    ├─ [EDIT LISTING] (only for active listings):
    │   - Can edit:
    │       * Description
    │       * Photos (add more)
    │       * Seller preferences
    │   - Cannot edit:
    │       * Price (auction started)
    │       * Specs (fraud prevention)
    │
    ├─ [CANCEL LISTING]:
    │   - Confirm dialog: "This will end the auction immediately. Continue?"
    │   - If bids placed: "Refund all bidders? This may affect your rating."
    │   - [Confirm Cancel]
    │   - Listing moved to Cancelled section
    │   - Notifications sent to all bidders
    │
    └─ [RE-LIST]:
        - Pre-fill all data from previous listing
        - Allow edits
        - Re-submit for review
        - Fee:
            * Pro Plus: FREE (waived)
            * Others: ₱300-500 listing fee
```

---

## USER FLOW 14: KYC VERIFICATION

```
NEW USER (Unverified) tries to bid/list
    ↓
BLOCKED ACTION:
    - Error dialog: "Complete KYC verification to [bid/list]"
    - [Start KYC Verification] button
    ↓
OR: User goes to Profile → Verification Status → [Complete KYC]
    ↓
KYC INTRO SCREEN:
    "Why KYC Verification?"
    - Protect buyers and sellers
    - Prevent fraud
    - Comply with Philippine regulations
    - Unlock higher transaction limits

    VERIFICATION LEVELS:
    ┌────────────────────────────────────────┐
    │ Level 1: Basic Verification            │
    │ • Buy up to ₱500,000                   │
    │ • Sell up to ₱500,000                  │
    │ • Required: National ID + Selfie       │
    └────────────────────────────────────────┘

    ┌────────────────────────────────────────┐
    │ Level 2: Advanced Verification         │
    │ • Buy/Sell up to ₱2,000,000           │
    │ • Required: Level 1 + Secondary ID     │
    │   + Proof of Address                   │
    └────────────────────────────────────────┘

    ┌────────────────────────────────────────┐
    │ Level 3: Premium Verification          │
    │ • Unlimited buy/sell                   │
    │ • Required: Level 2 + TIN              │
    │   + NBI Clearance + Background Check   │
    └────────────────────────────────────────┘

    [Start Level 1 Verification]
    ↓
KYC UPLOAD SCREEN (Level 1):
    ↓
STEP 1: PRIMARY ID (Philippine National ID)
    - "Upload front of National ID"
        [Take Photo] or [Choose from Gallery]
        Preview image shown
        [Retake] [Continue]

    - "Upload back of National ID"
        [Take Photo] or [Choose from Gallery]
        Preview image shown
        [Retake] [Continue]

    - "Enter ID Number"
        [Input field: XXXX-XXXX-XXXX-XXXX]
        Auto-format with dashes
    ↓
STEP 2: SELFIE VERIFICATION
    - "Take a selfie holding your National ID"
    - Tips displayed:
        * Ensure face is clearly visible
        * ID text should be readable
        * Good lighting
        * No filters
    - [Take Selfie] → Opens camera
    - Preview shown
    - [Retake] [Continue]
    ↓
STEP 3: REVIEW & SUBMIT
    - Display all uploaded images
    - Checkbox: [ ] "I certify that all information is accurate"
    - [Submit for Verification]
    ↓
[SUBMIT]
    ↓
KYC PROCESSING:
    - Upload images to server (simulated Firebase Storage)
    - Create KYC record
    - Status: "Pending Review"
    - Queue for admin verification
    ↓
KYC STATUS SCREEN:
    "Verification Submitted!"

    Current Status: ⏳ Under Review
    Estimated Time: 2-24 hours

    What's next?
    1. Our team will verify your documents
    2. You'll receive a notification when complete
    3. If approved, you can start bidding/listing!

    [Track Status] [Back to Home]
    ↓
ADMIN REVIEW (Backend Process):
    - Admin checks:
        * ID images are clear and readable
        * ID is valid and not expired
        * Selfie matches ID photo
        * No duplicate accounts with same ID
    - Decision:
        [ ] Approve → Level 1 verified
        [ ] Reject → Specify reason
    ↓
IF APPROVED:
    - User.verificationLevel → Level 1
    - User.accountStatus → Verified
    - User.kycStatus → Approved
    - User.verificationLimits → {buyLimit: 500000, sellLimit: 500000}
    - Notification: "KYC Approved! You can now bid and list up to ₱500,000"
    - Badge added to profile: "✓ Level 1 Verified"
    ↓
IF REJECTED:
    - User.kycStatus → Rejected
    - User.rejectionReason → "ID image unclear" (or other reason)
    - Notification: "KYC Rejected: [Reason]. Please re-submit with clearer images."
    - [Re-submit KYC] button available
    ↓
USER NOTIFICATION RECEIVED → KYC STATUS UPDATED IN APP
```


---

## REVENUE MODEL INTEGRATION SUMMARY

### Deposit System (Free Tier Only)
- **Amount:** ₱10,000 (one-time, refundable)
- **Triggered:** First bid attempt
- **Refund Conditions:**
    1. User upgrades to Pro Basic/Plus → Immediate refund
    2. User completes first transaction → Refund after 7 days
    3. User requests refund (no bids/transactions) → Refund within 3-5 business days
- **Purpose:** Prevent bid trolling, ensure serious buyers

### Fee Structure

#### Listing Fees (Sellers)
- **Free Tier & Pro Basic:**
    - Vehicles <₱500k: ₱300
    - Vehicles ₱500k-₱1M: ₱400
    - Vehicles >₱1M: ₱500
- **Pro Plus:** WAIVED (₱0)

#### Buyer's Premium (Buyers)
- **Base Rate:** 5% of winning bid
- **Free Tier:** 5% (no discount)
- **Pro Basic:** 4.5% (0.5% discount)
- **Pro Plus:** 4.0% (1.0% discount)

**Example:**
- Winning Bid: ₱500,000
- Free Tier pays: ₱500,000 + ₱25,000 (5%) = ₱525,000
- Pro Basic pays: ₱500,000 + ₱22,500 (4.5%) = ₱522,500 (**saves ₱2,500**)
- Pro Plus pays: ₱500,000 + ₱20,000 (4.0%) = ₱520,000 (**saves ₱5,000**)

#### Platform Fee (Sellers)
- **All Tiers:** 5% of winning bid (deducted from seller proceeds)
- **Non-Discountable**

**Example:**
- Winning Bid: ₱500,000
- Platform takes: ₱25,000 (5%)
- Seller receives: ₱475,000 (before taxes)

### Upgrade Prompts (Behavioral Hooks)

**Free Tier Limitations Trigger Prompts:**
1. **3rd Active Bid Reached:**
   - "You've reached your limit! Upgrade to Pro Basic for unlimited bids + save 0.5% on every win"
   - Show annual savings calculator: "If you win ₱2M worth of auctions/year, you'll save ₱10,000 with Pro Basic!"

2. **1st Active Listing Reached:**
   - "Want to list more vehicles? Pro Basic gives unlimited listings + 2x exposure!"

3. **After Winning First Auction:**
   - "Congratulations! You saved ₱0 on this purchase."
   - "Pro Basic users would have saved ₱[amount] with 0.5% discount."
   - [Upgrade to save on future wins]

4. **Viewing High-Value Auctions:**
   - "Pro Plus users get 2-hour early access to high-demand listings like this!"

5. **Monthly Summary (Free Tier):**
   - Email/push: "This month, you could have saved ₱[amount] with Pro Basic"
   - Show opportunity cost

### Subscription Benefits Display

**Throughout App:**
- **Profile Screen:** Badge prominently displayed
- **Auction Cards:** Seller badge visible (builds trust)
- **Listings:** "Featured" tag for Pro Basic/Plus listings
- **Notifications:** "Priority" tag for Pro users
- **Analytics:** Pro users see detailed stats (views, favorite count, conversion rate)

---

## ADDITIONAL USER FLOWS (Minor)

### Guest Browsing
```
App Opened (Not Logged In) → Guest View Screen
    - Browse auctions (read-only)
    - Cannot bid/list/watch
    - Persistent banner: "Sign up to bid and list"
    - [Sign Up] [Login] buttons
```

### Forgot Password
```
Login Screen → [Forgot Password?]
    ↓
Enter email → Receive OTP → Enter OTP
    ↓
Create new password → Login with new password
```

### Notifications Center
```
Home Screen → [🔔 Notifications Icon]
    ↓
Notifications List:
    - Bid notifications ("You've been outbid!")
    - Auction end notifications
    - Payment reminders
    - KYC status updates
    - Review received
    - Messages
    ↓
Tap notification → Navigate to relevant screen
Mark as read → Notification dismissed
```

### Help & Support
```
Profile → Help & Support
    ↓
FAQ Categories:
    - Bidding & Auctions
    - Listing Vehicles
    - Payments & Escrow
    - KYC Verification
    - Subscriptions
    - Account Issues
    ↓
[Contact Support] → Submit ticket form
```

---

**END OF USER FLOW ANALYSIS**

This document provides complete user journeys for all major features with subscription tier integration. All flows exclude orphaned/unused files and focus on active implementation only.