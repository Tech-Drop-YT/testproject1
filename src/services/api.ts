/**
 * API Service Layer for SparkFlow
 * Handles all backend interactions with Supabase
 */

import { supabase, isSupabaseConfigured } from '@/lib/supabase';
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

// Auth API
export const authApi = {
  async signInWithMagicLink(email: string): Promise<{ error: Error | null }> {
    if (!isSupabaseConfigured()) {
      return { error: new Error('Supabase not configured') };
    }

    const { error } = await supabase.auth.signInWithOtp({
      email,
      options: {
        emailRedirectTo: window.location.origin,
      },
    });

    return { error };
  },

  async signOut(): Promise<{ error: Error | null }> {
    if (!isSupabaseConfigured()) {
      return { error: null };
    }

    const { error } = await supabase.auth.signOut();
    return { error };
  },

  async getCurrentUser(): Promise<User | null> {
    if (!isSupabaseConfigured()) {
      return null;
    }

    const { data: { user: authUser } } = await supabase.auth.getUser();
    if (!authUser) return null;

    const { data, error } = await supabase
      .from('users')
      .select('*')
      .eq('id', authUser.id)
      .single();

    if (error || !data) return null;
    return data as User;
  },

  onAuthStateChange(callback: (user: User | null) => void) {
    if (!isSupabaseConfigured()) {
      return { unsubscribe: () => {} };
    }

    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      async (event, session) => {
        if (session?.user) {
          const user = await authApi.getCurrentUser();
          callback(user);
        } else {
          callback(null);
        }
      }
    );

    return subscription;
  },
};

// Tasks API
export const tasksApi = {
  async getAll(userId: string): Promise<Task[]> {
    if (!isSupabaseConfigured()) return [];

    const { data, error } = await supabase
      .from('tasks')
      .select('*')
      .eq('user_id', userId)
      .order('created_at', { ascending: false });

    if (error) {
      console.error('Error fetching tasks:', error);
      return [];
    }

    return data as Task[];
  },

  async create(task: Omit<Task, 'id' | 'created_at' | 'updated_at'>): Promise<Task | null> {
    if (!isSupabaseConfigured()) {
      // Return mock task for offline mode
      return {
        ...task,
        id: crypto.randomUUID(),
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
      } as Task;
    }

    const { data, error } = await supabase
      .from('tasks')
      .insert(task)
      .select()
      .single();

    if (error) {
      console.error('Error creating task:', error);
      return null;
    }

    return data as Task;
  },

  async update(id: string, updates: Partial<Task>): Promise<Task | null> {
    if (!isSupabaseConfigured()) return null;

    const { data, error } = await supabase
      .from('tasks')
      .update(updates)
      .eq('id', id)
      .select()
      .single();

    if (error) {
      console.error('Error updating task:', error);
      return null;
    }

    return data as Task;
  },

  async delete(id: string): Promise<boolean> {
    if (!isSupabaseConfigured()) return true;

    const { error } = await supabase.from('tasks').delete().eq('id', id);

    if (error) {
      console.error('Error deleting task:', error);
      return false;
    }

    return true;
  },
};

// Timers API
export const timersApi = {
  async start(timer: Omit<Timer, 'id' | 'created_at'>): Promise<Timer | null> {
    if (!isSupabaseConfigured()) {
      return {
        ...timer,
        id: crypto.randomUUID(),
        created_at: new Date().toISOString(),
      } as Timer;
    }

    const { data, error } = await supabase
      .from('timers')
      .insert(timer)
      .select()
      .single();

    if (error) {
      console.error('Error starting timer:', error);
      return null;
    }

    return data as Timer;
  },

  async stop(id: string, duration_seconds: number): Promise<Timer | null> {
    if (!isSupabaseConfigured()) return null;

    const { data, error } = await supabase
      .from('timers')
      .update({
        end_ts: new Date().toISOString(),
        duration_seconds,
        is_active: false,
      })
      .eq('id', id)
      .select()
      .single();

    if (error) {
      console.error('Error stopping timer:', error);
      return null;
    }

    return data as Timer;
  },

  async getHistory(userId: string, limit: number = 50): Promise<Timer[]> {
    if (!isSupabaseConfigured()) return [];

    const { data, error } = await supabase
      .from('timers')
      .select('*')
      .eq('user_id', userId)
      .order('created_at', { ascending: false })
      .limit(limit);

    if (error) {
      console.error('Error fetching timer history:', error);
      return [];
    }

    return data as Timer[];
  },
};

