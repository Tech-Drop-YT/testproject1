# SparkFlow Demo Script

This script walks through setting up and running SparkFlow for the first time.

## Prerequisites

- Node.js 18+ installed
- Supabase account created
- Git installed

## Step 1: Clone and Install

```bash
# Clone the repository
git clone <your-repo-url>
cd sparkflow

# Install dependencies (this may take 2-3 minutes)
npm install
```

## Step 2: Set Up Supabase

### Create Supabase Project

1. Go to [supabase.com](https://supabase.com)
2. Click "New Project"
3. Enter project details:
   - Name: `sparkflow-demo`
   - Database Password: (save this securely)
   - Region: Choose closest to you
4. Wait for project to initialize (~2 minutes)

### Apply Database Schema

1. In Supabase dashboard, go to **SQL Editor**
2. Click "New Query"
3. Open `supabase/schema.sql` from this project
4. Copy the entire contents
5. Paste into SQL Editor
6. Click "Run" (bottom right)
7. You should see "Success. No rows returned"

### (Optional) Add Seed Data

1. Still in SQL Editor, click "New Query"
2. Open `supabase/seed.sql`
3. Copy and paste contents
4. Click "Run"
5. Note: You'll need to create a user first via the app

### Get API Credentials

1. In Supabase dashboard, go to **Settings** → **API**
2. Copy:
   - **Project URL** (looks like `https://xxx.supabase.co`)
   - **anon/public** key (long JWT token)

## Step 3: Configure Environment

```bash
# Create .env file from template
cp .env.example .env

# Edit .env file
nano .env  # or use your preferred editor

# Add your Supabase credentials:
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key-here
```

## Step 4: Start Development Server

```bash
# Start the dev server
npm run dev

# You should see:
# ➜  Local:   http://localhost:5173/
# ➜  Network: use --host to expose
```

Open [http://localhost:5173](http://localhost:5173) in your browser.

## Step 5: First-Time User Experience

### Login Flow

1. You'll see the SparkFlow login page
2. Enter your email address
3. Click "Send Magic Link"
4. Check your email for the magic link
5. Click the link to authenticate
6. You'll be redirected back to the app

### Onboarding Flow

After login, you'll go through 4 onboarding steps:

**Step 1: Welcome**
- Introduction to SparkFlow
- Click "Next"

**Step 2: Choose Focus Areas**
- Select skills: SEO, Google Ads, Facebook Ads, WordPress
- Click one or more
- Click "Next"

**Step 3: Set Daily Learning Goal**
- Drag slider to set minutes (default: 60)
- Click "Next"

**Step 4: Ready to Start**
- Click "Start SparkFlow"

### Dashboard Tour

After onboarding, you'll land on the Dashboard:

1. **Header**: Greeting + motivational message
2. **Quick Stats**: 4 cards showing streak, level, tasks today, XP
3. **Progress Rings**: Visual progress for focus time, learning, tasks, weekly score
4. **Today's Tasks**: Empty initially (add tasks to see them here)
5. **Timer Card**: Start a 25-minute Pomodoro session

## Step 6: Add Your First Task

### Quick Add (Placeholder - UI not fully wired yet)

In a complete implementation:
1. Click "Quick Add" button
2. Type: `Learn SEO 1h daily #marketing`
3. Press Enter
4. Task appears in "Today's Tasks"

### Manual Add (Future Feature)

Navigate to Tasks page:
1. Click "Tasks" in sidebar
2. Click "+ New Task"
3. Fill in details:
   - Title: "Learn SEO Basics"
   - Type: Learning
   - Time: 60 minutes
   - Priority: High
   - Tags: marketing, seo
4. Click "Save"

## Step 7: Start a Timer Session (Future Feature)

Complete implementation will:
1. Click "Start Timer" on Dashboard
2. Select task or "General Focus"
3. Choose mode: Pomodoro (25/5), Focus, or Learning
4. Timer counts down
5. Get motivational message when complete
6. Take a 5-minute break
7. Repeat!

## Step 8: Explore Other Pages

### Tasks Page
- View all tasks
- Filter by status, priority, tags
- Mark tasks complete
- See subtasks for projects

### Analytics Page
- Weekly/monthly summaries
- Time-of-day heatmap showing productive hours
- Top 3 learning topics
- Streak history chart
- Task completion trends

### Settings Page
- Update profile name
- Change motivation mode (energetic vs conservative)
- Customize Pomodoro durations
- Enable/disable notifications
- Export data
- Sign out

## Step 9: Test Gamification Features

### Complete a Task

1. Check off a task from "Today's Tasks"
2. See confetti animation 🎉
3. Earn points (displayed in toast)
4. Check your XP progress in Dashboard

### Build a Streak

1. Complete at least one task or learning session daily
2. Your streak counter increases
3. At 5, 10, 30 days, get bonus points
4. Unlock achievements

### Level Up

1. Accumulate XP by completing tasks
2. Higher difficulty tasks = more XP
3. Longer streaks = XP multiplier (up to 2x)
4. Watch level increase in Dashboard
5. Get celebratory animation on level up

## Step 10: Test Offline Mode

1. While app is open, turn off internet
2. Add tasks, complete tasks (they queue locally)
3. Turn internet back on
4. Changes sync automatically to Supabase

## Running Tests

```bash
# Run all tests
npm test

# You should see:
# PASS  src/utils/__tests__/xpCalculator.test.ts
# PASS  src/utils/__tests__/quickAddParser.test.ts
# PASS  src/utils/__tests__/timeUtils.test.ts
#
# Test Suites: 3 passed, 3 total
# Tests:       XX passed, XX total
```

## Building for Production

```bash
# Create production build
npm run build

# Preview production build locally
npm run preview

# Build output is in dist/
```

## Deploying to Vercel

```bash
# Install Vercel CLI
npm i -g vercel

# Login to Vercel
vercel login

# Deploy
vercel

# Follow prompts:
# - Set up and deploy? Yes
# - Which scope? (your account)
# - Link to existing project? No
# - Project name? sparkflow
# - Directory? ./
# - Override settings? No

# Add environment variables:
vercel env add VITE_SUPABASE_URL
# Paste your Supabase URL

vercel env add VITE_SUPABASE_ANON_KEY
# Paste your anon key

# Deploy to production
vercel --prod

# You'll get a production URL: https://sparkflow-xxx.vercel.app
```

## Troubleshooting

### "npm install" fails
- Ensure Node.js 18+ is installed: `node --version`
- Clear npm cache: `npm cache clean --force`
- Delete `node_modules` and try again

### "Cannot connect to Supabase"
- Check `.env` file exists and has correct values
- Ensure no trailing spaces in `.env`
- Restart dev server after changing `.env`

### Tests fail
- Run `npm install` again
- Check Node.js version compatibility
- See error messages for specific issues

### Build fails
- Run `npm run type-check` to find TypeScript errors
- Fix any type errors
- Run `npm run build` again

### App shows blank page
- Check browser console for errors (F12)
- Verify all environment variables are set
- Check Supabase project is active

## Next Steps

1. **Customize**: Update colors in `tailwind.config.js`
2. **Extend**: Add more task types, custom fields
3. **Integrate**: Connect Google Calendar, Slack, etc.
4. **Monetize**: Add premium features
5. **Scale**: Handle thousands of users

## Demo Data

If you want to see the app with data already populated:

1. Create a user via the login flow
2. Get the user ID from Supabase: `select id from auth.users;`
3. Update seed.sql with your user ID (replace `demo_user_id`)
4. Run the seed script
5. Refresh the app

Enjoy SparkFlow! Never give up! 🚀
