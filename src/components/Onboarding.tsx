import { useState } from 'react';
import { Button } from './ui/Button';
import { Card } from './ui/Card';
import { useStore } from '@/store';
import { motion, AnimatePresence } from 'framer-motion';

const steps = [
  {
    title: 'Welcome to SparkFlow! 🚀',
    description: 'Your journey to consistent productivity starts here. Let\'s set you up for success!',
  },
  {
    title: 'Choose Your Focus Areas',
    description: 'Select the skills you want to develop (SEO, Ads, WordPress, etc.)',
  },
  {
    title: 'Set Daily Learning Goal',
    description: 'How many minutes per day do you want to dedicate to learning?',
  },
  {
    title: 'Ready to Spark! ⚡',
    description: 'Let\'s start your first 25-minute focus sprint!',
  },
];

export function Onboarding() {
  const [currentStep, setCurrentStep] = useState(0);
  const { completeOnboarding } = useStore();

  const handleNext = () => {
    if (currentStep < steps.length - 1) {
      setCurrentStep(currentStep + 1);
    } else {
      completeOnboarding();
    }
  };

  const handleBack = () => {
    if (currentStep > 0) {
      setCurrentStep(currentStep - 1);
    }
  };

  const step = steps[currentStep];

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-primary-900 via-dark-900 to-secondary-900 p-4">
      <div className="w-full max-w-2xl">
        <AnimatePresence mode="wait">
          <motion.div
            key={currentStep}
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: -20 }}
            transition={{ duration: 0.3 }}
          >
            <Card variant="glass" padding="lg">
              <div className="text-center mb-8">
                <h2 className="text-3xl font-bold mb-2">{step.title}</h2>
                <p className="text-dark-300">{step.description}</p>
              </div>

              {currentStep === 1 && (
                <div className="grid grid-cols-2 gap-3 mb-6">
                  {['SEO', 'Google Ads', 'Facebook Ads', 'WordPress'].map((skill) => (
                    <button
                      key={skill}
                      className="px-4 py-3 rounded-funky-sm bg-dark-800 hover:bg-primary-600 transition-colors"
                    >
                      {skill}
                    </button>
                  ))}
                </div>
              )}

              {currentStep === 2 && (
                <div className="mb-6">
                  <input
                    type="range"
                    min="15"
                    max="180"
                    step="15"
                    defaultValue="60"
                    className="w-full"
                  />
                  <p className="text-center text-2xl font-bold mt-4">60 minutes/day</p>
                </div>
              )}

              <div className="flex gap-3">
                {currentStep > 0 && (
                  <Button variant="outline" onClick={handleBack}>
                    Back
                  </Button>
                )}
                <Button fullWidth onClick={handleNext}>
                  {currentStep === steps.length - 1 ? 'Start SparkFlow' : 'Next'}
                </Button>
              </div>

              <div className="flex justify-center gap-2 mt-6">
                {steps.map((_, index) => (
                  <div
                    key={index}
                    className={`w-2 h-2 rounded-full ${
                      index === currentStep ? 'bg-primary-500' : 'bg-dark-700'
                    }`}
                  />
                ))}
              </div>
            </Card>
          </motion.div>
        </AnimatePresence>
      </div>
    </div>
  );
}
