# Local Service Booking Website

A high-converting service booking website designed for local business owners (roofers, remodelers, cleaners, HVAC, and home-service providers) to book Google Ads service appointments instantly via WhatsApp and calendar booking.

## Features

✅ **One-Click WhatsApp Integration** - Instant communication with potential clients
✅ **Automated Appointment Scheduling** - Calendar integration ready
✅ **Clear Service Breakdown** - Google Ads setup, optimization, and management
✅ **Social Proof Section** - Testimonials and results from real businesses
✅ **Pain-Point-Based Copywriting** - Tailored messaging for local businesses
✅ **Transparent Pricing** - Three tier plans with clear value propositions
✅ **Lead Capture Form** - For those who prefer not to book instantly
✅ **Mobile-First Design** - Optimized for local business owners on-the-go
✅ **Fast Loading** - Optimized for performance
✅ **Modern UI/UX** - Beautiful gradients, animations, and responsive design

## Quick Start

### 1. Setup Configuration

Open `script.js` and update the configuration:

```javascript
const CONFIG = {
    // Your WhatsApp Business Number (include country code, no + or spaces)
    whatsappNumber: '15551234567', // Example: '15551234567' for US

    // Default WhatsApp message
    whatsappMessage: 'Hi! I\'m interested in booking a Google Ads strategy session for my local business.',

    // Form submission endpoint
    formEndpoint: 'https://formspree.io/f/your-form-id',

    // Email for notifications
    email: 'info@localadspro.com'
};
```

### 2. WhatsApp Integration

**How to get your WhatsApp number:**
1. Use your WhatsApp Business number
2. Include country code (e.g., US: 1, UK: 44, etc.)
3. Remove all spaces, dashes, and the + sign
4. Example: +1 (555) 123-4567 becomes `15551234567`

### 3. Form Integration

Choose one of these form services:

