
# OpenWeather iOS App — Detailed Technical Specification (Codex Prompt)

You are a **Senior iOS Engineer**. Build a production-grade SwiftUI iOS app using **OpenWeather** (OpenWeatherMap) public APIs. This document is a **self-contained technical spec**: implement the app without reading OpenWeather documentation.

The app must showcase:
- SwiftUI + async/await networking
- Clean Architecture (Domain/Data/Presentation/Core)
- Router-driven navigation (no `NavigationLink`)
- Feature modularization (each screen is an independent module)
- DI (container + builders/factories)
- `@MainActor` ViewModels
- Robust networking: typed errors, decoding, retries/backoff for transient failures, cancellation, request deduping

---

## 1) Non-Functional Requirements

### Platforms
- iOS 17+ (SwiftUI, `NavigationStack` recommended)

### Localization & Units
- Default language: device locale (pass `lang`)
- Default units: metric (pass `units=metric`)
- Provide settings to switch between `metric`, `imperial`, `standard` (Kelvin) for temperature units.  [oai_citation:0‡openweathermap.org](https://openweathermap.org/current)

### API Key
- Use an app configuration abstraction:
  - `WeatherAPIConfig` protocol with `apiKey`, `baseURLWeather`, `baseURLGeo`
  - Implementation reads API key from a Swift constant (placeholder string) so code compiles without secrets.
- If API key is missing/empty, show an in-app error screen state explaining that the key is required.

### Rate Limits / Errors
- Handle:
  - HTTP 401 (invalid key)
  - HTTP 429 (too many requests)
  - 5xx (server)
  - decoding errors
  - offline / timeouts
- Add a simple retry policy for transient errors (e.g., 5xx, timeout) with exponential backoff; never retry 401.

---

## 2) App Screens (4 modules)

The app has **4 screens**, each as a **separate independent module**. Views are passive and send events only to ViewModels. Navigation is driven solely by Router.

### Global Navigation Map
- App starts at **Home (Current Weather)**.
- From Home:
  - Tap “Search” → **Location Search**
  - Tap “Forecast” → **Forecast**
  - Tap “Air Quality” → **Air Quality**
  - Tap “Settings” → **Settings**
- From Location Search:
  - Selecting a location sets it as “current location” and returns to Home.
- Back navigation:
  - Always performed by Router, triggered by ViewModel calling router methods.

---

## 3) UI/UX Design Spec

### Visual Style
- Overall: modern minimal iOS, large typography, clear hierarchy, generous spacing.
- Use a **top gradient background** that changes by primary weather group:
  - Clear → bright gradient
  - Clouds → muted gray-blue
  - Rain/Drizzle → deep blue
  - Snow → pale blue/white
  - Thunderstorm → dark purple
- Content in **cards** with blur/material backgrounds (`.ultraThinMaterial`) and rounded corners (16–20).
- Use SF Symbols for UI buttons; use OpenWeather icons for condition.

### Common Components
- `PrimaryButton` (filled, full-width)
- `SecondaryButton` (outlined)
- `MetricChip` or segmented control (units in Settings)
- `InfoRow` component: label/value with optional icon
- Skeleton loading state for cards (redacted placeholders)

### Accessibility
- Dynamic Type friendly
- Minimum tap targets 44x44
- VoiceOver labels for key values (temperature, AQI)

---

## 4) OpenWeather API Integration (Required Endpoints)

All requests include:
- `appid={API_KEY}`  [oai_citation:1‡openweathermap.org](https://openweathermap.org/current)
- optional `units={metric|imperial|standard}` (where applicable)  [oai_citation:2‡openweathermap.org](https://openweathermap.org/current)
- optional `lang={language_code}` (where applicable)  [oai_citation:3‡openweathermap.org](https://openweathermap.org/current)

> Note: Some docs show `http://...` for certain endpoints. In the app, use **HTTPS** wherever possible.

---

### 4.1 Geocoding (Location Search Screen)

#### Endpoint: Direct Geocoding
**GET** `https://api.openweathermap.org/geo/1.0/direct`

Query parameters:  [oai_citation:4‡openweathermap.org](https://openweathermap.org/api/geocoding-api)
- `q` (required): `"{city},{state_code},{country_code}"`
  - Minimal input: city name alone is valid.
- `limit` (optional): max results, up to 5
- `appid` (required)

Example:
- `/geo/1.0/direct?q=London&limit=5&appid=...`  [oai_citation:5‡openweathermap.org](https://openweathermap.org/api/geocoding-api)

Response: JSON array of locations. Each item may contain:  [oai_citation:6‡openweathermap.org](https://openweathermap.org/api/geocoding-api)
- `name`: city/area name
- `lat`: latitude
- `lon`: longitude
- `country`: ISO 3166 country code
- `state`: (sometimes present, e.g. US)
- `local_names`: dictionary of localized names (optional)

**UI usage**
- Show results list items as:
  - Primary: `name`
  - Secondary: `state (if present)`, `country`
  - Tertiary: `lat, lon` (small caption)

---

### 4.2 Current Weather (Home Screen)

#### Endpoint: Current Weather by coordinates
**GET** `https://api.openweathermap.org/data/2.5/weather`  [oai_citation:7‡openweathermap.org](https://openweathermap.org/current)

Query parameters:  [oai_citation:8‡openweathermap.org](https://openweathermap.org/current)
- `lat` (required)
- `lon` (required)
- `appid` (required)
- `units` (optional): `standard|metric|imperial`
- `lang` (optional)

Key response fields to map into UI:  [oai_citation:9‡openweathermap.org](https://openweathermap.org/current)
- `name`: location name
- `timezone`: shift in seconds from UTC
- `dt`: data timestamp (unix UTC)
- `weather[0]` (primary condition):
  - `id`, `main`, `description`, `icon`
- `main`:
  - `temp`, `feels_like`, `temp_min`, `temp_max`
  - `pressure` (hPa), `humidity` (%)
- `wind`:
  - `speed`, `deg`, optional `gust`
- `clouds.all` (%)
- optional precipitation:
  - `rain.1h` (mm), `snow.1h` (mm) (may be absent)
- `sys.sunrise`, `sys.sunset` (unix UTC)

#### Weather Icon
Use `weather[0].icon` to build icon URL:
- `https://openweathermap.org/img/wn/{icon}@2x.png`  [oai_citation:10‡openweathermap.org](https://openweathermap.org/weather-conditions)

Example: icon `"10d"` → `.../10d@2x.png`  [oai_citation:11‡openweathermap.org](https://openweathermap.org/weather-conditions)

---

### 4.3 Forecast (Forecast Screen)

#### Endpoint: 5 day / 3 hour forecast
**GET** `https://api.openweathermap.org/data/2.5/forecast`  [oai_citation:12‡openweathermap.org](https://openweathermap.org/forecast5)

Query parameters:  [oai_citation:13‡openweathermap.org](https://openweathermap.org/forecast5)
- `lat` (required) and `lon` (required) OR `q` (city name)
- `appid` (required)
- `units` (optional)
- `lang` (optional)
- `cnt` (optional): number of returned timestamps

Response (important fields):  [oai_citation:14‡openweathermap.org](https://openweathermap.org/forecast5)
- `list`: array of forecast entries at 3-hour steps
  - `dt` (unix UTC)
  - `dt_txt` (string timestamp)
  - `main.temp`, `main.feels_like`, `main.humidity`, `main.pressure`
  - `weather[0].main`, `weather[0].description`, `weather[0].icon`
  - `wind.speed`, `wind.deg`, optional `wind.gust`
  - `clouds.all`
  - `pop` probability of precipitation (0–1)
  - optional precipitation objects may appear depending on conditions
- `city`:
  - `name`, `country`, `timezone`, `sunrise`, `sunset`, `coord.lat/lon`

**UI usage**
- Group forecast entries by **local day** using `city.timezone`.
- Show a list of **day sections** (e.g., Today, Tomorrow, Day+2…).
- Each day section contains horizontally scrollable cards for each 3-hour entry:
  - Time (local)
  - Icon
  - Temperature
  - Description (short)
  - `pop` as percent
  - Wind speed

---

### 4.4 Air Quality (Air Quality Screen)

#### Endpoint: Current Air Pollution
**GET** `https://api.openweathermap.org/data/2.5/air_pollution`  [oai_citation:15‡openweathermap.org](https://openweathermap.org/api/air-pollution)

Query parameters:  [oai_citation:16‡openweathermap.org](https://openweathermap.org/api/air-pollution)
- `lat` (required)
- `lon` (required)
- `appid` (required)

Response fields (important):  [oai_citation:17‡openweathermap.org](https://openweathermap.org/api/air-pollution)
- `list[0].dt` unix UTC
- `list[0].main.aqi`: integer 1..5:
  - 1 = Good
  - 2 = Fair
  - 3 = Moderate
  - 4 = Poor
  - 5 = Very Poor  [oai_citation:18‡openweathermap.org](https://openweathermap.org/api/air-pollution)
- `list[0].components` concentrations (μg/m³):
  - `co`, `no`, `no2`, `o3`, `so2`, `pm2_5`, `pm10`, `nh3`  [oai_citation:19‡openweathermap.org](https://openweathermap.org/api/air-pollution)

**UI usage**
- Display a prominent AQI badge with text label.
- Display key pollutants:
  - PM2.5, PM10, O3, NO2 (primary)
  - Others in expandable section
- Show “Last updated” using `dt` and location timezone.

Optional (nice-to-have): Air Pollution Forecast
- `https://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=...&lon=...&appid=...`  [oai_citation:20‡openweathermap.org](https://openweathermap.org/api/air-pollution)
- Show mini chart of AQI next 24 hours (hourly).

---

## 5) Detailed Screen Specifications

### Screen 1 — Home (Current Weather)
**Purpose:** Show current conditions for selected location + entry points to other screens.

#### Layout
- Top bar:
  - Left: location name (tap opens Location Search)
  - Right: Settings gear icon
- Hero card:
  - Big temperature
  - Weather icon + description
  - Feels like
- Secondary info grid (2 columns):
  - Humidity
  - Pressure
  - Wind speed + direction (deg to compass)
  - Cloudiness
- Sunrise/Sunset row:
  - local formatted time
- Bottom action row (3 buttons):
  - Forecast
  - Air Quality
  - Refresh

#### States
- **Idle** (no location): show onboarding card “Select a city”
- **Loading**: skeleton placeholders
- **Loaded**: show data
- **Error**:
  - error title + message
  - Retry button
  - If 401: show “API key invalid/missing”
  - If offline: show “No internet connection”

#### Events (View → ViewModel)
- `onAppear()`
- `searchTapped()`
- `forecastTapped()`
- `airQualityTapped()`
- `settingsTapped()`
- `refreshPulled()` (pull to refresh)
- `retryTapped()`

#### Behavior
- `onAppear()` loads last selected location from a `PreferencesStore` protocol.
- If location exists, fetch current weather.
- Tapping location name or search icon routes to Location Search.
- Tapping Forecast routes to Forecast screen (uses same current location).
- Tapping Air Quality routes to Air Quality screen (same current location).

---

### Screen 2 — Location Search
**Purpose:** Search and select a location using Geocoding API, manage favorites/recents.

#### Layout
- Search bar (text field) with debounce (e.g., 300–500 ms)
- Results list:
  - Each row: name + (state) + country; small lat/lon caption
- Recents section (if any)
- Favorites section (if any)
- Bottom:
  - “Use Current Location” button (optional if you implement CoreLocation; if not, omit)

#### API interactions
- On text change after debounce:
  - call Geocoding direct endpoint with `limit=5`
- Show progress indicator during search.

#### User actions
- Tap a result:
  - Save as “current location”
  - Add to recents
  - Router dismisses back to Home
- Swipe actions on favorites/recents:
  - “Favorite” / “Unfavorite”
  - “Remove”

#### States
- Empty query → show recents/favorites only
- Searching → show spinner
- No results → show empty state
- Error → show inline error with Retry

#### Events (View → ViewModel)
- `onAppear()`
- `queryChanged(text:)`
- `resultTapped(locationId:)` (or `locationSelected(location:)`)
- `favoriteToggled(locationId:)`
- `removeRecentTapped(locationId:)`
- `backTapped()`
- `retrySearchTapped()`

---

### Screen 3 — Forecast
**Purpose:** Show 5-day forecast with 3-hour granularity grouped by day.

#### Layout
- Top bar:
  - Title: “Forecast”
  - Subtitle: current location name
  - Right: refresh icon
- Content:
  - Vertical list of day sections
  - Each day section:
    - Day header (Today/Tomorrow or date)
    - Horizontal scroll of 3-hour cards:
      - Time
      - Icon
      - Temp
      - Description
      - Precipitation probability (pop%)
      - Wind speed

#### Behavior
- On appear:
  - fetch 5-day/3-hour forecast by lat/lon for current location
- Grouping:
  - Convert each `dt` to local time using `city.timezone`
  - Group by calendar day in that timezone
- Pull to refresh triggers re-fetch.

#### States
- Loading / Loaded / Error / Empty (if no location selected)

#### Events
- `onAppear()`
- `refreshTapped()`
- `pullToRefresh()`
- `backTapped()`

---

### Screen 4 — Air Quality
**Purpose:** Show current AQI + pollutant breakdown.

#### Layout
- Top bar: “Air Quality” + location subtitle
- AQI hero card:
  - Big AQI number (1–5)
  - Label (Good/Fair/Moderate/Poor/Very Poor)
  - Last updated time (local)
- Pollutants card:
  - PM2.5, PM10, O3, NO2 in a grid with μg/m³ units
- Expandable “More pollutants” section:
  - CO, SO2, NH3, NO

Optional (if you implement forecast endpoint):
- “Next 24 hours” mini chart of AQI (hourly)

#### States
- Loading / Loaded / Error / Empty (if no location)

#### Events
- `onAppear()`
- `refreshTapped()`
- `backTapped()`

---

### Screen 5 (Optional) — Settings
If you implement 4 screens only, Settings may be a sheet/route that still counts as a screen module. If you implement it, it is the 4th screen and you can remove Air Quality as 4th; however the preferred set is Home + Search + Forecast + Air Quality + Settings (5).  
**For this spec, implement Settings as the 4th screen OR as a modal within Router while still being a module.**

#### Settings content
- Units:
  - Segmented control: Metric / Imperial / Standard  [oai_citation:21‡openweathermap.org](https://openweathermap.org/current)
- Language:
  - Toggle “Use device language”
  - Optional override: language code text field
- Cache:
  - Toggle “Cache responses” (URLCache or custom)
  - Button “Clear cache”
- About:
  - “Data by OpenWeather” label

#### Behavior
- Changing units triggers:
  - Save preference
  - On dismiss, Home re-fetches current weather
  - Forecast & Air Quality re-fetch on next appear (or via shared event bus—prefer explicit reload triggers via Router)

---

## 6) Data & Domain Models (Required)

### Core domain models
- `Location`:
  - `id` (derived stable id: e.g. "\(lat),\(lon),\(name),\(country)" hashed)
  - `name`, `country`, optional `state`
  - `latitude`, `longitude`
- `CurrentWeather`:
  - `temperature`, `feelsLike`, `minTemp`, `maxTemp`
  - `conditionMain`, `conditionDescription`, `iconId`
  - `humidity`, `pressure`
  - `windSpeed`, `windDegree`, `windGust?`
  - `cloudiness`
  - `rainLastHour?`, `snowLastHour?`
  - `sunrise`, `sunset`
  - `timestamp`, `timezoneOffset`
- `ForecastEntry`:
  - `timestamp`, `localDateTimeString`
  - `temp`, `feelsLike`
  - `description`, `iconId`
  - `popPercent`
  - `windSpeed`
- `AirQuality`:
  - `aqi` (1..5)
  - pollutants dictionary or typed properties:
    - `pm2_5`, `pm10`, `o3`, `no2`, `co`, `so2`, `nh3`, `no`
  - `timestamp`

### Domain use cases
- `SearchLocationsUseCase(query: String) async throws -> [Location]`
- `GetCurrentWeatherUseCase(location: Location, units: Units, lang: String?) async throws -> CurrentWeather`
- `GetForecastUseCase(location: Location, units: Units, lang: String?) async throws -> [ForecastEntry]`
- `GetAirQualityUseCase(location: Location) async throws -> AirQuality`
- `GetPreferencesUseCase`, `SavePreferencesUseCase`
- `GetLastSelectedLocationUseCase`, `SaveLastSelectedLocationUseCase`

Repository protocols (Domain)
- `GeocodingRepository`
- `WeatherRepository`
- `AirQualityRepository`
- `PreferencesStore`

---

## 7) Networking Implementation Requirements

### HTTP Client
- `HTTPClient` protocol with `send(_ request: URLRequest) async throws -> (Data, HTTPURLResponse)`
- `URLSessionHTTPClient` concrete implementation using `URLSession.data(for:)` async/await

### Endpoint / Request Builder
- `Endpoint` abstraction:
  - baseURL
  - path
  - method
  - query items
  - headers
- Central request builder:
  - adds `appid`
  - adds `units`/`lang` where needed
  - encodes query items safely

### Typed Errors
- `NetworkError`:
  - `invalidURL`
  - `transport(URLError)`
  - `httpStatus(code: Int, body: Data?)`
  - `decoding(Error)`
  - `cancelled`

### Caching
- Cache current weather and air quality for 5 minutes per location+units.
- Cache forecast for 30 minutes per location+units.
- Provide “Clear cache” in Settings.

---

## 8) Navigation & Router (Hard Requirements)

- No `NavigationLink`.
- Use `NavigationStack(path:)` and Router-owned `path`.
- Views never reference Router.
- ViewModels notify Router only via routing protocol.

Router responsibilities:
- Holds current location state (or via shared `AppState`), but do not leak it into Views.
- Builds modules via Builders (DI).
- Supports:
  - `showSearch()`
  - `showForecast()`
  - `showAirQuality()`
  - `showSettings()`
  - `dismiss()`
  - `setRootHome()` (optional)

---

## 9) Design Deliverables (What to Generate)

Generate:
- Full Swift file hierarchy according to your earlier Clean Architecture rules
- Implement 4 modules/screens described above
- Implement OpenWeather API clients + DTOs + mappers
- Implement DI container + module builders
- Implement Router navigation
- Implement mocked repositories for testing/demo mode

Output must be:
1) Folder tree
2) Then each Swift file with:
```swift
// File: Path/To/File.swift
<content>
```

## 10) Mandatory OpenWeather Endpoint Summary
    •    Geocoding search:
    •    GET /geo/1.0/direct?q=...&limit=...&appid=...  ￼
    •    Current weather:
    •    GET /data/2.5/weather?lat=...&lon=...&units=...&lang=...&appid=...  ￼
    •    Forecast 5-day / 3-hour:
    •    GET /data/2.5/forecast?lat=...&lon=...&units=...&lang=...&appid=...  ￼
    •    Air quality current:
    •    GET /data/2.5/air_pollution?lat=...&lon=...&appid=...  ￼
    •    Weather icon:
    •    https://openweathermap.org/img/wn/{icon}@2x.png
