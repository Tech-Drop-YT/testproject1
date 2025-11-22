// Core types for SparkFlow application

export type TaskType = 'task' | 'habit' | 'learning' | 'project';
export type TaskStatus = 'todo' | 'active' | 'completed' | 'archived';
export type TaskPriority = 'low' | 'medium' | 'high' | 'urgent';
export type TimerMode = 'pomodoro' | 'focus' | 'learning';
export type StreakType = 'daily_task' | 'learning' | 'focus';
export type MotivationMode = 'conservative' | 'energetic';

export interface User {
  id: string;
  email: string;
  name?: string;
  settings: UserSettings;
  onboarding_completed: boolean;
  created_at: string;
  updated_at: string;
}

export interface UserSettings {
  theme: 'light' | 'dark';
  motivationMode: MotivationMode;
  pomodoroMinutes: number;
  shortBreakMinutes: number;
  longBreakMinutes: number;
  dailyLearningGoalMinutes: number;
  allowParallelTimers: boolean;
  soundEnabled: boolean;
  notificationsEnabled: boolean;
}

export interface Task {
  id: string;
  user_id: string;
  title: string;
  type: TaskType;
  description?: string;
  tags: string[];
  estimated_minutes?: number;
  priority?: TaskPriority;
  difficulty?: number; // 1-5
  status: TaskStatus;
  parent_id?: string;
  repeat?: RepeatConfig;
  due_date?: string;
  completed_at?: string;
  created_at: string;
  updated_at: string;
}

export interface RepeatConfig {
  interval: 'daily' | 'weekly' | 'monthly';
  days?: number[]; // 0-6 for weekly (0 = Sunday)
}

export interface Timer {
  id: string;
  user_id: string;
  task_id?: string;
  mode: TimerMode;
  start_ts: string;
  pause_ts?: string;
  end_ts?: string;
  duration_seconds: number;
  is_active: boolean;
  created_at: string;
}

export interface LearningModule {
  id: string;
  user_id: string;
  task_id?: string;
  title: string;
  total_lessons: number;
  lessons_completed: number;
  daily_target_minutes: number;
  total_minutes: number;
  created_at: string;
  updated_at: string;
}

export interface Streak {
  id: string;
  user_id: string;
  streak_type: StreakType;
  length: number;
  last_date: string;
  best_length: number;
  created_at: string;
  updated_at: string;
}

export interface PointsLog {
  id: string;
  user_id: string;
  task_id?: string;
  reason: string;
  points: number;
  created_at: string;
}

export interface UserStats {
  id: string;
  user_id: string;
  total_points: number;
  level: number;
  tasks_completed: number;
  total_focus_minutes: number;
  total_learning_minutes: number;
  current_streak: number;
  best_streak: number;
  updated_at: string;
}

export interface DailySummary {
  id: string;
  user_id: string;
  date: string;
  tasks_completed: number;
  focus_minutes: number;
  learning_minutes: number;
  pomodoros_completed: number;
  points_earned: number;
  created_at: string;
}

export interface TaskTemplate {
  id: string;
  user_id?: string;
  title: string;
  description?: string;
  type: TaskType;
  tags: string[];
  estimated_minutes?: number;
  priority?: TaskPriority;
  difficulty?: number;
  is_public: boolean;
  use_count: number;
  created_at: string;
}

// UI-specific types
export interface ProgressRing {
  label: string;
  current: number;
  target: number;
  color: string;
}

export interface MascotPose {
  name: 'idle' | 'cheering' | 'thinking' | 'sleepy';
  svg: string;
}

export interface MotivationalMessage {
  id: string;
  context: 'timer_start' | 'task_complete' | 'missed_day' | 'streak_milestone' | 'level_up' | 'encouragement';
  tone: MotivationMode;
  message: string;
}

export interface QuickAddParsed {
  title: string;
  type: TaskType;
  estimated_minutes?: number;
  tags?: string[];
  priority?: TaskPriority;
  repeat?: RepeatConfig;
}

// Analytics types
export interface TimeOfDayData {
  hour: number;
  minutes: number;
}

export interface WeeklySummary {
  totalTasks: number;
  totalFocusMinutes: number;
  totalLearningMinutes: number;
  totalPoints: number;
  topTags: Array<{ tag: string; count: number }>;
  dailyData: DailySummary[];
}
