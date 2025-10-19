

AUCTION END
Auction Timer Expires → System Identifies Winner → Generate Auction Result Record → Send Notifications

NOTIFICATIONS
Buyer Receives: "You Won! Proceed to Discussion" → Seller Receives: "Item Sold! Buyer Awaiting Discussion" → Both Get: Chat Room Link

DISCUSSION PHASE
Chat Room Opens (open for the entire transaction duration) → Buyer Enters Chat → Seller Enters Chat → Exchange Messages → Buyer fills out necessary information drawer and confirms:

BUYER SIDE:
Final Bid & Fees
- Final Bid Price: auto-filled (readonly)
- Additional Fees: auto-filled (readonly)
- Confirmation Checkbox: “I confirm and accept the final bid price and fees”

Payment Details
- Payment Duration: number picker (hours/days)
- Confirmation Checkbox: “I acknowledge late payment penalties apply if payment is not made on time”

Shipping & Delivery
- Shipping/Delivery Method: dropdown (Pickup, Transporter, Seller-Arranged)
- Shipping Cost Responsibility: dropdown (Buyer, Seller, Shared)
- Delivery Location: text input or map pin
- Insurance Responsibility: dropdown or radio (Buyer, Seller, Both)
- Estimated Delivery Timeframe: date range picker or number of days

Inspection & Acceptance
- Inspection Duration: number picker (hours/days)
- Inspection Method: dropdown (In-person, Video Walkthrough, Third-party Inspection)
- Acceptance Criteria: text area / confirmation checkbox “Acceptance criteria for the vehicle are understood and agreed”
- Procedure for Discrepancies: text area (optional notes for buyer’s understanding)
- Buyer Confirmation duration limit: number picker (hours/days)

Legal & Documentation
- Acknowledgement Checkbox: “I acknowledge receipt of title/registration upon delivery”
- Acknowledgement Checkbox: “No outstanding loans or liens exist on this vehicle”
- Acknowledgement: text/info: “Transfer of ownership process acknowledged”

Dispute & Extra Protections
- Confirmation Checkbox: “All discussions/messages are logged and may be used for dispute resolution”
- Confirmation Checkbox: “I agree to the platform dispute resolution process, including moderator review, evidence submission, escrow hold, timelines, and optional escalation to senior admin”
- Confirmation Checkbox: “I acknowledge platform policies for fraud, collusion, or suspicious activity”

Optional Text Input: “Additional protections requested or agreed (e.g., conditional acceptance, partial refunds, insurance coverage)”

Platform Terms
Confirmation Checkbox: “I agree to the platform terms and conditions for this transaction”

---
SELLER SIDE

Vehicle Details Confirmation
- Confirmation Checkbox: “I confirm that the vehicle listed matches all details: VIN, Make, Model, Year, Color, Mileage.”
- Confirmation Checkbox: “I confirm that all known issues, damages, accidents, and modifications are accurately disclosed in the listing.”
- Confirmation Checkbox: “I acknowledge the condition of the vehicle, including scratches, dents, accident history, mechanical issues, and modifications, is as represented in the listing”
- Upload: Any supporting documents (photos, videos) to verify condition at the time of auction.

Legal & Ownership Documentation
- Upload: Proof of legal ownership (Title, Registration, Insurance).
- Confirmation Checkbox: “There are no outstanding liens, loans, or legal encumbrances on the vehicle.”
- Optional Notes: Any special transfer instructions or legal considerations.

Shipping / Delivery Information
- Input / Dropdown: Confirm shipping/delivery method agreed with buyer (Pickup, Transporter, Seller-Arranged).
- Input: Delivery location and any special instructions for the carrier.
- Upload: Pre-shipping evidence (VIN photo, 360° video, shipping receipt, GPS check-in).
- Confirmation Checkbox: “I agree to submit all required shipping evidence before dispatch.”
- Confirmation Checkbox: “I acknowledge responsibility for insurance during transit (if applicable).”

Inspection Phase Participation
- Input: Availability for post-delivery inspection (dates/times)
- Input / Dropdown: Method of inspection (In-person, Video walkthrough, Third-party)
- Confirmation Checkbox: “I will review inspection evidence submitted by the buyer and provide confirmation for checkpoint 4.”
- Optional Text: Notes regarding acceptance criteria or specific points to verify.

