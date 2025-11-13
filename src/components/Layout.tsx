import { ReactNode } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { motion } from 'framer-motion';
import { useStore } from '@/store';

interface LayoutProps {
  children: ReactNode;
}

const navItems = [
  { path: '/', label: 'Dashboard', icon: '🏠' },
  { path: '/tasks', label: 'Tasks', icon: '✅' },
  { path: '/analytics', label: 'Analytics', icon: '📊' },
  { path: '/settings', label: 'Settings', icon: '⚙️' },
];

export function Layout({ children }: LayoutProps) {
  const location = useLocation();
  const { user, sidebarOpen, toggleSidebar } = useStore();

  return (
    <div className="min-h-screen bg-dark-900 flex">
      {/* Sidebar */}
      <motion.aside
        initial={false}
        animate={{ width: sidebarOpen ? 240 : 80 }}
        className="bg-dark-800 border-r border-dark-700 flex flex-col"
      >
        <div className="p-4 border-b border-dark-700">
          <button onClick={toggleSidebar} className="hover:text-primary-400 transition-colors">
            {sidebarOpen ? '←' : '→'}
          </button>
        </div>

        <nav className="flex-1 p-4 space-y-2">
          {navItems.map((item) => {
            const isActive = location.pathname === item.path;
            return (
              <Link
                key={item.path}
                to={item.path}
                className={`
                  flex items-center gap-3 px-3 py-2 rounded-funky-sm
                  transition-colors
                  ${isActive ? 'bg-primary-600 text-white' : 'hover:bg-dark-700 text-dark-300'}
                `}
              >
                <span className="text-xl">{item.icon}</span>
                {sidebarOpen && <span>{item.label}</span>}
              </Link>
            );
          })}
        </nav>

        {sidebarOpen && user && (
          <div className="p-4 border-t border-dark-700 text-sm text-dark-400">
            {user.email}
          </div>
        )}
      </motion.aside>

      {/* Main content */}
      <main className="flex-1 overflow-y-auto">
        <div className="container mx-auto p-6 max-w-7xl">
          {children}
        </div>
      </main>
    </div>
  );
}
