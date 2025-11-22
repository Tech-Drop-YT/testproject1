/**
 * Tests for XP Calculation Utilities
 */

import {
  calculateTaskPoints,
  calculateLearningPoints,
  calculateStreakBonus,
  getXPForLevel,
  calculateLevel,
  getLevelProgress,
  addPoints,
  getStreakMultiplier,
} from '../xpCalculator';

describe('xpCalculator', () => {
  describe('getStreakMultiplier', () => {
    it('should return 1.0 for streaks under 3 days', () => {
      expect(getStreakMultiplier(0)).toBe(1.0);
      expect(getStreakMultiplier(1)).toBe(1.0);
      expect(getStreakMultiplier(2)).toBe(1.0);
    });

    it('should return 1.25 for streaks 3-6 days', () => {
      expect(getStreakMultiplier(3)).toBe(1.25);
      expect(getStreakMultiplier(5)).toBe(1.25);
    });

    it('should return 1.5 for streaks 7-13 days', () => {
      expect(getStreakMultiplier(7)).toBe(1.5);
      expect(getStreakMultiplier(10)).toBe(1.5);
    });

    it('should return 1.75 for streaks 14-29 days', () => {
      expect(getStreakMultiplier(14)).toBe(1.75);
      expect(getStreakMultiplier(20)).toBe(1.75);
    });

    it('should return 2.0 for streaks 30+ days', () => {
      expect(getStreakMultiplier(30)).toBe(2.0);
      expect(getStreakMultiplier(100)).toBe(2.0);
    });
  });

  describe('calculateTaskPoints', () => {
    it('should calculate basic task points without multipliers', () => {
      expect(calculateTaskPoints(1, 0, false)).toBe(10);
    });

    it('should multiply by difficulty', () => {
      expect(calculateTaskPoints(3, 0, false)).toBe(30);
      expect(calculateTaskPoints(5, 0, false)).toBe(50);
    });

    it('should apply streak multiplier', () => {
      expect(calculateTaskPoints(1, 7, false)).toBe(15); // 10 * 1 * 1.5
      expect(calculateTaskPoints(2, 7, false)).toBe(30); // 10 * 2 * 1.5
    });

    it('should use different base points for habits', () => {
      expect(calculateTaskPoints(1, 0, true)).toBe(5);
      expect(calculateTaskPoints(2, 0, true)).toBe(10);
    });

    it('should combine difficulty and streak multipliers', () => {
      expect(calculateTaskPoints(3, 30, false)).toBe(60); // 10 * 3 * 2.0
    });
  });

  describe('calculateLearningPoints', () => {
    it('should calculate points for 10-minute intervals', () => {
      expect(calculateLearningPoints(10, 0)).toBe(2);
      expect(calculateLearningPoints(20, 0)).toBe(4);
      expect(calculateLearningPoints(60, 0)).toBe(12);
    });

    it('should apply streak multiplier', () => {
      expect(calculateLearningPoints(60, 7)).toBe(18); // 6 * 2 * 1.5
    });

    it('should round down partial intervals', () => {
      expect(calculateLearningPoints(15, 0)).toBe(2); // 1 interval
      expect(calculateLearningPoints(25, 0)).toBe(4); // 2 intervals
    });
  });

  describe('calculateStreakBonus', () => {
    it('should return 0 for non-milestone streaks', () => {
      expect(calculateStreakBonus(1)).toBe(0);
      expect(calculateStreakBonus(7)).toBe(0);
    });

    it('should return correct bonus for milestones', () => {
      expect(calculateStreakBonus(5)).toBe(25);
      expect(calculateStreakBonus(10)).toBe(50);
      expect(calculateStreakBonus(30)).toBe(150);
    });
  });

  describe('getXPForLevel', () => {
    it('should calculate XP required for level', () => {
      expect(getXPForLevel(1)).toBe(100);
      expect(getXPForLevel(2)).toBe(400);
      expect(getXPForLevel(3)).toBe(900);
      expect(getXPForLevel(5)).toBe(2500);
    });
  });

  describe('calculateLevel', () => {
    it('should return level 1 for 0-99 points', () => {
      expect(calculateLevel(0)).toBe(1);
      expect(calculateLevel(99)).toBe(1);
    });

    it('should return level 2 for 100-399 points', () => {
      expect(calculateLevel(100)).toBe(2);
      expect(calculateLevel(399)).toBe(2);
    });

    it('should return level 3 for 400-899 points', () => {
      expect(calculateLevel(400)).toBe(3);
      expect(calculateLevel(899)).toBe(3);
    });

    it('should calculate higher levels correctly', () => {
      expect(calculateLevel(900)).toBe(4);
      expect(calculateLevel(2500)).toBe(6);
    });
  });

  describe('getLevelProgress', () => {
    it('should calculate level 1 progress correctly', () => {
      const progress = getLevelProgress(50);
      expect(progress.currentLevel).toBe(1);
      expect(progress.currentLevelXP).toBe(0);
      expect(progress.nextLevelXP).toBe(100);
      expect(progress.progressPercent).toBe(50);
    });

    it('should calculate level 2 progress correctly', () => {
      const progress = getLevelProgress(250); // 150 into level 2
      expect(progress.currentLevel).toBe(2);
      expect(progress.currentLevelXP).toBe(100);
      expect(progress.nextLevelXP).toBe(400);
      expect(progress.progressPercent).toBe(50);
    });

    it('should cap progress at 100%', () => {
      const progress = getLevelProgress(99);
      expect(progress.progressPercent).toBeLessThanOrEqual(100);
    });
  });

  describe('addPoints', () => {
    it('should add points without level up', () => {
      const result = addPoints(50, 30);
      expect(result.points).toBe(80);
      expect(result.levelUp).toBe(false);
    });

    it('should detect level up', () => {
      const result = addPoints(90, 20);
      expect(result.points).toBe(110);
      expect(result.levelUp).toBe(true);
      expect(result.newLevel).toBe(2);
      expect(result.nextLevelXP).toBe(400);
    });

    it('should handle multiple level ups', () => {
      const result = addPoints(50, 1000);
      expect(result.points).toBe(1050);
      expect(result.levelUp).toBe(true);
      expect(result.newLevel).toBeGreaterThan(2);
    });
  });
});
