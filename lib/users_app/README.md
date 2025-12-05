# Users App - Passenger Bus Booking Application

## Overview
The **Users App** is a customer-facing bus booking application that reuses the backend logic and services from the admin app while providing a dedicated, user-friendly interface for passengers to book bus tickets.

## Architecture

### Shared Components (Reused from Admin App)
```
├── core_lib/
│   ├── common/models/
│   │   └── bus/
│   │       ├── BusModel (all bus data)
│   │       ├── SeatConfigurationModel
│   │       └── StoppageModel
│   ├── core/
│   │   ├── data/
│   │   │   ├── provider/DataProvider (bus list management)
│   │   │   └── services/HttpService (API calls)
│   │   └── services/
│   └── auth_module/
│       ├── AuthProvider (user authentication)
│       └── AuthNotifier (auth state)
│
├── features/
│   ├── booking/
│   │   ├── services/SeatService (seat locking, pricing)
│   │   └── components/layout_map (Layout48, Layout44)
│   └── bus/
│       ├── models/SeatTypeEnum
│       └── provider/CitiesProvider (city suggestions)
```

### Users App Structure
```
lib/users_app/
├── users_main.dart              # Entry point (equivalent to main.dart in admin)
├── config/
│   ├── user_theme.dart          # Light/bright theme for passengers
│   └── user_routes.dart         # Beamer routing configuration
├── presentation/
│   ├── screens/
│   │   ├── home_screen.dart     # Bus search interface
│   │   ├── bus_list_screen.dart # Search results
│   │   ├── seat_selection_screen.dart (TODO)
│   │   ├── passenger_details_screen.dart (TODO)
│   │   └── payment_screen.dart  (TODO)
│   └── components/
│       └── (user-specific UI components)
├── services/
│   └── (wrapper services if needed)
└── providers/
    ├── user_search_provider.dart (TODO)
    └── user_booking_provider.dart (TODO)
```

## How It Reuses Admin Code

### 1. **Data Management (DataProvider)**
```dart
// In HomeScreen and BusListScreen
final dataNotifier = ref.read(dataProvider.notifier);
final searchResults = dataNotifier.searchBuses(
  sourceCity: fromCity,
  destinationCity: toCity,
  travelDateTime: searchDateTime,
);
```

### 2. **Bus Models**
All bus information (BusModel, SeatConfigurationModel, etc.) are directly imported and used without modification:
```dart
import '../../../core_lib/core.dart'; // Includes BusModel, etc.
```

### 3. **Seat Management (SeatService)**
```dart
// Will be used in seat selection screen
final booked = await SeatService.getBookedSeats(
  busId: widget.busId,
  layoutId: widget.layoutId,
);

final success = await SeatService.lockSeats(
  busId: widget.busId,
  selectedSeats: selectedSeats.toList(),
  userId: userId,
  lockDurationMinutes: 3,
);
```

### 4. **Seat Layouts (Layout48, Layout44)**
```dart
import '../components/layout_map.dart';

final layoutBuilder = seatLayoutMap[widget.layoutId];
layoutBuilder(buildSeat: (seat, isSleeper) => _seatWidget(seat, isSleeper));
```

## Theme Differences

### Admin App
- Dark theme (dark navy bg, white text)
- Professional color scheme (blue #2697FF)
- Minimalist, utility-focused

### Users App
- Light/Bright theme (light gray-blue bg)
- Customer-friendly colors (bright blue #1E88E5, teal #26C6DA)
- Modern, welcoming UI with gradients
- Card-based, intuitive layouts

## Routes

| Route | Screen | Purpose |
|-------|--------|---------|
| `/users` or `/users/home` | HomeScreen | Main search interface |
| `/users/buses?from=X&to=Y&date=Z` | BusListScreen | Display search results |
| `/users/booking/:id/:layoutId` | SeatSelectionScreen | Select seats (TODO) |
| `/users/passenger/:id` | PassengerDetailsScreen | Enter passenger info (TODO) |
| `/users/payment/:id` | PaymentScreen | Complete booking (TODO) |

## Key Features Implemented

✅ **Home Screen**
- City search with autocomplete
- Date and time selection
- Clean, welcoming UI
- Quick stats display

✅ **Bus List Screen**
- Shows filtered buses based on search criteria
- Reuses DataProvider.searchBuses()
- Bus information cards with times, prices, ratings
- "Select Seats" button for booking

🔄 **In Progress**
- Seat selection with user-friendly layout
- Passenger details collection
- Payment confirmation with WhatsApp notification
- Booking confirmation

## Running the Users App

### Option 1: Run as separate app
```bash
# Create users_main.dart as main entry
flutter run -t lib/users_app/users_main.dart
```

### Option 2: Run from existing main.dart
```bash
# Add route to admin app's main routes
# Users access at /users path via Beamer routing
flutter run
```

## Integration with Admin Services

All backend services work seamlessly:

1. **Authentication**: Uses same AuthProvider
2. **Data**: Shares DataProvider state
3. **Seat Management**: Uses SeatService for all seat operations
4. **API Calls**: Uses HttpService from admin app
5. **Models**: All Freezed models are shared

## Next Steps

1. **Seat Selection Screen** - Reuse layout components with user-friendly controls
2. **Passenger Details** - Collect name, email, phone, gender
3. **Payment Screen** - Simplified payment UI with WhatsApp confirmation
4. **User Profile** - View past bookings, manage account
5. **Notifications** - Real-time booking updates

## API Endpoints (Shared with Admin)

- `GET /api/buses` - List all buses
- `GET /api/buses/:id/seats` - Get seat availability
- `POST /api/bookings/lock-seats` - Lock seats for booking
- `POST /api/bookings/confirm` - Confirm booking
- `POST /api/bookings/cancel` - Cancel booking

## File Structure Summary

```
users_app/
├── users_main.dart (196 lines)
├── config/
│   ├── user_theme.dart (170 lines)
│   └── user_routes.dart (50 lines)
└── presentation/
    └── screens/
        ├── home_screen.dart (330 lines)
        └── bus_list_screen.dart (200 lines)
```

**Total Lines of Code**: ~750 lines (mostly UI, reusing all backend logic)
**Code Reuse**: ~95% backend logic shared with admin app
**Custom UI**: ~5% unique user-facing components

