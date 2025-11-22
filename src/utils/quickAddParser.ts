/**
 * Natural Language Parser for Quick Add Task Feature
 * Parses input like "Learn SEO 1h daily" into structured task data
 */

import { QuickAddParsed, TaskType, TaskPriority, RepeatConfig } from '@/types';

// Keywords for task types
const TYPE_KEYWORDS = {
  learning: ['learn', 'study', 'course', 'tutorial', 'practice'],
  habit: ['daily', 'habit', 'routine', 'every day'],
  project: ['project', 'campaign', 'build'],
};

// Keywords for priority
const PRIORITY_KEYWORDS = {
  urgent: ['urgent', 'asap', 'critical', 'now'],
  high: ['important', 'high', 'priority'],
  medium: ['medium', 'normal'],
  low: ['low', 'minor', 'someday'],
};

// Time patterns
const TIME_PATTERNS = {
  hours: /(\d+)\s*(h|hr|hrs|hour|hours)/i,
  minutes: /(\d+)\s*(m|min|mins|minute|minutes)/i,
};

// Repeat patterns
const REPEAT_PATTERNS = {
  daily: /\b(daily|every day|everyday)\b/i,
  weekly: /\b(weekly|every week)\b/i,
  monthly: /\b(monthly|every month)\b/i,
};

/**
 * Parse quick add input into structured task data
 * Example inputs:
 * - "Learn SEO 1h daily"
 * - "Client meeting 30m high priority"
 * - "Write blog post 2hrs project"
 */
export function parseQuickAdd(input: string): QuickAddParsed {
  const cleanInput = input.trim();

  // Detect task type
  const type = detectTaskType(cleanInput);

  // Extract time estimate
  const estimated_minutes = extractTimeEstimate(cleanInput);

  // Extract priority
  const priority = extractPriority(cleanInput);

  // Extract repeat config
  const repeat = extractRepeatConfig(cleanInput);

  // Extract tags (words with # prefix)
  const tags = extractTags(cleanInput);

  // Clean title by removing parsed elements
  const title = cleanTitle(cleanInput, estimated_minutes, priority, repeat, tags);

  return {
    title,
    type,
    estimated_minutes,
    tags: tags.length > 0 ? tags : undefined,
    priority,
    repeat,
  };
}

/**
 * Detect task type from keywords
 */
function detectTaskType(input: string): TaskType {
  const lowerInput = input.toLowerCase();

  // Check learning keywords
  if (TYPE_KEYWORDS.learning.some(keyword => lowerInput.includes(keyword))) {
    return 'learning';
  }

  // Check habit keywords
  if (TYPE_KEYWORDS.habit.some(keyword => lowerInput.includes(keyword))) {
    return 'habit';
  }

  // Check project keywords
  if (TYPE_KEYWORDS.project.some(keyword => lowerInput.includes(keyword))) {
    return 'project';
  }

  // Default to task
  return 'task';
}

/**
 * Extract time estimate in minutes
 */
function extractTimeEstimate(input: string): number | undefined {
  // Check for hours
  const hoursMatch = input.match(TIME_PATTERNS.hours);
  if (hoursMatch) {
    return parseInt(hoursMatch[1]) * 60;
  }

  // Check for minutes
  const minutesMatch = input.match(TIME_PATTERNS.minutes);
  if (minutesMatch) {
    return parseInt(minutesMatch[1]);
  }

  return undefined;
}

/**
 * Extract priority level
 */
function extractPriority(input: string): TaskPriority | undefined {
  const lowerInput = input.toLowerCase();

  if (PRIORITY_KEYWORDS.urgent.some(keyword => lowerInput.includes(keyword))) {
    return 'urgent';
  }

  if (PRIORITY_KEYWORDS.high.some(keyword => lowerInput.includes(keyword))) {
    return 'high';
  }

  if (PRIORITY_KEYWORDS.medium.some(keyword => lowerInput.includes(keyword))) {
    return 'medium';
  }

  if (PRIORITY_KEYWORDS.low.some(keyword => lowerInput.includes(keyword))) {
    return 'low';
  }

  return undefined;
}

/**
 * Extract repeat configuration
 */
function extractRepeatConfig(input: string): RepeatConfig | undefined {
  if (REPEAT_PATTERNS.daily.test(input)) {
    return { interval: 'daily' };
  }

  if (REPEAT_PATTERNS.weekly.test(input)) {
    return { interval: 'weekly' };
  }

  if (REPEAT_PATTERNS.monthly.test(input)) {
    return { interval: 'monthly' };
  }

  return undefined;
}

/**
 * Extract tags (words starting with #)
 */
function extractTags(input: string): string[] {
  const tagPattern = /#(\w+)/g;
  const matches = input.matchAll(tagPattern);
  return Array.from(matches, match => match[1]);
}

/**
 * Clean title by removing parsed keywords and metadata
 */
function cleanTitle(
  input: string,
  estimated_minutes?: number,
  priority?: TaskPriority,
  repeat?: RepeatConfig,
  tags: string[] = []
): string {
  let cleaned = input;

  // Remove time patterns
  cleaned = cleaned.replace(TIME_PATTERNS.hours, '');
  cleaned = cleaned.replace(TIME_PATTERNS.minutes, '');

  // Remove repeat patterns
  cleaned = cleaned.replace(REPEAT_PATTERNS.daily, '');
  cleaned = cleaned.replace(REPEAT_PATTERNS.weekly, '');
  cleaned = cleaned.replace(REPEAT_PATTERNS.monthly, '');

  // Remove priority keywords
  if (priority) {
    const priorityKeywords = Object.values(PRIORITY_KEYWORDS).flat();
    priorityKeywords.forEach(keyword => {
      const regex = new RegExp(`\\b${keyword}\\b`, 'gi');
      cleaned = cleaned.replace(regex, '');
    });
  }

  // Remove tags
  tags.forEach(tag => {
    cleaned = cleaned.replace(`#${tag}`, '');
  });

  // Remove type keywords for cleaner title
  const allTypeKeywords = Object.values(TYPE_KEYWORDS).flat();
  allTypeKeywords.forEach(keyword => {
    // Only remove if at the start of the sentence
    const regex = new RegExp(`^${keyword}\\s+`, 'gi');
    cleaned = cleaned.replace(regex, '');
  });

  // Clean up extra spaces and trim
  cleaned = cleaned.replace(/\s+/g, ' ').trim();

  // Capitalize first letter
  if (cleaned.length > 0) {
    cleaned = cleaned.charAt(0).toUpperCase() + cleaned.slice(1);
  }

  return cleaned || input; // Fallback to original if empty
}

/**
 * Generate examples for help text
 */
export function getQuickAddExamples(): string[] {
  return [
    'Learn SEO 1h daily',
    'Client meeting 30m high priority',
    'Write blog post 2hrs #content',
    'Daily standup 15m habit',
    'Build landing page project 4hrs',
    'Review analytics weekly 45m',
  ];
}

/**
 * Validate parsed result
 */
export function validateQuickAdd(parsed: QuickAddParsed): {
  valid: boolean;
  errors: string[];
} {
  const errors: string[] = [];

  if (!parsed.title || parsed.title.length < 3) {
    errors.push('Title must be at least 3 characters');
  }

  if (parsed.estimated_minutes !== undefined && parsed.estimated_minutes < 1) {
    errors.push('Time estimate must be at least 1 minute');
  }

  if (parsed.estimated_minutes !== undefined && parsed.estimated_minutes > 480) {
    errors.push('Time estimate cannot exceed 8 hours (480 minutes)');
  }

  return {
    valid: errors.length === 0,
    errors,
  };
}