Dispute & Extra Protection Acknowledgment
- Confirmation Checkbox: “I agree to the platform dispute resolution process, including moderator review, evidence submission, escrow hold, timelines, and escalation if needed.”
- Confirmation Checkbox: “I acknowledge platform policies for fraud, collusion, or suspicious activity.”
- Optional Text: Seller-requested protection measures (e.g., holdback period, conditional acceptance).

Transaction Confirmation
- Confirmation Checkbox: “I confirm that all information I have provided is accurate and complete to the best of my knowledge.”
- Confirmation Checkbox: “I agree to platform terms and conditions and commit to facilitating payment, shipping, and inspection as required.”


MUTUAL AGREEMENT & PAYMENT PHASE (DESCRIPTION ONLY)
- Buyer Submits Completed Checklist
- Seller Submits Completed Checklist
- System Generates Review Page with Both Checklists
- Buyer Reviews Combined Information and Clicks: "I Agree to Terms"
- Seller Reviews Combined Information and Clicks: "I Agree to Terms"
- System Verifies That Both Parties Have Agreed
- Admin Reviews Submitted Information
- Once Admin Approves → System Enables: Buyer to Proceed to Payment Phase

→ Buyer Submits Completed Checklist → Seller Submits Completed Checklist → System Generates Review Page with Both Checklists → Buyer Reviews Combined Information and Clicks: "I Agree to Terms" → Seller Reviews Combined Information and Clicks: "I Agree to Terms" → System Verifies That Both Parties Have Agreed → Admin Reviews Submitted Information → Once Admin Approves → System Enables: Buyer to Proceed to Payment Phase

PAYMENT PHASE
Buyer Clicks: "Proceed to Payment" → Payment Page Loads → Display: the payment summary → Display: Countdown Timer (agreed time) → Buyer Selects: Payment Method → Buyer Enters: Card/Bank Details → Click: "Pay Now" → Payment Gateway Processes → Gateway Returns: Success → System Records: Payment Received → Generate: Transaction ID (TXN-2024-00145) → Generate: QR Code → Move Funds: To Escrow Hold → Update Status: "CHECKPOINT 1 - PAYMENT SECURED" → Notify Seller: "Payment Received - Ship in 3 Days (agreed delivery window)"

SELLER SHIPPING PHASE
Seller Views: Shipping Requirements Page → Seller Prepares: Vehicle for Shipping → Seller Opens: Evidence Upload Page → Upload 1: VIN Photo → Upload 2: 360° Video → Upload 3: Shipping Receipt → Upload 4: GPS Location → Click: "Submit Shipping Evidence" → System Validates: All 4 Files Present → System Assigns: To Moderator Queue → Moderator Opens: Review Panel → Moderator Checks: VIN Matches Listing → Moderator Checks: Video Shows Correct Car → Moderator Checks: Shipping Doc Valid → Moderator Clicks: "Approve Shipping" → Update Status: "CHECKPOINT 2 - ITEM SHIPPED" → Notify Buyer: "Item Shipped - Tracking Available (agreed shipping location and method)"

DELIVERY PHASE
Buyer Waits: For Delivery → Physical Delivery Occurs → Buyer Receives: Vehicle → Seller Uploads Delivery Evidence: Delivery Receipt, VIN Photo, 360° Video, GPS Check-in → System Validates Seller Files Present

INSPECTION PHASE (POST-DELIVERY, MANDATORY)
Buyer and Seller Agree on Inspection Duration and Method → Buyer Inspects Vehicle → Upload Inspection Evidence (photos, videos, notes) → Buyer Confirms Inspection Complete → Seller Confirms Inspection Complete → System Validates Both Confirmations → Proceed to Buyer Confirmation Phase

BUYER CONFIRMATION PHASE
Buyer Opens: Delivery Confirmation Page →
Post-Delivery Buyer Checklist before confirmation (UI-Ready)

* Delivery Receipt
  * Upload field: Delivery receipt or proof of delivery

* Vehicle Condition Photos
  * Upload field: Front photo of the car
  * Upload field: Back photo of the car
  * Upload field: Side photos of the car (both sides)
  * Upload field: Any optional interior photos (if needed)

