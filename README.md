# 🚀 SparkFlow - Never Give Up

> **A fun, modern productivity dashboard for struggling freelancers**
> Track tasks, time, learning goals, and streaks with delightful animations and motivational support.

![SparkFlow](https://img.shields.io/badge/Status-Production_Ready-brightgreen)
![TypeScript](https://img.shields.io/badge/TypeScript-5.3-blue)
![React](https://img.shields.io/badge/React-18.2-61DAFB)
![License](https://img.shields.io/badge/License-MIT-yellow)

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Database Setup](#database-setup)
- [Development](#development)
- [Testing](#testing)
- [Deployment](#deployment)
- [Project Structure](#project-structure)

---

## 🌟 Overview

**SparkFlow** is a productivity tracker specifically designed for freelance digital marketers (Google Ads, Facebook Ads, SEO, WordPress) who struggle with consistency. The app's core mission: **never let the user give up**.

### Key Differentiators:
- **Gamification**: XP, levels, streaks, and badges
- **Motivational AI**: 150+ context-aware motivational messages
- **Micro-interactions**: Delightful animations with Framer Motion
- **Offline-first**: Works without internet, syncs when online
- **Freelancer-focused**: Pre-built templates for common freelance tasks

---

## ✨ Features

### Core Features
- ✅ Task Management (Standard tasks, habits, learning modules, projects)
- ✅ Pomodoro Timer (25/5 default, customizable)
- ✅ Learning Tracker with daily targets
- ✅ Streaks & Gamification (XP, levels, badges)
- ✅ 150 Motivational Messages (2 tones: energetic/conservative)
- ✅ Progress Visualization (Animated progress rings)
- ✅ Onboarding Flow
- ✅ Offline Support (LocalStorage + sync)
- ✅ Dark Mode with glassmorphism

---

## 🛠 Tech Stack

**Frontend**: React 18 + TypeScript + Vite + Tailwind CSS + Framer Motion + Zustand
**Backend**: Supabase (PostgreSQL, Auth, Real-time)
**Testing**: Jest + React Testing Library

---

## 📦 Prerequisites

- Node.js 18+
- npm or yarn
- Supabase account (free tier)

---

## 🚀 Quick Start

### 1. Clone & Install

```bash
git clone <your-repo-url>
cd testproject1
npm install
```

### 2. Environment Setup

```bash
cp .env.example .env
```

Edit `.env`:

```env
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key
```

### 3. Database Setup

1. Create project at [supabase.com](https://supabase.com)
2. Run `supabase/schema.sql` in SQL Editor
3. (Optional) Run `supabase/seed.sql` for demo data
4. Copy Project URL and anon key to `.env`

### 4. Start Dev Server

```bash
npm run dev
```

Open [http://localhost:5173](http://localhost:5173)

---

## 🗄 Database Setup

### Schema

The database includes 9 tables:
- `users`, `tasks`, `timers`, `learning_modules`
- `streaks`, `points_log`, `user_stats`
- `daily_summaries`, `task_templates`

### Apply Schema

```bash
# In Supabase SQL Editor
# Copy and paste supabase/schema.sql
```

### Seed Data (Optional)

```bash
# After creating a user via auth
# Run supabase/seed.sql in SQL Editor
```

---

## 💻 Development

### Available Scripts

```bash
npm run dev          # Start dev server
npm run build        # Build for production
npm run preview      # Preview production build
npm test             # Run tests
npm run test:watch   # Run tests in watch mode
npm run lint         # Lint code
npm run type-check   # TypeScript type checking
```

### Project Structure

```
src/
├── components/
│   ├── ui/              # Reusable components
│   ├── Layout.tsx
│   └── Onboarding.tsx
├── data/
│   └── motivation_bank.json  # 150 messages
├── lib/
│   └── supabase.ts
├── pages/
│   ├── Dashboard.tsx
│   ├── Tasks.tsx
│   ├── Analytics.tsx
│   └── Settings.tsx
├── services/
│   └── api.ts           # API layer
├── store/
│   └── index.ts         # Zustand store
├── types/
│   └── index.ts
├── utils/
│   ├── xpCalculator.ts
│   ├── quickAddParser.ts
│   ├── timeUtils.ts
│   ├── motivation.ts
│   └── notifications.ts
└── App.tsx
```

---

## 🧪 Testing

```bash
npm test                 # Run all tests
npm run test:watch       # Watch mode
npm test -- --coverage   # Coverage report
```

**Test Coverage**: Core utilities (XP calculator, quick add parser, time utils) have >80% coverage.

---

## 🚢 Deployment

### Deploy to Vercel

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel

# Add environment variables in Vercel dashboard:
# - VITE_SUPABASE_URL
# - VITE_SUPABASE_ANON_KEY
```

### Deploy to Netlify

1. Connect GitHub repo at [netlify.com](https://netlify.com)
2. Build command: `npm run build`
3. Publish directory: `dist`
4. Add environment variables
5. Deploy!

---

## 📁 Key Files

### Configuration
- `vite.config.ts` - Vite + PWA config
- `tailwind.config.js` - Theme tokens (primary, secondary, accent colors)
- `tsconfig.json` - TypeScript config with path aliases

### Data
- `src/data/motivation_bank.json` - 150 motivational messages
- `supabase/schema.sql` - Full PostgreSQL schema with RLS
- `supabase/seed.sql` - Demo data

### Core Utilities
- `src/utils/xpCalculator.ts` - XP/level logic (tested)
- `src/utils/quickAddParser.ts` - Natural language task parser (tested)
- `src/utils/timeUtils.ts` - Time formatting utilities (tested)

### Mascot
- `assets/MASCOT_PROMPTS.md` - SVG generation prompts for 4 mascot poses

---

## 🎨 Design System

### Colors
- Primary: Indigo `#6366f1`
- Secondary: Purple `#d946ef`
- Accent: Orange `#f97316`
- Success: Green `#22c55e`

### Animations
- Button hover: `scale(1.04)`
- Button press: `scale(0.98)`
- Card entrance: fade + slide
- Progress rings: elastic easing

---

## 🤝 Contributing

1. Fork the repo
2. Create feature branch (`git checkout -b feature/amazing`)
3. Commit changes
4. Push and open PR

---

## 📄 License

MIT License

---

## 🙏 Acknowledgments

- Supabase for backend infrastructure
- Vercel for deployments
- Tailwind CSS for styling
- Framer Motion for animations

---

**Built with ❤️ for freelancers who refuse to give up.**

**#NeverGiveUp #SparkFlow**