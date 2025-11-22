/**
 * Tests for Time Utilities
 */

import {
  formatMinutes,
  formatSeconds,
  calculateDuration,
  isDueSoon,
  isOverdue,
  parseDurationToMinutes,
} from '../timeUtils';

describe('timeUtils', () => {
  describe('formatMinutes', () => {
    it('should format minutes under 60', () => {
      expect(formatMinutes(30)).toBe('30m');
      expect(formatMinutes(45)).toBe('45m');
    });

    it('should format exact hours', () => {
      expect(formatMinutes(60)).toBe('1h');
      expect(formatMinutes(120)).toBe('2h');
    });

    it('should format hours and minutes', () => {
      expect(formatMinutes(90)).toBe('1h 30m');
      expect(formatMinutes(135)).toBe('2h 15m');
    });
  });

  describe('formatSeconds', () => {
    it('should format seconds without hours', () => {
      expect(formatSeconds(65, false)).toBe('01:05');
      expect(formatSeconds(600, false)).toBe('10:00');
    });

    it('should format seconds with hours', () => {
      expect(formatSeconds(3665, true)).toBe('01:01:05');
      expect(formatSeconds(7200, true)).toBe('02:00:00');
    });

    it('should pad with zeros', () => {
      expect(formatSeconds(5, false)).toBe('00:05');
      expect(formatSeconds(125, false)).toBe('02:05');
    });
  });

  describe('calculateDuration', () => {
    it('should calculate duration between timestamps', () => {
      const start = new Date('2024-01-01T10:00:00Z').toISOString();
      const end = new Date('2024-01-01T10:05:00Z').toISOString();
      expect(calculateDuration(start, end)).toBe(300); // 5 minutes = 300 seconds
    });

    it('should return 0 for negative durations', () => {
      const start = new Date('2024-01-01T10:05:00Z').toISOString();
      const end = new Date('2024-01-01T10:00:00Z').toISOString();
      expect(calculateDuration(start, end)).toBe(0);
    });
  });

  describe('parseDurationToMinutes', () => {
    it('should parse hours only', () => {
      expect(parseDurationToMinutes('2h')).toBe(120);
      expect(parseDurationToMinutes('1hr')).toBe(60);
    });

    it('should parse minutes only', () => {
      expect(parseDurationToMinutes('30m')).toBe(30);
      expect(parseDurationToMinutes('45min')).toBe(45);
    });

    it('should parse combined hours and minutes', () => {
      expect(parseDurationToMinutes('1h 30m')).toBe(90);
      expect(parseDurationToMinutes('2hrs 15min')).toBe(135);
    });

    it('should return 0 for invalid input', () => {
      expect(parseDurationToMinutes('invalid')).toBe(0);
    });
  });

  describe('isDueSoon', () => {
    it('should return true for tasks due within 24 hours', () => {
      const tomorrow = new Date();
      tomorrow.setHours(tomorrow.getHours() + 12);
      expect(isDueSoon(tomorrow.toISOString())).toBe(true);
    });

    it('should return false for tasks due after 24 hours', () => {
      const future = new Date();
      future.setDate(future.getDate() + 2);
      expect(isDueSoon(future.toISOString())).toBe(false);
    });

    it('should return false for overdue tasks', () => {
      const past = new Date();
      past.setHours(past.getHours() - 1);
      expect(isDueSoon(past.toISOString())).toBe(false);
    });
  });

  describe('isOverdue', () => {
    it('should return true for past dates', () => {
      const past = new Date();
      past.setHours(past.getHours() - 1);
      expect(isOverdue(past.toISOString())).toBe(true);
    });

    it('should return false for future dates', () => {
      const future = new Date();
      future.setHours(future.getHours() + 1);
      expect(isOverdue(future.toISOString())).toBe(false);
    });
  });
});