* Odometer Verification
  * Input / Upload field: Current odometer reading

* GPS Location Check-in
  * Upload or auto-log GPS coordinates at delivery location

* Selfie with Vehicle (Optional)
  * Upload field: Selfie confirming physical receipt

* Inspection Confirmation
  * Confirmation Checkbox: “Vehicle matches the agreed condition as per listing and pre-delivery evidence”
  * Confirmation Checkbox: “All agreed accessories and documents (registration, title, manuals, keys) have been received”
  * Confirmation Checkbox: “No damages or discrepancies found beyond agreed terms”
  * Confirmation Checkbox: “Inspection duration and method as agreed have been fulfilled”

* Discrepancy Reporting (Optional / Conditional)
  * Text area: Describe any discrepancies or issues found
  * Upload field: Photos or videos of discrepancies

* Final Confirmation for Payment Release
  * Confirmation Checkbox: “I confirm delivery is complete and all conditions are met. Payment release to the seller can proceed.”

→ Seller Facilitates Buyer Upload by Providing Instructions and Assistance → Click: "Confirm Delivery" → System Validates: All Files Present (Buyer and Seller) → System Assigns: To Moderator Queue → Moderator Opens: Review Panel → Moderator Compares: Seller Evidence vs Buyer Evidence → Check: VIN Matches → Check: Same Vehicle in Photos → Check: Location Logical → Check: No Major Discrepancies → Moderator Clicks: "Approve Delivery" → Update Status: "CHECKPOINT 3 - DELIVERY CONFIRMED"

FINAL VERIFICATION
System Checks: Both Evidences Approved → System Checks: Buyer Confirmation Received → System Checks: Seller Confirmation Received → System Checks: No Disputes Active → System Checks: All Checkpoints Passed → Update Status: "CHECKPOINT 4 - TRANSACTION COMPLETE" → Trigger: Escrow Release

PAYMENT RELEASE
System Initiates: Payment Release → Move Funds: From Escrow to Seller Account → Generate: Payment Confirmation → Send: Receipt to Seller → Send: Receipt to Buyer → Open: Feedback Window → Buyer Submits: 5-Star Rating + Comment → Seller Submits: 5-Star Rating + Comment → Update: Trust Scores → Close: Transaction Record → Status: "COMPLETED"

DISPUTES CASES
DISPUTE AT PAYMENT STAGE
Buyer Doesn't Pay in (agreed time) → Payment Timer Expires → System Auto-Cancels → Suspension Penalty to Buyer Account → Release: Car Back to Active Listings → Notify: Both Parties of Cancellation → Status: "CANCELLED - PAYMENT TIMEOUT"

DISPUTE AT SHIPPING STAGE
Seller Doesn't Ship in (agreed duration) (agreed delivery window) → Shipping Timer Expires → System Flags: Shipping Delay → Notify: Buyer of Delay → Buyer Chooses: "Request Refund" → System Initiates: Auto-Refund → Move Funds: From Escrow to Buyer → Suspension Penalty to Seller → Status: "REFUNDED - SHIPPING FAILURE"

DISPUTE AT DELIVERY
Buyer Receives Vehicle → Buyer Finds: Problems/Differences → Click: "Raise Dispute" → Select: Dispute Reason → Options: "Wrong Vehicle" / "Hidden Damage" / "Missing Items" / "Not as Described" → Fill: Dispute Description → Upload: Evidence Photos of Issues → Upload: Videos of Problems → Submit: Dispute Case → System Creates: Dispute Ticket (DSP-2024-00089) → Assign: To Moderator Queue → Freeze: Escrow Funds → Notify: Seller of Dispute

SELLER RESPONSE TO DISPUTE
Seller Opens: Dispute Response Page → Reviews: Buyer's Claims → Submit: Counter-Evidence → Upload: Pre-Shipping Photos → Upload: Original Listing Screenshots → Upload: Chat Agreements → Write: Response Statement → Click: "Submit Response"

