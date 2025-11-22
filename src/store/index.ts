/**
 * SparkFlow Zustand Store with Persistence
 * Central state management for the application
 */

import { create } from 'zustand';
import { persist, createJSONStorage } from 'zustand/middleware';
import {
  User,
  Task,
  Timer,
  LearningModule,
  Streak,
  PointsLog,
  UserStats,
  DailySummary,
  TaskTemplate,
} from '@/types';

interface AppState {
  // Auth state
  user: User | null;
  isAuthenticated: boolean;

  // Data state
  tasks: Task[];
  activeTimer: Timer | null;
  timers: Timer[];
  learningModules: LearningModule[];
  streaks: Streak[];
  pointsLog: PointsLog[];
  userStats: UserStats | null;
  dailySummaries: DailySummary[];
  taskTemplates: TaskTemplate[];

  // UI state
  sidebarOpen: boolean;
  showOnboarding: boolean;
  selectedTaskId: string | null;

  // Offline queue
  offlineQueue: Array<{
    id: string;
    action: string;
    data: any;
    timestamp: string;
  }>;
  isOnline: boolean;

  // Actions
  setUser: (user: User | null) => void;
  logout: () => void;

  // Task actions
  addTask: (task: Task) => void;
  updateTask: (id: string, updates: Partial<Task>) => void;
  deleteTask: (id: string) => void;
  completeTask: (id: string) => void;
  setTasks: (tasks: Task[]) => void;

  // Timer actions
  startTimer: (timer: Timer) => void;
  pauseTimer: () => void;
  resumeTimer: () => void;
  stopTimer: () => void;
  setActiveTimer: (timer: Timer | null) => void;
  addTimerRecord: (timer: Timer) => void;

  // Learning module actions
  addLearningModule: (module: LearningModule) => void;
  updateLearningModule: (id: string, updates: Partial<LearningModule>) => void;
  setLearningModules: (modules: LearningModule[]) => void;

  // Streak actions
  updateStreak: (streak: Streak) => void;
  setStreaks: (streaks: Streak[]) => void;

  // Points actions
  addPoints: (log: PointsLog) => void;
  setPointsLog: (log: PointsLog[]) => void;

  // Stats actions
  setUserStats: (stats: UserStats) => void;
  updateUserStats: (updates: Partial<UserStats>) => void;

  // Daily summary actions
  setDailySummaries: (summaries: DailySummary[]) => void;
  updateTodaySummary: (updates: Partial<DailySummary>) => void;

  // Template actions
  setTaskTemplates: (templates: TaskTemplate[]) => void;

  // UI actions
  toggleSidebar: () => void;
  setSelectedTask: (id: string | null) => void;
  completeOnboarding: () => void;

  // Offline actions
  addToOfflineQueue: (action: string, data: any) => void;
  clearOfflineQueue: () => void;
  setOnlineStatus: (online: boolean) => void;
}

