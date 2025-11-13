/**
 * Card Component with glassmorphism effect
 */

import { motion, HTMLMotionProps } from 'framer-motion';
import { ReactNode } from 'react';

interface CardProps extends Omit<HTMLMotionProps<'div'>, 'children'> {
  children: ReactNode;
  variant?: 'default' | 'glass' | 'gradient';
  padding?: 'none' | 'sm' | 'md' | 'lg';
  hover?: boolean;
}

const variants = {
  default: 'bg-white dark:bg-dark-800 shadow-md',
  glass: 'bg-white/10 dark:bg-dark-800/30 backdrop-blur-glass shadow-glass border border-white/20',
  gradient: 'bg-gradient-to-br from-primary-500 to-secondary-500 text-white shadow-funky',
};

const paddings = {
  none: '',
  sm: 'p-3',
  md: 'p-4',
  lg: 'p-6',
};

export function Card({
  children,
  variant = 'default',
  padding = 'md',
  hover = false,
  ...props
}: CardProps) {
  return (
    <motion.div
      className={`
        ${variants[variant]}
        ${paddings[padding]}
        rounded-funky
        ${hover ? 'cursor-pointer' : ''}
      `}
      initial={{ opacity: 0, y: 10 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.3 }}
      whileHover={hover ? { y: -4, transition: { duration: 0.2 } } : undefined}
      {...props}
    >
      {children}
    </motion.div>
  );
}
