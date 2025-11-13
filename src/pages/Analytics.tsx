import { Card } from '@/components/ui/Card';

export function Analytics() {
  return (
    <div className="space-y-6">
      <h1 className="text-4xl font-bold">Analytics</h1>

      <Card padding="lg">
        <div className="text-center py-12 text-dark-400">
          <p className="text-6xl mb-4">📊</p>
          <p>Analytics dashboard coming soon!</p>
          <p className="text-sm mt-2">Charts with Recharts showing time-of-day heatmaps, weekly summaries, and more.</p>
        </div>
      </Card>
    </div>
  );
}
