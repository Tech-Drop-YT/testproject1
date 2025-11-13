/**
 * XP and Level Calculation Utilities for SparkFlow
 * Points system: base_points * difficulty * streak_multiplier
 */

export interface XPCalculation {
  points: number;
  levelUp: boolean;
  newLevel?: number;
  nextLevelXP?: number;
}

// Base points for different actions
export const BASE_POINTS = {
  TASK_COMPLETE: 10,
  HABIT_COMPLETE: 5,
  LEARNING_SESSION: 2, // per 10 minutes
  PROJECT_COMPLETE: 50,
  SUBTASK_COMPLETE: 8,
  STREAK_MILESTONE_5: 25,
  STREAK_MILESTONE_10: 50,
  STREAK_MILESTONE_30: 150,
  LEVEL_UP_BONUS: 100,
};

// Streak multipliers
export function getStreakMultiplier(streakLength: number): number {
  if (streakLength >= 30) return 2.0;
  if (streakLength >= 14) return 1.75;
  if (streakLength >= 7) return 1.5;
  if (streakLength >= 3) return 1.25;
  return 1.0;
}

/**
 * Calculate points for completing a task
 */
export function calculateTaskPoints(
  difficulty: number = 1,
  streakLength: number = 0,
  isHabit: boolean = false
): number {
  const basePoints = isHabit ? BASE_POINTS.HABIT_COMPLETE : BASE_POINTS.TASK_COMPLETE;
  const streakMultiplier = getStreakMultiplier(streakLength);
  const difficultyMultiplier = Math.max(1, difficulty);

  return Math.floor(basePoints * difficultyMultiplier * streakMultiplier);
}

/**
 * Calculate points for learning session based on minutes
 */
export function calculateLearningPoints(
  minutes: number,
  streakLength: number = 0
): number {
  const intervals = Math.floor(minutes / 10);
  const basePoints = intervals * BASE_POINTS.LEARNING_SESSION;
  const streakMultiplier = getStreakMultiplier(streakLength);

  return Math.floor(basePoints * streakMultiplier);
}

/**
 * Calculate points for streak milestone
 */
export function calculateStreakBonus(streakLength: number): number {
  if (streakLength === 30) return BASE_POINTS.STREAK_MILESTONE_30;
  if (streakLength === 10) return BASE_POINTS.STREAK_MILESTONE_10;
  if (streakLength === 5) return BASE_POINTS.STREAK_MILESTONE_5;
  return 0;
}

/**
 * Calculate required XP for a given level
 * Formula: level^2 * 100 (exponential growth)
 */
export function getXPForLevel(level: number): number {
  return Math.floor(Math.pow(level, 2) * 100);
}

/**
 * Calculate current level based on total points
 */
export function calculateLevel(totalPoints: number): number {
  let level = 1;
  let requiredXP = getXPForLevel(level + 1);

  while (totalPoints >= requiredXP) {
    level++;
    requiredXP = getXPForLevel(level + 1);
  }

  return level;
}

/**
 * Calculate XP progress in current level
 */
export function getLevelProgress(totalPoints: number): {
  currentLevel: number;
  currentLevelXP: number;
  nextLevelXP: number;
  progressPercent: number;
} {
  const currentLevel = calculateLevel(totalPoints);
  const currentLevelXP = getXPForLevel(currentLevel);
  const nextLevelXP = getXPForLevel(currentLevel + 1);
  const xpInCurrentLevel = totalPoints - currentLevelXP;
  const xpNeededForNextLevel = nextLevelXP - currentLevelXP;
  const progressPercent = (xpInCurrentLevel / xpNeededForNextLevel) * 100;

  return {
    currentLevel,
    currentLevelXP,
    nextLevelXP,
    progressPercent: Math.min(100, Math.max(0, progressPercent)),
  };
}

/**
 * Add points to user's total and check for level up
 */
export function addPoints(
  currentPoints: number,
  pointsToAdd: number
): XPCalculation {
  const newTotalPoints = currentPoints + pointsToAdd;
  const oldLevel = calculateLevel(currentPoints);
  const newLevel = calculateLevel(newTotalPoints);
  const levelUp = newLevel > oldLevel;

  return {
    points: newTotalPoints,
    levelUp,
    newLevel: levelUp ? newLevel : undefined,
    nextLevelXP: levelUp ? getXPForLevel(newLevel + 1) : undefined,
  };
}

/**
 * Get all badges/achievements for a user
 */
export interface Badge {
  id: string;
  name: string;
  description: string;
  icon: string;
  unlocked: boolean;
}

export function getBadges(stats: {
  level: number;
  tasks_completed: number;
  current_streak: number;
  best_streak: number;
  total_focus_minutes: number;
  total_learning_minutes: number;
}): Badge[] {
  return [
    {
      id: 'first_task',
      name: 'Getting Started',
      description: 'Complete your first task',
      icon: '🎯',
      unlocked: stats.tasks_completed >= 1,
    },
    {
      id: 'task_10',
      name: 'On a Roll',
      description: 'Complete 10 tasks',
      icon: '🔥',
      unlocked: stats.tasks_completed >= 10,
    },
    {
      id: 'task_50',
      name: 'Task Master',
      description: 'Complete 50 tasks',
      icon: '⭐',
      unlocked: stats.tasks_completed >= 50,
    },
    {
      id: 'streak_5',
      name: 'Streak Starter',
      description: 'Maintain a 5-day streak',
      icon: '🌟',
      unlocked: stats.current_streak >= 5,
    },
    {
      id: 'streak_30',
      name: 'Consistency King',
      description: 'Maintain a 30-day streak',
      icon: '👑',
      unlocked: stats.current_streak >= 30,
    },
    {
      id: 'focus_600',
      name: 'Deep Worker',
      description: 'Log 10 hours of focus time',
      icon: '🧠',
      unlocked: stats.total_focus_minutes >= 600,
    },
    {
      id: 'learning_1200',
      name: 'Lifelong Learner',
      description: 'Log 20 hours of learning',
      icon: '📚',
      unlocked: stats.total_learning_minutes >= 1200,
    },
    {
      id: 'level_5',
      name: 'Rising Star',
      description: 'Reach level 5',
      icon: '🚀',
      unlocked: stats.level >= 5,
    },
    {
      id: 'level_10',
      name: 'Elite Performer',
      description: 'Reach level 10',
      icon: '💎',
      unlocked: stats.level >= 10,
    },
  ];
}
