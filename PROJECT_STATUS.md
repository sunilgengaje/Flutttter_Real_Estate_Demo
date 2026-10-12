# Prototype status

## Implemented
- Premium BuildLock theme
- Contractor onboarding/login
- Contractor home
- Search/categories/material details
- Supplier list and map-style view
- Supplier detail/direct request
- Broadcast + broadcast live status
- Quotes + quote detail
- Agreement + signature UI
- Payment UI
- Locked order
- Timeline + tracking
- Delivery verification + issue reporting
- Completion + rating
- Contractor orders/profile/notifications/chat
- Supplier home/requests/quote/commitment/orders/inventory/profile
- Admin dashboard/live order monitor
- Reusable cards, badges, buttons, navigation components

## Not connected
- Backend APIs
- Authentication service
- Real GPS/maps
- Payment gateway/escrow
- Legally binding DSC/eSign provider
- Push/SMS/WhatsApp
- Real-time WebSocket tracking
- Database

## Recommended next architecture
Flutter -> API Gateway -> Auth/KYC -> Marketplace -> Quote/Order -> Payment -> Delivery -> Dispute -> Notification services.