MODERATOR DISPUTE REVIEW
Moderator Opens: Dispute Case DSP-2024-00089 → View: Side-by-Side Evidence Comparison → Check: Original Listing vs Delivery Photos → Check: Seller Evidence vs Buyer Evidence → Check: Chat Agreements → Analyze: Credibility of Claims

DISPUTE DECISION PATHS - PATH A - BUYER WINS
Moderator Finds: Buyer Claims Valid → Click: "Favor Buyer" → Write: Decision Reason → System Initiates: Full Refund → Move Funds: From Escrow to Buyer → Buyer Returns: Vehicle to Seller → Charge: Penalty to Seller Trust Score → Status: "REFUNDED - DISPUTE RESOLVED"

DISPUTE DECISION PATHS - PATH B - SELLER WINS
Moderator Finds: Seller Evidence Valid → Click: "Favor Seller" → Write: Decision Reason → System Initiates: Payment Release → Move Funds: From Escrow to Seller → Buyer Keeps: Vehicle → Update: Trust Scores Accordingly → Status: "COMPLETED - DISPUTE REJECTED"

DISPUTE AT CONFIRMATION TIMEOUT
Buyer Doesn't Confirm in (agreed duration) (agreed confirmation window) → Confirmation Timer Expires → System Checks: Shipping Evidence Exists → Auto-Decision: Assume Delivery Successful → Wait: Additional 24hr Grace Period → No Buyer Response → Auto-Release: Payment to Seller → Status: "COMPLETED - AUTO-CONFIRMED"

ESCALATED DISPUTE
Moderator Cannot Decide → Click: "Escalate to Senior" → Senior Admin Reviews → May Request: Video Call Verification → May Request: Additional Documents → Final Decision: Binding within Platform → Execute: Decision (Refund/Release/Split) → Status: "RESOLVED - ADMIN DECISION"

SUSPICIOUS ACTIVITY DETECTION
System Detects: Same IP Address (Buyer & Seller) → Flag: Possible Collusion → Freeze: Transaction Immediately → Request: Video Verification from Both → Manual Review: Required → If Verified: Continue Flow → If Fraud: Cancel + Ban Users

INSTANT CONFIRMATION DETECTION
Buyer Confirms: Within 1 Hour of Delivery → System Flags: Too Quick → Require: Additional Evidence → Require: Detailed Photos → Require: Video Walkthrough → Manual Review: By Moderator → If Valid: Release Payment → If Suspicious: Freeze + Investigate

HIGH VALUE TRANSACTION
System Detects: High Value → Require: Enhanced KYC → Require: Video Call Verification → Require: Source of Funds Document → Senior Admin: Must Approve → Additional: 48hr Holding Period → Then: Normal Flow Continues

TECHNICAL FAILURE RECOVERY
Payment Fails: Gateway Error → System Logs: Failure → Allow: 3 Retry Attempts → If Success: Continue Flow → If All Fail: Extend Timer 24hr → Final Fail: Cancel Transaction

SYSTEM STATUS CODES
ACTIVE_AUCTION → AUCTION_ENDED → AWAITING_DISCUSSION → DISCUSSION_IN_PROGRESS → TERMS_AGREED → AWAITING_INSPECTION → INSPECTION_COMPLETED → AWAITING_PAYMENT → PAYMENT_PROCESSING → PAYMENT_SECURED (CP1) → AWAITING_SHIPPING → SHIPPING_EVIDENCE_SUBMITTED → SHIPPING_UNDER_REVIEW → ITEM_SHIPPED (CP2) → IN_TRANSIT → DELIVERED_AWAITING_CONFIRMATION → CONFIRMATION_EVIDENCE_SUBMITTED → DELIVERY_UNDER_REVIEW → DELIVERY_CONFIRMED (CP3) → TRANSACTION_COMPLETE (CP4) → PAYMENT_RELEASED → FEEDBACK_PENDING → CLOSED_SUCCESS

OR 

SYSTEM STATUS CODES - CANCELLATION/REFUNDS
CANCELLED_TIMEOUT → CANCELLED_BY_USER → REFUNDED_SHIPPING_FAIL → REFUNDED_DISPUTE → DISPUTED_UNDER_REVIEW → DISPUTED_ESCALATED → SETTLED_PARTIAL → FROZEN_SUSPICIOUS → BANNED_FRAUD