/**
 * Browser Notification Utilities for SparkFlow
 */

export type NotificationType = 'timer_complete' | 'break_time' | 'achievement' | 'streak_reminder' | 'task_due';

export interface NotificationOptions {
  title: string;
  body: string;
  icon?: string;
  badge?: string;
  tag?: string;
  requireInteraction?: boolean;
}

/**
 * Request notification permission from browser
 */
export async function requestNotificationPermission(): Promise<NotificationPermission> {
  if (!('Notification' in window)) {
    console.warn('This browser does not support notifications');
    return 'denied';
  }

  if (Notification.permission === 'granted') {
    return 'granted';
  }

  if (Notification.permission !== 'denied') {
    const permission = await Notification.requestPermission();
    return permission;
  }

  return Notification.permission;
}

/**
 * Show browser notification
 */
export function showNotification(options: NotificationOptions): void {
  if (!('Notification' in window) || Notification.permission !== 'granted') {
    console.warn('Notifications not permitted');
    return;
  }

  try {
    const notification = new Notification(options.title, {
      body: options.body,
      icon: options.icon || '/icon-192.png',
      badge: options.badge || '/icon-192.png',
      tag: options.tag,
      requireInteraction: options.requireInteraction || false,
    });

    // Auto-close after 10 seconds if not requiring interaction
    if (!options.requireInteraction) {
      setTimeout(() => notification.close(), 10000);
    }
  } catch (error) {
    console.error('Failed to show notification:', error);
  }
}

/**
 * Show timer complete notification
 */
export function notifyTimerComplete(mode: string, duration: number): void {
  const titles = {
    pomodoro: '🍅 Pomodoro Complete!',
    focus: '🎯 Focus Session Done!',
    learning: '📚 Learning Session Complete!',
  };

  showNotification({
    title: titles[mode as keyof typeof titles] || 'Timer Complete!',
    body: `Great work! You focused for ${Math.round(duration / 60)} minutes.`,
    tag: 'timer-complete',
    requireInteraction: false,
  });
}

/**
 * Show break time notification
 */
export function notifyBreakTime(breakMinutes: number): void {
  showNotification({
    title: '☕ Break Time!',
    body: `Time for a ${breakMinutes}-minute break. Stretch, hydrate, recharge!`,
    tag: 'break-time',
    requireInteraction: true,
  });
}

/**
 * Show achievement unlocked notification
 */
export function notifyAchievement(achievement: string, description: string): void {
  showNotification({
    title: `🎉 Achievement Unlocked: ${achievement}`,
    body: description,
    tag: 'achievement',
    requireInteraction: false,
  });
}

/**
 * Show streak reminder notification
 */
export function notifyStreakReminder(streakLength: number): void {
  showNotification({
    title: `🔥 Streak Alert: ${streakLength} Days!`,
    body: `Don't break your streak! Complete a task or learning session today.`,
    tag: 'streak-reminder',
    requireInteraction: false,
  });
}

/**
 * Show task due notification
 */
export function notifyTaskDue(taskTitle: string, minutesUntilDue: number): void {
  const timeString = minutesUntilDue < 60
    ? `${minutesUntilDue} minutes`
    : `${Math.round(minutesUntilDue / 60)} hours`;

  showNotification({
    title: '⏰ Task Due Soon',
    body: `"${taskTitle}" is due in ${timeString}`,
    tag: 'task-due',
    requireInteraction: false,
  });
}

/**
 * Play notification sound (optional)
 */
export function playNotificationSound(soundType: 'complete' | 'break' | 'achievement' = 'complete'): void {
  // In a real implementation, you would play actual sound files
  // For now, we'll use the system beep
  try {
    const audio = new Audio();
    // Different frequencies for different notification types
    const frequencies = {
      complete: 800,
      break: 600,
      achievement: 1000,
    };

    // Create a simple beep using Web Audio API
    const audioContext = new (window.AudioContext || (window as any).webkitAudioContext)();
    const oscillator = audioContext.createOscillator();
    const gainNode = audioContext.createGain();

    oscillator.connect(gainNode);
    gainNode.connect(audioContext.destination);

    oscillator.frequency.value = frequencies[soundType];
    oscillator.type = 'sine';

    gainNode.gain.setValueAtTime(0.3, audioContext.currentTime);
    gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.3);

    oscillator.start(audioContext.currentTime);
    oscillator.stop(audioContext.currentTime + 0.3);
  } catch (error) {
    console.error('Failed to play sound:', error);
  }
}

/**
 * Check if notifications are supported and enabled
 */
export function areNotificationsEnabled(): boolean {
  return 'Notification' in window && Notification.permission === 'granted';
}
