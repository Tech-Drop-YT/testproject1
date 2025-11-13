import { useState } from 'react';
import { Button } from '@/components/ui/Button';
import { Card } from '@/components/ui/Card';
import { authApi } from '@/services/api';
import { motion } from 'framer-motion';

export function Login() {
  const [email, setEmail] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [message, setMessage] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    setMessage('');

    const { error } = await authApi.signInWithMagicLink(email);

    if (error) {
      setMessage('Error sending magic link. Please try again.');
    } else {
      setMessage('Check your email for the magic link!');
    }

    setIsLoading(false);
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-primary-900 via-dark-900 to-secondary-900 p-4">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="w-full max-w-md"
      >
        <div className="text-center mb-8">
          <h1 className="text-5xl font-bold gradient-text mb-2">SparkFlow</h1>
          <p className="text-dark-300">Never give up. Track, learn, grow.</p>
        </div>

        <Card variant="glass" padding="lg">
          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label htmlFor="email" className="block text-sm font-medium mb-2">
                Email Address
              </label>
              <input
                id="email"
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
                className="w-full px-4 py-2 rounded-funky-sm bg-dark-800 border border-dark-700 focus:border-primary-500 focus:ring-2 focus:ring-primary-500"
                placeholder="you@example.com"
              />
            </div>

            <Button type="submit" fullWidth isLoading={isLoading}>
              Send Magic Link
            </Button>

            {message && (
              <p className={`text-sm text-center ${message.includes('Error') ? 'text-red-400' : 'text-success-400'}`}>
                {message}
              </p>
            )}
          </form>

          <div className="mt-6 text-sm text-dark-400 text-center">
            <p>Note: Supabase must be configured in .env</p>
            <p className="mt-2">For demo: Use any email to see the UI</p>
          </div>
        </Card>
      </motion.div>
    </div>
  );
}
