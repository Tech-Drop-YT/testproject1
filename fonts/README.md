# Font Assets

Place the following font files in this directory:

## Required Files

- `Poppins-Regular.ttf` - Regular weight font
- `Poppins-Bold.ttf` - Bold weight font

## Recommended Font: Poppins

Poppins is a clean, modern geometric sans-serif font that works great for game UIs.

### Download Poppins

**Google Fonts (Free & Open Source):**
- Visit: https://fonts.google.com/specimen/Poppins
- Click "Download family"
- Extract the ZIP file
- Copy `Poppins-Regular.ttf` and `Poppins-Bold.ttf` to this directory

### Alternative Fonts

If you prefer a different font, you can use any TTF font files. Good alternatives:

- **Roboto** - Modern, clean, highly readable
- **Montserrat** - Geometric, professional
- **Open Sans** - Friendly, legible
- **Raleway** - Elegant, thin letters
- **Nunito** - Rounded, friendly

## Installation

1. Download your chosen font family
2. Copy the TTF files to this directory
3. If using a different font than Poppins:
   - Update `pubspec.yaml` font family name
   - Replace file names in fonts section

## License

**Poppins Font:**
- License: SIL Open Font License (OFL)
- Free for personal and commercial use
- No attribution required
- Font by Indian Type Foundry, Jonny Pinhorn

## Format Requirements

- **Format:** TrueType Font (.ttf) or OpenType Font (.otf)
- **Encoding:** Unicode
- **Weights Needed:**
  - Regular (400)
  - Bold (700)

## Notes

- The app will use system default font if custom fonts are missing
- Font files must match names in `pubspec.yaml`
- TTF format is recommended for best compatibility
- Keep font files under 1MB each for optimal performance