export const useStore = create<AppState>()(
  persist(
    (set, get) => ({
      // Initial state
      user: null,
      isAuthenticated: false,
      tasks: [],
      activeTimer: null,
      timers: [],
      learningModules: [],
      streaks: [],
      pointsLog: [],
      userStats: null,
      dailySummaries: [],
      taskTemplates: [],
      sidebarOpen: true,
      showOnboarding: true,
      selectedTaskId: null,
      offlineQueue: [],
      isOnline: true,

      // Auth actions
      setUser: (user) =>
        set({
          user,
          isAuthenticated: !!user,
          showOnboarding: user ? !user.onboarding_completed : true,
        }),

      logout: () =>
        set({
          user: null,
          isAuthenticated: false,
          tasks: [],
          activeTimer: null,
          timers: [],
          learningModules: [],
          streaks: [],
          pointsLog: [],
          userStats: null,
          dailySummaries: [],
          offlineQueue: [],
        }),

      // Task actions
      addTask: (task) =>
        set((state) => ({
          tasks: [...state.tasks, task],
        })),

      updateTask: (id, updates) =>
        set((state) => ({
          tasks: state.tasks.map((task) =>
            task.id === id ? { ...task, ...updates, updated_at: new Date().toISOString() } : task
          ),
        })),

      deleteTask: (id) =>
        set((state) => ({
          tasks: state.tasks.filter((task) => task.id !== id),
        })),

      completeTask: (id) =>
        set((state) => ({
          tasks: state.tasks.map((task) =>
            task.id === id
              ? {
                  ...task,
                  status: 'completed' as const,
                  completed_at: new Date().toISOString(),
                  updated_at: new Date().toISOString(),
                }
              : task
          ),
        })),

      setTasks: (tasks) => set({ tasks }),

      // Timer actions
      startTimer: (timer) =>
        set({
          activeTimer: { ...timer, is_active: true },
        }),

      pauseTimer: () =>
        set((state) => {
          if (!state.activeTimer) return state;
          return {
            activeTimer: {
              ...state.activeTimer,
              pause_ts: new Date().toISOString(),
            },
          };
        }),

      resumeTimer: () =>
        set((state) => {
          if (!state.activeTimer) return state;
          return {
            activeTimer: {
              ...state.activeTimer,
              pause_ts: undefined,
            },
          };
        }),

      stopTimer: () =>
        set((state) => {
          if (!state.activeTimer) return state;
          const completedTimer = {
            ...state.activeTimer,
            end_ts: new Date().toISOString(),
            is_active: false,
          };
          return {
            activeTimer: null,
            timers: [...state.timers, completedTimer],
          };
        }),

      setActiveTimer: (timer) => set({ activeTimer: timer }),

      addTimerRecord: (timer) =>
        set((state) => ({
          timers: [...state.timers, timer],
        })),

      // Learning module actions
      addLearningModule: (module) =>
        set((state) => ({
          learningModules: [...state.learningModules, module],
        })),

      updateLearningModule: (id, updates) =>
        set((state) => ({
          learningModules: state.learningModules.map((module) =>
            module.id === id
              ? { ...module, ...updates, updated_at: new Date().toISOString() }
              : module
          ),
        })),

      setLearningModules: (modules) => set({ learningModules: modules }),

      // Streak actions
      updateStreak: (streak) =>
        set((state) => ({
          streaks: state.streaks.some((s) => s.id === streak.id)
            ? state.streaks.map((s) => (s.id === streak.id ? streak : s))
            : [...state.streaks, streak],
        })),

      setStreaks: (streaks) => set({ streaks }),

      // Points actions
      addPoints: (log) =>
        set((state) => ({
          pointsLog: [...state.pointsLog, log],
        })),

      setPointsLog: (log) => set({ pointsLog: log }),

      // Stats actions
      setUserStats: (stats) => set({ userStats: stats }),

      updateUserStats: (updates) =>
        set((state) => ({
          userStats: state.userStats
            ? { ...state.userStats, ...updates, updated_at: new Date().toISOString() }
            : null,
        })),

      // Daily summary actions
      setDailySummaries: (summaries) => set({ dailySummaries: summaries }),

      updateTodaySummary: (updates) =>
        set((state) => {
          const today = new Date().toISOString().split('T')[0];
          const existingSummary = state.dailySummaries.find((s) => s.date === today);

          if (existingSummary) {
            return {
              dailySummaries: state.dailySummaries.map((s) =>
                s.date === today ? { ...s, ...updates } : s
              ),
            };
          } else {
            const newSummary: DailySummary = {
              id: crypto.randomUUID(),
              user_id: state.user?.id || '',
              date: today,
              tasks_completed: 0,
              focus_minutes: 0,
              learning_minutes: 0,
              pomodoros_completed: 0,
              points_earned: 0,
              created_at: new Date().toISOString(),
              ...updates,
            };
            return {
              dailySummaries: [...state.dailySummaries, newSummary],
            };
          }
        }),

      // Template actions
      setTaskTemplates: (templates) => set({ taskTemplates: templates }),

      // UI actions
      toggleSidebar: () =>
        set((state) => ({
          sidebarOpen: !state.sidebarOpen,
        })),

      setSelectedTask: (id) => set({ selectedTaskId: id }),

      completeOnboarding: () =>
        set((state) => ({
          showOnboarding: false,
          user: state.user
            ? { ...state.user, onboarding_completed: true }
            : null,
        })),

      // Offline actions
      addToOfflineQueue: (action, data) =>
        set((state) => ({
          offlineQueue: [
            ...state.offlineQueue,
            {
              id: crypto.randomUUID(),
              action,
              data,
              timestamp: new Date().toISOString(),
            },
          ],
        })),

      clearOfflineQueue: () => set({ offlineQueue: [] }),

      setOnlineStatus: (online) => set({ isOnline: online }),
    }),
    {
      name: 'sparkflow-storage',
      storage: createJSONStorage(() => localStorage),
      partialize: (state) => ({
        // Persist only necessary data
        user: state.user,
        tasks: state.tasks,
        activeTimer: state.activeTimer,
        learningModules: state.learningModules,
        streaks: state.streaks,
        userStats: state.userStats,
        dailySummaries: state.dailySummaries,
        sidebarOpen: state.sidebarOpen,
        showOnboarding: state.showOnboarding,
        offlineQueue: state.offlineQueue,
      }),
    }
  )
);

// Selectors for derived state
export const selectTodayTasks = (state: AppState) =>
  state.tasks.filter((task) => {
    if (task.status === 'completed' || task.status === 'archived') return false;
    if (!task.due_date) return task.type === 'habit';

    const today = new Date().toISOString().split('T')[0];
    return task.due_date.split('T')[0] === today;
  });

export const selectActiveTasks = (state: AppState) =>
  state.tasks.filter((task) => task.status === 'active' || task.status === 'todo');

export const selectCompletedTasksToday = (state: AppState) => {
  const today = new Date().toISOString().split('T')[0];
  return state.tasks.filter(
    (task) =>
      task.status === 'completed' &&
      task.completed_at &&
      task.completed_at.split('T')[0] === today
  );
};

export const selectTodayProgress = (state: AppState) => {
  const today = new Date().toISOString().split('T')[0];
  const summary = state.dailySummaries.find((s) => s.date === today);
  return summary || null;
};
