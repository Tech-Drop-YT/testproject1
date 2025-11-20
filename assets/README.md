# Assets Directory

This directory contains the assets for the Solvex calculator app.

## Required Assets

### App Icon
- **File**: `app_icon.png`
- **Size**: 1024x1024 pixels
- **Format**: PNG with transparency
- **Design**: Calculator icon with Electric Blue (#2962FF) color scheme
- **Description**: A modern, minimalist calculator icon

### App Icon Foreground (Adaptive Icon for Android)
- **File**: `app_icon_foreground.png`
- **Size**: 1024x1024 pixels
- **Format**: PNG with transparency
- **Design**: The foreground layer for Android adaptive icons

### Splash Screen Logo
- **File**: `splash_logo.png`
- **Size**: 512x512 pixels
- **Format**: PNG with transparency
- **Design**: Solvex logo or calculator icon
- **Background**: Electric Blue (#2962FF)

## How to Generate Assets

1. **Create the icon designs** using design tools like Figma, Adobe Illustrator, or Canva
2. **Place the images** in this directory with the exact names mentioned above
3. **Run the following commands** to generate platform-specific assets:

```bash
# Generate splash screen
flutter pub run flutter_native_splash:create

# Generate app icons
flutter pub run flutter_launcher_icons
```

## Design Guidelines

- Use Electric Blue (#2962FF) as the primary brand color
- Keep designs minimal and modern
- Ensure icons are clear and recognizable at small sizes
- Use vector graphics when possible for scalability
