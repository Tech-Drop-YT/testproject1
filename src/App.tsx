/**
 * SparkFlow Main Application Component
 */

import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { useEffect } from 'react';
import { useStore } from './store';
import { authApi } from './services/api';

// Pages (to be implemented)
import { Dashboard } from './pages/Dashboard';
import { Tasks } from './pages/Tasks';
import { Analytics } from './pages/Analytics';
import { Settings } from './pages/Settings';
import { Login } from './pages/Login';

// Layout (to be implemented)
import { Layout } from './components/Layout';
import { Onboarding } from './components/Onboarding';

function App() {
  const { isAuthenticated, showOnboarding, setUser, setOnlineStatus } = useStore();

  // Initialize auth listener
  useEffect(() => {
    const subscription = authApi.onAuthStateChange((user) => {
      setUser(user);
    });

    // Initialize with current user
    authApi.getCurrentUser().then((user) => {
      setUser(user);
    });

    return () => {
      if (subscription && typeof subscription.unsubscribe === 'function') {
        subscription.unsubscribe();
      }
    };
  }, [setUser]);

  // Monitor online/offline status
  useEffect(() => {
    const handleOnline = () => setOnlineStatus(true);
    const handleOffline = () => setOnlineStatus(false);

    window.addEventListener('online', handleOnline);
    window.addEventListener('offline', handleOffline);

    return () => {
      window.removeEventListener('online', handleOnline);
      window.removeEventListener('offline', handleOffline);
    };
  }, [setOnlineStatus]);

  if (!isAuthenticated) {
    return <Login />;
  }

  if (showOnboarding) {
    return <Onboarding />;
  }

  return (
    <Router>
      <Layout>
        <Routes>
          <Route path="/" element={<Dashboard />} />
          <Route path="/tasks" element={<Tasks />} />
          <Route path="/analytics" element={<Analytics />} />
          <Route path="/settings" element={<Settings />} />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      </Layout>
    </Router>
  );
}

export default App;
