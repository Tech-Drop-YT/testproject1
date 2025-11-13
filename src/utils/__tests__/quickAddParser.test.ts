/**
 * Tests for Quick Add Parser
 */

import { parseQuickAdd, validateQuickAdd } from '../quickAddParser';

describe('quickAddParser', () => {
  describe('parseQuickAdd', () => {
    it('should parse basic task', () => {
      const result = parseQuickAdd('Write blog post');
      expect(result.title).toBe('Write blog post');
      expect(result.type).toBe('task');
    });

    it('should detect learning type', () => {
      const result = parseQuickAdd('Learn SEO');
      expect(result.title).toBe('SEO');
      expect(result.type).toBe('learning');
    });

    it('should detect habit type', () => {
      const result = parseQuickAdd('Morning standup daily');
      expect(result.title).toBe('Morning standup');
      expect(result.type).toBe('habit');
      expect(result.repeat).toEqual({ interval: 'daily' });
    });

    it('should parse time in hours', () => {
      const result = parseQuickAdd('Client meeting 2h');
      expect(result.estimated_minutes).toBe(120);
      expect(result.title).toBe('Client meeting');
    });

    it('should parse time in minutes', () => {
      const result = parseQuickAdd('Quick call 30m');
      expect(result.estimated_minutes).toBe(30);
    });

    it('should parse combined hours and minutes', () => {
      const result = parseQuickAdd('Workshop 1h 30m');
      expect(result.estimated_minutes).toBe(90);
    });

    it('should detect high priority', () => {
      const result = parseQuickAdd('Fix critical bug high priority');
      expect(result.priority).toBe('high');
    });

    it('should detect urgent priority', () => {
      const result = parseQuickAdd('Deploy now urgent');
      expect(result.priority).toBe('urgent');
    });

    it('should extract tags', () => {
      const result = parseQuickAdd('Update portfolio #design #work');
      expect(result.tags).toContain('design');
      expect(result.tags).toContain('work');
    });

    it('should parse complex input', () => {
      const result = parseQuickAdd('Learn SEO 1h daily #marketing high priority');
      expect(result.title).toBe('SEO');
      expect(result.type).toBe('learning');
      expect(result.estimated_minutes).toBe(60);
      expect(result.repeat).toEqual({ interval: 'daily' });
      expect(result.tags).toContain('marketing');
      expect(result.priority).toBe('high');
    });

    it('should handle weekly repeat', () => {
      const result = parseQuickAdd('Team meeting weekly');
      expect(result.repeat).toEqual({ interval: 'weekly' });
    });

    it('should capitalize first letter of title', () => {
      const result = parseQuickAdd('write blog post');
      expect(result.title).toBe('Write blog post');
    });
  });

  describe('validateQuickAdd', () => {
    it('should validate correct input', () => {
      const parsed = parseQuickAdd('Learn SEO 1h');
      const validation = validateQuickAdd(parsed);
      expect(validation.valid).toBe(true);
      expect(validation.errors).toHaveLength(0);
    });

    it('should reject short titles', () => {
      const parsed = parseQuickAdd('ab');
      const validation = validateQuickAdd(parsed);
      expect(validation.valid).toBe(false);
      expect(validation.errors).toContain('Title must be at least 3 characters');
    });

    it('should reject negative time', () => {
      const parsed = { ...parseQuickAdd('Task'), estimated_minutes: -10 };
      const validation = validateQuickAdd(parsed);
      expect(validation.valid).toBe(false);
    });

    it('should reject excessive time', () => {
      const parsed = { ...parseQuickAdd('Task'), estimated_minutes: 500 };
      const validation = validateQuickAdd(parsed);
      expect(validation.valid).toBe(false);
      expect(validation.errors).toContain('Time estimate cannot exceed 8 hours (480 minutes)');
    });
  });
});
