/**
 * Animated Progress Ring Component
 */

import { motion } from 'framer-motion';
import { useEffect, useState } from 'react';

interface ProgressRingProps {
  current: number;
  target: number;
  label: string;
  color?: string;
  size?: number;
  strokeWidth?: number;
  showPercentage?: boolean;
}

export function ProgressRing({
  current,
  target,
  label,
  color = '#6366f1',
  size = 120,
  strokeWidth = 8,
  showPercentage = true,
}: ProgressRingProps) {
  const [progress, setProgress] = useState(0);

  const radius = (size - strokeWidth) / 2;
  const circumference = radius * 2 * Math.PI;
  const percentage = Math.min((current / target) * 100, 100);

  useEffect(() => {
    setProgress(percentage);
  }, [percentage]);

  const strokeDashoffset = circumference - (progress / 100) * circumference;

  return (
    <div className="flex flex-col items-center gap-2">
      <div className="relative" style={{ width: size, height: size }}>
        {/* Background circle */}
        <svg width={size} height={size} className="transform -rotate-90">
          <circle
            cx={size / 2}
            cy={size / 2}
            r={radius}
            fill="none"
            stroke="currentColor"
            strokeWidth={strokeWidth}
            className="text-dark-200 dark:text-dark-700"
          />

          {/* Progress circle */}
          <motion.circle
            cx={size / 2}
            cy={size / 2}
            r={radius}
            fill="none"
            stroke={color}
            strokeWidth={strokeWidth}
            strokeLinecap="round"
            strokeDasharray={circumference}
            initial={{ strokeDashoffset: circumference }}
            animate={{ strokeDashoffset }}
            transition={{
              duration: 1,
              ease: 'easeOut',
              type: 'spring',
              damping: 20,
            }}
          />
        </svg>

        {/* Center text */}
        <div className="absolute inset-0 flex flex-col items-center justify-center">
          <motion.div
            className="text-2xl font-bold text-dark-900 dark:text-white"
            initial={{ scale: 0 }}
            animate={{ scale: 1 }}
            transition={{ delay: 0.2, type: 'spring', stiffness: 200 }}
          >
            {current}
          </motion.div>
          {showPercentage && (
            <div className="text-xs text-dark-500 dark:text-dark-400">
              {Math.round(percentage)}%
            </div>
          )}
        </div>
      </div>

      {/* Label */}
      <div className="text-sm font-medium text-dark-700 dark:text-dark-300 text-center">
        {label}
      </div>
      <div className="text-xs text-dark-500 dark:text-dark-400">
        / {target}
      </div>
    </div>
  );
}