**Option A: Formspree (Easiest)**
1. Go to [formspree.io](https://formspree.io)
2. Create a free account
3. Create a new form
4. Copy your form endpoint (e.g., `https://formspree.io/f/xrbzgwyz`)
5. Update `CONFIG.formEndpoint` in `script.js`

**Option B: Custom Backend**
- Update the `formEndpoint` to point to your API endpoint
- The form sends data as `FormData` via POST request

### 4. Calendar Integration

The website has a placeholder for calendar booking. Integrate one of these services:

**Recommended Calendar Services:**

**Calendly (Most Popular)**
1. Sign up at [calendly.com](https://calendly.com)
2. Create your booking page
3. Get the embed code
4. Replace the `.calendar-placeholder` section in `index.html` with:

```html
<!-- Calendly inline widget begin -->
<div class="calendly-inline-widget" data-url="https://calendly.com/your-username" style="min-width:320px;height:630px;"></div>
<script type="text/javascript" src="https://assets.calendly.com/assets/external/widget.js" async></script>
<!-- Calendly inline widget end -->
```

**Cal.com (Open Source Alternative)**
1. Sign up at [cal.com](https://cal.com)
2. Create your event type
3. Get the embed code
4. Replace the calendar placeholder section

**Book Like A Boss**
1. Sign up at [booklikeaboss.com](https://booklikeaboss.com)
2. Follow their integration guide

### 5. Google Analytics (Optional)

Add Google Analytics to track conversions:

1. Get your Google Analytics tracking code
2. Add before the closing `</head>` tag in `index.html`:

```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

## File Structure

```
.
├── index.html          # Main HTML file
├── styles.css          # All styling (mobile-first)
├── script.js           # JavaScript functionality
└── README.md           # This file
```

## Customization Guide

### Change Brand Colors

Edit CSS variables in `styles.css`:

```css
:root {
    --primary-color: #25D366;      /* WhatsApp green */
    --secondary-color: #0066FF;    /* Brand blue */
    --success: #10B981;            /* Success green */
    /* ... more colors ... */
}
```

### Update Business Information

**Contact Information** - Edit the footer section in `index.html`:
```html
<li><i class="fas fa-envelope"></i> your-email@domain.com</li>
<li><i class="fas fa-phone"></i> (555) 123-4567</li>
```

**Business Name** - Replace "LocalAds Pro" throughout the site

### Modify Pricing Plans

Edit the pricing section in `index.html` to match your actual pricing.

### Add Real Testimonials

Replace the placeholder testimonials with real customer reviews in the testimonials section.

## Deployment

### Option 1: Netlify (Recommended)

1. Create account at [netlify.com](https://netlify.com)
2. Drag and drop your project folder
3. Your site is live!

### Option 2: Vercel

1. Create account at [vercel.com](https://vercel.com)
2. Import your Git repository or upload files
3. Deploy!

### Option 3: GitHub Pages

1. Push code to GitHub repository
2. Go to Settings → Pages
3. Select branch to deploy
4. Your site will be at `https://username.github.io/repo-name`

### Option 4: Traditional Hosting

Upload all files via FTP to your web hosting provider (cPanel, etc.)

## Performance Optimization

The website is already optimized for speed:

✅ Minimal external dependencies
✅ CSS and JS are minified in production
✅ Images are placeholders (replace with optimized images)
✅ Mobile-first responsive design
✅ Lazy loading ready

### Add Real Images

Replace the placeholder sections with real images:

1. Use high-quality stock photos from:
   - [Unsplash](https://unsplash.com) - Free
   - [Pexels](https://pexels.com) - Free
   - [Shutterstock](https://shutterstock.com) - Paid

2. Optimize images before uploading:
   - Use [TinyPNG](https://tinypng.com) for compression
   - Recommended format: WebP or optimized JPG
   - Max width: 1920px for hero images, 800px for others

3. Replace `.hero-image-placeholder` with actual image

## Browser Support

✅ Chrome (latest)
✅ Firefox (latest)
✅ Safari (latest)
✅ Edge (latest)
✅ Mobile browsers (iOS Safari, Chrome Mobile)

## Troubleshooting

**WhatsApp button doesn't work**
- Make sure the phone number is correct (country code + number, no spaces)
- Test on mobile device
- Check browser console for errors

**Form not submitting**
- Verify the `formEndpoint` is correct
- Check network tab in browser dev tools
- Make sure form service (Formspree, etc.) is configured

**Styling looks broken**
- Clear browser cache
- Make sure `styles.css` is in the same folder as `index.html`
- Check browser console for 404 errors

## SEO Optimization

The website includes basic SEO:
- Meta descriptions
- Semantic HTML
- Mobile-friendly
- Fast loading

**Additional SEO Steps:**
1. Add Google Search Console
2. Create a sitemap.xml
3. Add schema markup for LocalBusiness
4. Optimize images with alt text
5. Add more content/blog posts

## Legal Requirements

Before going live, add:
- Privacy Policy page
- Terms of Service page
- Cookie consent (if in EU/UK - GDPR)
- Disclaimer about Google Ads results

## Support & Customization

This is a template website ready for deployment. Customize it to match your brand and services.

**Need help?** Common customization services:
- Custom design modifications
- Advanced features (CRM integration, payment processing)
- Backend development
- Ongoing maintenance

## License

This project is provided as-is for commercial use. Feel free to modify and use for your business.

## Next Steps

1. ✅ Update WhatsApp number in `script.js`
2. ✅ Configure form submission endpoint
3. ✅ Integrate calendar booking service
4. ✅ Replace placeholder content with real information
5. ✅ Add real customer testimonials
6. ✅ Add real images (optimized)
7. ✅ Set up Google Analytics
8. ✅ Deploy to hosting
9. ✅ Test on multiple devices
10. ✅ Start driving traffic and booking appointments!

---

**Built with ❤️ for local service business owners**

Need help getting this live? The setup takes less than 30 minutes!
