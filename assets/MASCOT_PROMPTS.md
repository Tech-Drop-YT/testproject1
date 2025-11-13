# SparkFlow Mascot SVG Generation Prompts

## Overview
The SparkFlow mascot is a friendly, encouraging character that appears throughout the app to provide motivation and celebrate user achievements. The mascot should be simple, modern, and convey positive energy.

## Style Guidelines
- **Art Style**: Flat vector illustration, clean outlines
- **Colors**: Pastel and bright colors (blues, purples, oranges from the app's color palette)
- **Shape Language**: Rounded, friendly shapes; avoid sharp angles
- **Size**: Optimized for 128x128px to 256x256px display
- **Format**: SVG with transparent background
- **Complexity**: Simple enough to animate smoothly, detailed enough to be expressive

## Character Options

### Option 1: Friendly Robot Mascot "Sparky"
**Recommended - Best fits the tech/productivity theme**

#### Pose 1: Idle (Default State)
```
Prompt: Flat vector SVG illustration of a cute friendly robot mascot named Sparky. Round body shape, large circular head with two dot eyes and a simple smile. Small antenna on top with a star at the end. Stubby arms at sides, standing on two small rounded feet. Colors: gradient from light blue (#a5b4fc) to indigo (#6366f1) for body, orange (#f97316) antenna star. Clean outlines, modern flat design style, playful and welcoming expression. Transparent background. Perfect for a productivity app icon.

Alt text: "Sparky the robot mascot in idle pose, smiling warmly"
```

#### Pose 2: Cheering (Task Complete/Achievement)
```
Prompt: Flat vector SVG illustration of Sparky the robot mascot in a cheering pose. Same round body and head design, but both arms raised up in celebration with star sparkles around them. Antenna bouncing with motion lines. Eyes shown as happy crescents, big smile. Small confetti pieces floating around. Dynamic energetic pose. Colors: gradient indigo blue body (#6366f1 to #818cf8), orange accents (#f97316), yellow/white sparkles. Transparent background.

Alt text: "Sparky the robot celebrating with arms raised and confetti"
```

#### Pose 3: Thinking (Planning/Learning Mode)
```
Prompt: Flat vector SVG illustration of Sparky the robot mascot in a thinking pose. Round body tilted slightly, one arm raised with hand/claw touching the side of head near antenna. Eyes looking up and to the side with small thought bubble containing a lightbulb above head. Thoughtful, focused expression. Colors: same indigo gradient body, yellow lightbulb (#fbbf24) in thought bubble. Clean lines, contemplative mood. Transparent background.

Alt text: "Sparky the robot in thinking pose with lightbulb thought bubble"
```

#### Pose 4: Sleepy/Resting (Break Time/Missed Streak)
```
Prompt: Flat vector SVG illustration of Sparky the robot mascot in a sleepy resting pose. Body slightly slumped, head tilted to one side, eyes shown as sleepy half-closed lines. Small "Z Z Z" symbols floating above antenna. One arm drooping, overall relaxed posture. Gentle, empathetic expression conveying need for rest. Colors: softer pastel version of indigo (#c7d2fe), antenna star dimmed. Transparent background.

Alt text: "Sparky the robot in sleepy resting pose with Z's floating above"
```

---

### Option 2: Rocket Ship Mascot "Spark"
**Alternative option - symbolizes progress and momentum**

#### Pose 1: Idle (Ready for Launch)
```
Prompt: Flat vector SVG illustration of a cute rocket ship mascot. Rounded rocket body in indigo (#6366f1), circular window with friendly smiley face inside, small fins at base, flame exhaust in orange/yellow gradient at bottom. Upright position, ready for launch. Simple, friendly design with rounded edges. Transparent background.

Alt text: "Spark the rocket mascot in ready position with friendly face"
```

#### Pose 2: Cheering (Taking Off)
```
Prompt: Flat vector SVG illustration of rocket ship mascot tilted dynamically as if taking off, trail of colorful exhaust flames (orange, yellow, pink gradient), sparkles and small stars around it. Face in window showing excited expression with starburst eyes. Motion lines behind. Energetic, victorious pose. Transparent background.

Alt text: "Spark the rocket blasting off with colorful exhaust trail"
```

#### Pose 3: Thinking (Calculating)
```
Prompt: Flat vector SVG illustration of rocket ship mascot hovering in place with small stabilizing flames, window showing thoughtful face with question mark or gears visible. Small mathematical symbols or plans floating around. Stationary, contemplative mood. Transparent background.

Alt text: "Spark the rocket hovering in thinking mode with symbols around"
```

#### Pose 4: Sleepy (Parked/Resting)
```
Prompt: Flat vector SVG illustration of rocket ship mascot landed on small platform, flames extinguished, window showing sleepy face with closed eyes and small Z's floating out. Tilted slightly to one side in resting position. Calm, restful colors (softer pastels). Transparent background.

Alt text: "Spark the rocket resting on platform with sleepy expression"
```

---

## Usage in App

### Where Mascot Appears:
1. **Timer Start**: Idle → Cheering transition
2. **Task Complete**: Cheering pose with confetti animation
3. **Learning Session**: Thinking pose
4. **Break Time**: Sleepy pose
5. **Missed Streak**: Sleepy pose with supportive message
6. **Level Up**: Cheering pose with special effects
7. **Loading States**: Idle pose with subtle bounce animation

### Animation Guidelines:
- **Entrance**: Fade in + scale from 0.8 to 1.0 (0.3s ease-out)
- **Exit**: Fade out + scale to 0.9 (0.2s ease-in)
- **Idle State**: Subtle floating animation (translateY ±3px, 3s ease-in-out loop)
- **Cheer**: Pop in with bounce (scale 0.8 → 1.2 → 1.0)
- **Transition**: Cross-fade between poses (0.3s)

### Size Specifications:
- **Dashboard**: 80x80px
- **Timer Widget**: 64x64px
- **Notifications**: 48x48px
- **Onboarding**: 128x128px

---

## Implementation Notes

1. **SVG Format**: Save as optimized SVG, remove unnecessary metadata
2. **Inline Usage**: Can be inlined as React components for best performance
3. **Color Theming**: Main body colors should use CSS variables for theme switching
4. **Accessibility**: Always include descriptive alt text
5. **Fallback**: Provide emoji fallback if SVGs fail to load

## Generation Tools
- **Recommended**: Midjourney, DALL-E 3, or Figma for vector creation
- **Post-processing**: SVGOMG for optimization
- **Testing**: Test all four poses at multiple sizes before implementation

---

## Example Integration Code

```typescript
import IdleMascot from '@/assets/mascot-idle.svg';
import CheeringMascot from '@/assets/mascot-cheering.svg';
import ThinkingMascot from '@/assets/mascot-thinking.svg';
import SleepyMascot from '@/assets/mascot-sleepy.svg';

const mascotPoses = {
  idle: IdleMascot,
  cheering: CheeringMascot,
  thinking: ThinkingMascot,
  sleepy: SleepyMascot,
};
```

Generate these SVGs using the prompts above and save them in `/public/assets/mascot-*.svg`.
