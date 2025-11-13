import { Card } from '@/components/ui/Card';
import { Button } from '@/components/ui/Button';
import { useStore } from '@/store';
import { authApi } from '@/services/api';

export function Settings() {
  const { user } = useStore();

  const handleLogout = async () => {
    await authApi.signOut();
    window.location.reload();
  };

  return (
    <div className="space-y-6">
      <h1 className="text-4xl font-bold">Settings</h1>

      <Card padding="lg">
        <h2 className="text-2xl font-bold mb-4">Account</h2>
        <div className="space-y-4">
          <div>
            <label className="block text-sm font-medium mb-1">Email</label>
            <div className="text-dark-400">{user?.email}</div>
          </div>
          <div>
            <label className="block text-sm font-medium mb-1">Name</label>
            <input
              type="text"
              defaultValue={user?.name || ''}
              className="w-full px-4 py-2 rounded-funky-sm bg-dark-800 border border-dark-700"
            />
          </div>
        </div>
      </Card>

      <Card padding="lg">
        <h2 className="text-2xl font-bold mb-4">Preferences</h2>
        <div className="space-y-4">
          <div>
            <label className="block text-sm font-medium mb-1">Motivation Mode</label>
            <select className="w-full px-4 py-2 rounded-funky-sm bg-dark-800 border border-dark-700">
              <option value="energetic">Energetic</option>
              <option value="conservative">Conservative</option>
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium mb-1">Pomodoro Duration (minutes)</label>
            <input
              type="number"
              defaultValue={25}
              className="w-full px-4 py-2 rounded-funky-sm bg-dark-800 border border-dark-700"
            />
          </div>
        </div>
      </Card>

      <Card padding="lg">
        <Button variant="danger" onClick={handleLogout}>
          Sign Out
        </Button>
      </Card>
    </div>
  );
}
