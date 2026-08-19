# The Daily Wire — Digital Newspaper & Classifieds App

A Flutter mobile app that combines a digital newspaper reading experience
with a classified-advertisement marketplace (Jobs, Property, Matrimonial,
Education, Vehicles, Business, Services, General).

## Screens

1. **Phone Login / Sign Up** — country code selector, phone input, inline
   validation, animated transition into OTP screen.
2. **OTP Verification** — 4-digit auto-advancing OTP boxes, 30s countdown,
   resend action, success/error states (enter `0000` to preview the error
   state).
3. **Newspaper Feed (Main Screen)** — masthead header, reading-progress bar,
   horizontal "Featured Stories" rail, classified category chips + ad rail,
   filterable news category chips, and a classic two-column article list.
4. **Classified Ad Detail** — swipeable image gallery with page indicator,
   title/category/description/location/date/contact, save (bookmark) and
   share bottom sheet, and a "Related Ads" carousel.

## Innovation / UX Additions

- **Reading progress bar** — a thin bar under the app bar fills as the user
  scrolls the feed, giving a print-newspaper "how much is left" feel.
- **Swipeable ad image gallery** with animated dot indicators (property and
  vehicle ads have multiple images).
- **Related Ads carousel** on the detail screen to keep users browsing
  within the same category, mirroring "related stories" in print media.
- **Animated bookmark icon + snackbar confirmation** for a satisfying save
  interaction, plus Hero transitions from feed cards into detail screens.

## Tech Stack

- Flutter 3.22+ / Dart 3.3+
- `google_fonts` for serif "newspaper" headline typography
- All data is static/mock (see `lib/data/mock_data.dart`) — no backend/API
  calls are made anywhere in the app.

## Project Structure

```
lib/
  main.dart                 # App entry point
  theme/app_theme.dart      # Colors, text theme, component theming
  models/models.dart        # Article, ClassifiedAd, ClassifiedCategory
  data/mock_data.dart       # Static mock data for news + classifieds
  screens/
    login_screen.dart
    otp_screen.dart
    feed_screen.dart
    ad_detail_screen.dart
  widgets/
    primary_button.dart
    section_header.dart
    article_card.dart       # Featured card + list tile
    classified_widgets.dart # Category chip + ad card
```

## Setup Instructions

1. Install Flutter (3.22 or newer) — https://docs.flutter.dev/get-started/install
2. From the project root, fetch dependencies:
   ```bash
   flutter pub get
   ```
3. Run on a connected device/emulator:
   ```bash
   flutter run
   ```
4. Build a release APK:
   ```bash
   flutter build apk --release
   ```
   The APK will be at `build/app/outputs/flutter-apk/app-release.apk`.

## Demo Flow

Login → enter any 10-digit phone number → Continue → OTP screen → enter any
4 digits (use `0000` to see the error state) → Feed screen → tap any
classified ad card → Ad Detail screen with gallery, save/share, and related
ads.

## Notes

- No backend/API integration, per assignment requirements — all content is
  static mock data.
- Network images are loaded from `picsum.photos` purely as visual
  placeholders for article/ad photos.
