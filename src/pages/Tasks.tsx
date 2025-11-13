import { Card } from '@/components/ui/Card';
import { Button } from '@/components/ui/Button';

export function Tasks() {
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-4xl font-bold">Tasks</h1>
        <Button>+ New Task</Button>
      </div>

      <Card padding="lg">
        <div className="text-center py-12 text-dark-400">
          <p className="text-6xl mb-4">📝</p>
          <p>Task management coming soon!</p>
          <p className="text-sm mt-2">Full task CRUD, filtering, and quick add will be implemented here.</p>
        </div>
      </Card>
    </div>
  );
}
