-- SparkFlow Seed Data
-- This provides sample data for development and testing

-- Note: In production, users are created via Supabase Auth
-- For development, you can create a test user directly

-- Insert a test user (adjust the UUID to match your auth.users id)
-- First create user via Supabase Auth, then run this seed

-- Example task templates (public templates available to all users)
INSERT INTO public.task_templates (title, description, type, tags, estimated_minutes, priority, difficulty, is_public) VALUES
  ('Ads Deep Dive — 1 hour/day', 'Deep focus session for Google Ads or Facebook Ads campaign optimization, research, and implementation.', 'learning', ARRAY['ads', 'marketing', 'google-ads'], 60, 'high', 3, true),
  ('WordPress Plugin Quick Fixes', 'Debug and fix issues with WordPress plugins, theme conflicts, or site performance.', 'task', ARRAY['wordpress', 'development', 'debugging'], 30, 'medium', 2, true),
  ('SEO Keyword Lab', 'Research keywords, analyze competitors, and optimize on-page SEO for client websites.', 'learning', ARRAY['seo', 'marketing', 'research'], 45, 'high', 3, true),
  ('Portfolio Update Sprint', 'Update portfolio with recent client work, case studies, and testimonials.', 'project', ARRAY['portfolio', 'business'], 120, 'medium', 2, true),
  ('Daily Client Check-ins', 'Review client messages, respond to inquiries, and update project status.', 'habit', ARRAY['clients', 'communication'], 15, 'high', 1, true),
  ('Learn Facebook Ads Pixel', 'Master Facebook Ads Pixel setup, event tracking, and conversion optimization.', 'learning', ARRAY['facebook-ads', 'marketing', 'tracking'], 90, 'high', 4, true),
  ('Weekly Analytics Review', 'Review Google Analytics data, prepare client reports, and identify optimization opportunities.', 'habit', ARRAY['analytics', 'reporting'], 45, 'medium', 2, true),
  ('Content Calendar Planning', 'Plan social media and blog content for clients for the upcoming week.', 'task', ARRAY['content', 'planning', 'marketing'], 60, 'medium', 2, true);

-- Sample data for a demo user (use actual user_id from your Supabase auth.users)
-- Replace 'YOUR_USER_ID' with actual UUID after creating a user via auth

DO $$
DECLARE
  demo_user_id UUID;
  task1_id UUID := uuid_generate_v4();
  task2_id UUID := uuid_generate_v4();
  task3_id UUID := uuid_generate_v4();
  task4_id UUID := uuid_generate_v4();
  task5_id UUID := uuid_generate_v4();
  project_id UUID := uuid_generate_v4();
