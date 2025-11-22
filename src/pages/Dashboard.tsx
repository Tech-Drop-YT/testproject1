import { Card } from '@/components/ui/Card';
import { ProgressRing } from '@/components/ui/ProgressRing';
import { Button } from '@/components/ui/Button';
import { useStore, selectTodayTasks, selectCompletedTasksToday } from '@/store';
import { getMotivationalMessage } from '@/utils/motivation';
import { getTimeOfDayGreeting } from '@/utils/timeUtils';

export function Dashboard() {
  const { user, userStats, tasks } = useStore();
  const todayTasks = useStore(selectTodayTasks);
  const completedToday = useStore(selectCompletedTasksToday);

  const greeting = getTimeOfDayGreeting();
  const motivation = getMotivationalMessage('encouragement', user?.settings.motivationMode);

  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-4xl font-bold mb-2">
          {greeting}, {user?.name || 'Champion'}! 👋
        </h1>
        <p className="text-dark-400">{motivation}</p>
      </div>

      {/* Quick Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <Card padding="md">
          <div className="text-center">
            <div className="text-3xl mb-2">🔥</div>
            <div className="text-2xl font-bold">{userStats?.current_streak || 0}</div>
            <div className="text-sm text-dark-400">Day Streak</div>
          </div>
        </Card>

        <Card padding="md">
          <div className="text-center">
            <div className="text-3xl mb-2">⭐</div>
            <div className="text-2xl font-bold">{userStats?.level || 1}</div>
            <div className="text-sm text-dark-400">Level</div>
          </div>
        </Card>

        <Card padding="md">
          <div className="text-center">
            <div className="text-3xl mb-2">✅</div>
            <div className="text-2xl font-bold">{completedToday.length}</div>
            <div className="text-sm text-dark-400">Tasks Today</div>
          </div>
        </Card>

        <Card padding="md">
          <div className="text-center">
            <div className="text-3xl mb-2">💎</div>
            <div className="text-2xl font-bold">{userStats?.total_points || 0}</div>
            <div className="text-sm text-dark-400">Total XP</div>
          </div>
        </Card>
      </div>

      {/* Progress Rings */}
      <Card padding="lg">
        <h2 className="text-2xl font-bold mb-6">Today's Progress</h2>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
          <ProgressRing
            current={25}
            target={60}
            label="Focus Time"
            color="#6366f1"
          />
          <ProgressRing
            current={30}
            target={60}
            label="Learning"
            color="#d946ef"
          />
          <ProgressRing
            current={completedToday.length}
            target={5}
            label="Tasks"
            color="#22c55e"
          />
          <ProgressRing
            current={85}
            target={100}
            label="Weekly Score"
            color="#f97316"
          />
        </div>
      </Card>

      {/* Today's Tasks */}
      <Card padding="lg">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-2xl font-bold">Today's Tasks</h2>
          <Button size="sm">+ Quick Add</Button>
        </div>

        {todayTasks.length === 0 ? (
          <div className="text-center py-8 text-dark-400">
            <p className="text-4xl mb-2">🎯</p>
            <p>No tasks for today. Add one to get started!</p>
          </div>
        ) : (
          <div className="space-y-2">
            {todayTasks.map((task) => (
              <div
                key={task.id}
                className="flex items-center gap-3 p-3 rounded-funky-sm bg-dark-800 hover:bg-dark-700 transition-colors"
              >
                <input type="checkbox" className="w-5 h-5" />
                <div className="flex-1">
                  <div className="font-medium">{task.title}</div>
                  {task.estimated_minutes && (
                    <div className="text-sm text-dark-400">
                      {task.estimated_minutes} min
                    </div>
                  )}
                </div>
                {task.priority && (
                  <span className={`text-xs px-2 py-1 rounded ${
                    task.priority === 'urgent' ? 'bg-red-600' :
                    task.priority === 'high' ? 'bg-orange-600' :
                    'bg-blue-600'
                  }`}>
                    {task.priority}
                  </span>
                )}
              </div>
            ))}
          </div>
        )}
      </Card>

      {/* Active Timer Placeholder */}
      <Card padding="lg" variant="gradient">
        <div className="text-center">
          <div className="text-6xl mb-4">⏱️</div>
          <h3 className="text-2xl font-bold mb-2">Ready to Focus?</h3>
          <p className="mb-4 opacity-90">Start a 25-minute Pomodoro session</p>
          <Button variant="outline" size="lg">
            Start Timer
          </Button>
        </div>
      </Card>
    </div>
  );
}
