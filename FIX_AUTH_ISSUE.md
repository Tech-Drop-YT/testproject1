# Fix Supabase Magic Link Authentication Issue

## Problem
Magic link redirects back to login page instead of completing authentication.

## Solution

### 1. Configure Supabase Site URL

1. Go to your Supabase Dashboard
2. Navigate to **Authentication** → **URL Configuration**
3. Set the following:

   **Site URL**: `http://localhost:5173`
   
   **Redirect URLs**: Add these (one per line):
   ```
   http://localhost:5173
   http://localhost:5173/**
   http://localhost:5173/auth/callback
   ```

### 2. Disable Email Confirmation (Development Only)

1. In Supabase Dashboard, go to **Authentication** → **Providers**
2. Click on **Email** provider
3. Scroll down to **Email Confirmation**
4. **Disable** "Enable email confirmations"
5. Click **Save**

⚠️ **Important**: In production, you should enable email confirmation for security.

### 3. Clear Browser Data

After making the above changes:
1. Clear your browser cache and cookies
2. Close all browser tabs with the app
3. Restart the dev server: `npm run dev`
4. Try logging in again

### 4. Test the Flow

1. Enter your email address
2. Check your email for the magic link
3. Click the magic link
4. You should now be redirected to the onboarding/dashboard

## Still Not Working?

Check the browser console (F12) for errors. Common issues:

- **CORS errors**: Make sure Site URL matches exactly
- **Session errors**: Clear localStorage and try again
- **Network errors**: Check if Supabase project is active

## Alternative: Test Without Email

For quick testing during development, you can temporarily modify the Login component to skip auth:

```typescript
// In src/pages/Login.tsx
// Add this at the top of the Login component for testing only:
useEffect(() => {
  // TEMPORARY: Auto-login for development
  useStore.setState({ 
    isAuthenticated: true,
    user: { 
      id: 'test-user',
      email: 'test@example.com',
      onboarding_completed: false 
    } as any 
  });
}, []);
```

⚠️ **Remove this before production!**