// Learning Modules API
export const learningApi = {
  async getAll(userId: string): Promise<LearningModule[]> {
    if (!isSupabaseConfigured()) return [];

    const { data, error } = await supabase
      .from('learning_modules')
      .select('*')
      .eq('user_id', userId);

    if (error) {
      console.error('Error fetching learning modules:', error);
      return [];
    }

    return data as LearningModule[];
  },

  async create(module: Omit<LearningModule, 'id' | 'created_at' | 'updated_at'>): Promise<LearningModule | null> {
    if (!isSupabaseConfigured()) {
      return {
        ...module,
        id: crypto.randomUUID(),
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
      } as LearningModule;
    }

    const { data, error } = await supabase
      .from('learning_modules')
      .insert(module)
      .select()
      .single();

    if (error) {
      console.error('Error creating learning module:', error);
      return null;
    }

    return data as LearningModule;
  },

  async update(id: string, updates: Partial<LearningModule>): Promise<LearningModule | null> {
    if (!isSupabaseConfigured()) return null;

    const { data, error } = await supabase
      .from('learning_modules')
      .update(updates)
      .eq('id', id)
      .select()
      .single();

    if (error) {
      console.error('Error updating learning module:', error);
      return null;
    }

    return data as LearningModule;
  },
};

// Streaks API
export const streaksApi = {
  async getAll(userId: string): Promise<Streak[]> {
    if (!isSupabaseConfigured()) return [];

    const { data, error } = await supabase
      .from('streaks')
      .select('*')
      .eq('user_id', userId);

    if (error) {
      console.error('Error fetching streaks:', error);
      return [];
    }

    return data as Streak[];
  },

  async upsert(streak: Omit<Streak, 'id' | 'created_at' | 'updated_at'>): Promise<Streak | null> {
    if (!isSupabaseConfigured()) {
      return {
        ...streak,
        id: crypto.randomUUID(),
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
      } as Streak;
    }

    const { data, error } = await supabase
      .from('streaks')
      .upsert(streak, {
        onConflict: 'user_id,streak_type',
      })
      .select()
      .single();

    if (error) {
      console.error('Error upserting streak:', error);
      return null;
    }

    return data as Streak;
  },
};

// Points API
export const pointsApi = {
  async add(log: Omit<PointsLog, 'id' | 'created_at'>): Promise<PointsLog | null> {
    if (!isSupabaseConfigured()) {
      return {
        ...log,
        id: crypto.randomUUID(),
        created_at: new Date().toISOString(),
      } as PointsLog;
    }

    const { data, error } = await supabase
      .from('points_log')
      .insert(log)
      .select()
      .single();

    if (error) {
      console.error('Error adding points:', error);
      return null;
    }

    return data as PointsLog;
  },

  async getHistory(userId: string, limit: number = 100): Promise<PointsLog[]> {
    if (!isSupabaseConfigured()) return [];

    const { data, error } = await supabase
      .from('points_log')
      .select('*')
      .eq('user_id', userId)
      .order('created_at', { ascending: false })
      .limit(limit);

    if (error) {
      console.error('Error fetching points history:', error);
      return [];
    }

    return data as PointsLog[];
  },
};

// Stats API
export const statsApi = {
  async get(userId: string): Promise<UserStats | null> {
    if (!isSupabaseConfigured()) return null;

    const { data, error } = await supabase
      .from('user_stats')
      .select('*')
      .eq('user_id', userId)
      .single();

    if (error) {
      console.error('Error fetching stats:', error);
      return null;
    }

    return data as UserStats;
  },

  async update(userId: string, updates: Partial<UserStats>): Promise<UserStats | null> {
    if (!isSupabaseConfigured()) return null;

    const { data, error } = await supabase
      .from('user_stats')
      .update(updates)
      .eq('user_id', userId)
      .select()
      .single();

    if (error) {
      console.error('Error updating stats:', error);
      return null;
    }

    return data as UserStats;
  },
};

// Daily Summaries API
export const summariesApi = {
  async getRecent(userId: string, days: number = 30): Promise<DailySummary[]> {
    if (!isSupabaseConfigured()) return [];

    const startDate = new Date();
    startDate.setDate(startDate.getDate() - days);

    const { data, error } = await supabase
      .from('daily_summaries')
      .select('*')
      .eq('user_id', userId)
      .gte('date', startDate.toISOString().split('T')[0])
      .order('date', { ascending: false });

    if (error) {
      console.error('Error fetching summaries:', error);
      return [];
    }

    return data as DailySummary[];
  },

  async upsertToday(userId: string, updates: Partial<DailySummary>): Promise<DailySummary | null> {
    if (!isSupabaseConfigured()) return null;

    const today = new Date().toISOString().split('T')[0];

    const { data, error } = await supabase
      .from('daily_summaries')
      .upsert(
        {
          user_id: userId,
          date: today,
          ...updates,
        },
        {
          onConflict: 'user_id,date',
        }
      )
      .select()
      .single();

    if (error) {
      console.error('Error upserting summary:', error);
      return null;
    }

    return data as DailySummary;
  },
};

// Templates API
export const templatesApi = {
  async getAll(): Promise<TaskTemplate[]> {
    if (!isSupabaseConfigured()) return [];

    const { data, error } = await supabase
      .from('task_templates')
      .select('*')
      .eq('is_public', true)
      .order('use_count', { ascending: false });

    if (error) {
      console.error('Error fetching templates:', error);
      return [];
    }

    return data as TaskTemplate[];
  },
};