BEGIN
  -- Try to get the first user, or skip if no users exist
  SELECT id INTO demo_user_id FROM public.users LIMIT 1;

  IF demo_user_id IS NOT NULL THEN
    -- Sample tasks
    INSERT INTO public.tasks (id, user_id, title, type, description, tags, estimated_minutes, priority, difficulty, status, due_date) VALUES
      (task1_id, demo_user_id, 'Learn SEO — Keyword Research', 'learning', 'Complete module on advanced keyword research techniques and tools.', ARRAY['seo', 'learning'], 60, 'high', 3, 'active', NOW() + INTERVAL '1 day'),
      (task2_id, demo_user_id, 'Client Google Ads Audit', 'task', 'Perform comprehensive audit of client''s Google Ads account and create optimization report.', ARRAY['google-ads', 'client-work'], 120, 'high', 4, 'todo', NOW() + INTERVAL '2 days'),
      (task3_id, demo_user_id, 'Daily WordPress Maintenance', 'habit', 'Check WordPress sites for updates, security issues, and performance.', ARRAY['wordpress', 'maintenance'], 15, 'medium', 1, 'active', NULL),
      (task4_id, demo_user_id, 'Update Portfolio Case Study', 'task', 'Write and publish new case study for recent successful client project.', ARRAY['portfolio', 'writing'], 90, 'medium', 2, 'todo', NOW() + INTERVAL '7 days'),
      (task5_id, demo_user_id, 'Morning Focus Block', 'habit', 'Daily 2-hour deep work session for priority tasks.', ARRAY['productivity', 'focus'], 120, 'high', 1, 'active', NULL);

    -- Sample project with subtasks
    INSERT INTO public.tasks (id, user_id, title, type, description, tags, estimated_minutes, priority, difficulty, status) VALUES
      (project_id, demo_user_id, 'Launch New Client Campaign', 'project', 'Complete setup and launch Facebook Ads campaign for new ecommerce client.', ARRAY['facebook-ads', 'client-work', 'project'], 480, 'urgent', 4, 'active');

    INSERT INTO public.tasks (user_id, title, type, parent_id, tags, estimated_minutes, priority, difficulty, status) VALUES
      (demo_user_id, 'Set up Facebook Business Manager', 'task', project_id, ARRAY['facebook-ads', 'setup'], 30, 'high', 2, 'completed'),
      (demo_user_id, 'Create audience segments', 'task', project_id, ARRAY['facebook-ads', 'targeting'], 45, 'high', 3, 'completed'),
      (demo_user_id, 'Design ad creatives', 'task', project_id, ARRAY['facebook-ads', 'creative'], 120, 'high', 3, 'active'),
      (demo_user_id, 'Set up conversion tracking', 'task', project_id, ARRAY['facebook-ads', 'tracking'], 60, 'high', 4, 'todo'),
      (demo_user_id, 'Launch and monitor campaign', 'task', project_id, ARRAY['facebook-ads', 'optimization'], 90, 'urgent', 3, 'todo');

    -- Sample learning module
    INSERT INTO public.learning_modules (user_id, task_id, title, total_lessons, lessons_completed, daily_target_minutes, total_minutes) VALUES
      (demo_user_id, task1_id, 'Advanced SEO Mastery', 20, 5, 60, 300);

    -- Sample streaks
    INSERT INTO public.streaks (user_id, streak_type, length, last_date, best_length) VALUES
      (demo_user_id, 'learning', 5, CURRENT_DATE, 12),
      (demo_user_id, 'daily_task', 3, CURRENT_DATE, 8),
      (demo_user_id, 'focus', 7, CURRENT_DATE, 15);

    -- Sample points log
    INSERT INTO public.points_log (user_id, task_id, reason, points) VALUES
      (demo_user_id, task1_id, 'Completed learning session', 15),
      (demo_user_id, task1_id, 'Streak bonus (5 days)', 25),
      (demo_user_id, task3_id, 'Completed daily habit', 10),
      (demo_user_id, NULL, 'Level up to Level 2', 100);

    -- Update user stats
    UPDATE public.user_stats
    SET total_points = 450,
        level = 2,
        tasks_completed = 12,
        total_focus_minutes = 840,
        total_learning_minutes = 420,
        current_streak = 5,
        best_streak = 12
    WHERE user_id = demo_user_id;

    -- Sample daily summaries for the past week
    INSERT INTO public.daily_summaries (user_id, date, tasks_completed, focus_minutes, learning_minutes, pomodoros_completed, points_earned) VALUES
      (demo_user_id, CURRENT_DATE - INTERVAL '7 days', 3, 120, 60, 6, 75),
      (demo_user_id, CURRENT_DATE - INTERVAL '6 days', 2, 90, 45, 4, 50),
      (demo_user_id, CURRENT_DATE - INTERVAL '5 days', 4, 150, 60, 7, 95),
      (demo_user_id, CURRENT_DATE - INTERVAL '4 days', 3, 105, 75, 5, 80),
      (demo_user_id, CURRENT_DATE - INTERVAL '3 days', 2, 75, 60, 4, 60),
      (demo_user_id, CURRENT_DATE - INTERVAL '2 days', 5, 180, 90, 8, 120),
      (demo_user_id, CURRENT_DATE - INTERVAL '1 day', 4, 135, 60, 6, 90);

  END IF;
END $$;
