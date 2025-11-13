/**
 * Motivational Message Utilities
 * Retrieves appropriate motivational messages based on context and user preferences
 */

import motivationData from '@/data/motivation_bank.json';
import { MotivationMode } from '@/types';

export type MessageContext =
  | 'timer_start'
  | 'task_complete'
  | 'missed_day'
  | 'streak_milestone'
  | 'level_up'
  | 'encouragement';

export interface MotivationalMessage {
  id: string;
  context: MessageContext;
  tone: MotivationMode;
  message: string;
}

/**
 * Get a random motivational message for a specific context
 */
export function getMotivationalMessage(
  context: MessageContext,
  tone: MotivationMode = 'energetic'
): string {
  const messages = motivationData.messages.filter(
    (msg) => msg.context === context && msg.tone === tone
  ) as MotivationalMessage[];

  if (messages.length === 0) {
    // Fallback to any message with the same context
    const fallbackMessages = motivationData.messages.filter(
      (msg) => msg.context === context
    );
    if (fallbackMessages.length > 0) {
      return fallbackMessages[Math.floor(Math.random() * fallbackMessages.length)].message;
    }
    return 'You got this! Keep going!';
  }

  const randomIndex = Math.floor(Math.random() * messages.length);
  return messages[randomIndex].message;
}

/**
 * Get multiple messages for variety
 */
export function getMotivationalMessages(
  context: MessageContext,
  tone: MotivationMode = 'energetic',
  count: number = 3
): string[] {
  const messages = motivationData.messages.filter(
    (msg) => msg.context === context && msg.tone === tone
  ) as MotivationalMessage[];

  if (messages.length === 0) return [];

  // Shuffle and return requested count
  const shuffled = [...messages].sort(() => Math.random() - 0.5);
  return shuffled.slice(0, count).map((msg) => msg.message);
}

/**
 * Get a context-aware message based on time of day and user state
 */
export function getSmartMotivation(params: {
  context?: MessageContext;
  tone?: MotivationMode;
  streakLength?: number;
  tasksCompletedToday?: number;
  timeOfDay?: 'morning' | 'afternoon' | 'evening';
}): string {
  const {
    context = 'encouragement',
    tone = 'energetic',
    streakLength = 0,
    tasksCompletedToday = 0,
  } = params;

  // Special messages for milestones
  if (streakLength === 5 || streakLength === 10 || streakLength === 30) {
    return getMotivationalMessage('streak_milestone', tone);
  }

  // First task completion
  if (tasksCompletedToday === 1) {
    return getMotivationalMessage('task_complete', tone);
  }

  // Return regular message
  return getMotivationalMessage(context, tone);
}

/**
 * Get all available contexts
 */
export function getAvailableContexts(): MessageContext[] {
  return [
    'timer_start',
    'task_complete',
    'missed_day',
    'streak_milestone',
    'level_up',
    'encouragement',
  ];
}

/**
 * Get message count by context
 */
export function getMessageStats(): Record<MessageContext, { energetic: number; conservative: number }> {
  const stats: any = {};

  getAvailableContexts().forEach((context) => {
    const energeticCount = motivationData.messages.filter(
      (msg) => msg.context === context && msg.tone === 'energetic'
    ).length;

    const conservativeCount = motivationData.messages.filter(
      (msg) => msg.context === context && msg.tone === 'conservative'
    ).length;

    stats[context] = {
      energetic: energeticCount,
      conservative: conservativeCount,
    };
  });

  return stats;
}

/**
 * Get total message count
 */
export function getTotalMessageCount(): number {
  return motivationData.messages.length;
}
