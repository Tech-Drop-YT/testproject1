/**
 * Time and Date Utilities for SparkFlow
 */

import { format, formatDistance, formatDistanceToNow, isToday, isYesterday, parseISO, differenceInMinutes, differenceInSeconds, addMinutes, startOfDay, endOfDay, subDays } from 'date-fns';

/**
 * Format time in minutes to human-readable string
 * Examples: "1h 30m", "45m", "2h"
 */
export function formatMinutes(minutes: number): string {
  if (minutes < 60) {
    return `${minutes}m`;
  }

  const hours = Math.floor(minutes / 60);
  const remainingMinutes = minutes % 60;

  if (remainingMinutes === 0) {
    return `${hours}h`;
  }

  return `${hours}h ${remainingMinutes}m`;
}

/**
 * Format seconds to MM:SS or HH:MM:SS
 */
export function formatSeconds(seconds: number, includeHours: boolean = true): string {
  const hours = Math.floor(seconds / 3600);
  const minutes = Math.floor((seconds % 3600) / 60);
  const secs = seconds % 60;

  if (includeHours && hours > 0) {
    return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
  }

  return `${minutes.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
}

/**
 * Format date relative to now
 * Examples: "Today", "Yesterday", "2 days ago", "Jan 15"
 */
export function formatRelativeDate(date: string | Date): string {
  const dateObj = typeof date === 'string' ? parseISO(date) : date;

  if (isToday(dateObj)) {
    return 'Today';
  }

  if (isYesterday(dateObj)) {
    return 'Yesterday';
  }

  const daysAgo = differenceInMinutes(new Date(), dateObj) / (60 * 24);

  if (daysAgo < 7) {
    return formatDistanceToNow(dateObj, { addSuffix: true });
  }

  return format(dateObj, 'MMM d');
}

/**
 * Format date and time
 */
export function formatDateTime(date: string | Date): string {
  const dateObj = typeof date === 'string' ? parseISO(date) : date;
  return format(dateObj, 'MMM d, yyyy h:mm a');
}

/**
 * Calculate duration between two timestamps in seconds
 */
export function calculateDuration(startTs: string, endTs?: string): number {
  const start = parseISO(startTs);
  const end = endTs ? parseISO(endTs) : new Date();
  return Math.max(0, differenceInSeconds(end, start));
}

/**
 * Check if a task is due soon (within 24 hours)
 */
export function isDueSoon(dueDate: string): boolean {
  const due = parseISO(dueDate);
  const now = new Date();
  const minutesUntilDue = differenceInMinutes(due, now);

  return minutesUntilDue > 0 && minutesUntilDue <= 24 * 60;
}

/**
 * Check if a task is overdue
 */
export function isOverdue(dueDate: string): boolean {
  const due = parseISO(dueDate);
  return due < new Date();
}

/**
 * Get time of day greeting
 */
export function getTimeOfDayGreeting(): string {
  const hour = new Date().getHours();

  if (hour < 12) return 'Good morning';
  if (hour < 18) return 'Good afternoon';
  return 'Good evening';
}

/**
 * Calculate estimated end time based on current time and duration
 */
export function getEstimatedEndTime(minutes: number): string {
  const endTime = addMinutes(new Date(), minutes);
  return format(endTime, 'h:mm a');
}

/**
 * Get date range for analytics queries
 */
export function getDateRange(range: '7d' | '30d' | '90d'): {
  start: Date;
  end: Date;
} {
  const end = endOfDay(new Date());
  let start: Date;

  switch (range) {
    case '7d':
      start = startOfDay(subDays(end, 7));
      break;
    case '30d':
      start = startOfDay(subDays(end, 30));
      break;
    case '90d':
      start = startOfDay(subDays(end, 90));
      break;
  }

  return { start, end };
}

/**
 * Parse duration string to minutes
 * Examples: "1h" -> 60, "30m" -> 30, "1h 30m" -> 90
 */
export function parseDurationToMinutes(duration: string): number {
  const hoursMatch = duration.match(/(\d+)h/);
  const minutesMatch = duration.match(/(\d+)m/);

  let totalMinutes = 0;

  if (hoursMatch) {
    totalMinutes += parseInt(hoursMatch[1]) * 60;
  }

  if (minutesMatch) {
    totalMinutes += parseInt(minutesMatch[1]);
  }

  return totalMinutes;
}

/**
 * Check if current time is within a time range
 */
export function isWithinTimeRange(
  startHour: number,
  endHour: number
): boolean {
  const currentHour = new Date().getHours();
  return currentHour >= startHour && currentHour < endHour;
}

/**
 * Get productive time suggestion based on current time
 */
export function getProductiveTimeSuggestion(): string {
  const hour = new Date().getHours();

  if (hour >= 6 && hour < 9) {
    return 'Perfect morning energy! Tackle your most challenging task.';
  }

  if (hour >= 9 && hour < 12) {
    return 'Peak productivity hours! Deep focus time.';
  }

  if (hour >= 12 && hour < 14) {
    return 'Post-lunch dip coming. Try a quick learning session or lighter tasks.';
  }

  if (hour >= 14 && hour < 17) {
    return 'Afternoon momentum! Great for collaborative work.';
  }

  if (hour >= 17 && hour < 21) {
    return 'Evening wrap-up. Review progress and plan tomorrow.';
  }

  return 'Night owl mode! Remember to take breaks and rest.';
}

/**
 * Calculate timer remaining time
 */
export function calculateRemainingTime(
  startTs: string,
  targetMinutes: number,
  pausedSeconds: number = 0
): {
  remainingSeconds: number;
  isComplete: boolean;
  percentComplete: number;
} {
  const elapsedSeconds = calculateDuration(startTs) - pausedSeconds;
  const targetSeconds = targetMinutes * 60;
  const remainingSeconds = Math.max(0, targetSeconds - elapsedSeconds);
  const isComplete = remainingSeconds === 0;
  const percentComplete = Math.min(100, (elapsedSeconds / targetSeconds) * 100);

  return {
    remainingSeconds,
    isComplete,
    percentComplete,
  };
}
