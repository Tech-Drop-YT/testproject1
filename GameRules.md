# Ludo Dual Dice - Complete Game Rules

## Overview
Ludo Dual Dice is a modern implementation of Ludo with professional-grade rules and a unique dual dice system. This document describes all game rules in detail.

---

## 🎲 DUAL DICE SYSTEM (Core Feature)

### Basic Mechanics
- **Every turn uses TWO dice**
- **Rolling ONE die automatically rolls BOTH dice**
- **Three ways to trigger a roll:**
  1. Tap Dice 1 → both dice roll
  2. Tap Dice 2 → both dice roll
  3. Tap "ROLL" button → both dice roll

### Dice Behavior
- Each die shows values 1-6
- Both dice include:
  - Shake animation during roll
  - Bounce physics on landing
  - Glow effect when rollable
  - Roll sound effect

---

## 🟢 TOKEN MOVEMENT RULES

### Movement Options
After rolling both dice, a player may choose ONE of the following:

1. **Move one token by (dice1 + dice2)**
   - Example: Roll 3 and 4 → move one token 7 steps

2. **Move one token using dice1 only**
   - Example: Roll 3 and 4 → move one token 3 steps

3. **Move one token using dice2 only**
   - Example: Roll 3 and 4 → move one token 4 steps

4. **Move two different tokens (one per die)**
   - Example: Roll 3 and 4 → move token A 3 steps, move token B 4 steps

### Releasing Tokens from Home
- Tokens start in the home area (colored corner)
- **Need at least ONE 6 to release a token**
- Can use either dice1 or dice2 if it shows 6
- Released token moves to the starting square of its color

### Board Movement
- Tokens move clockwise around the board
- Board has 52 squares total
- Each player has a starting position:
  - Red: Position 1
  - Green: Position 14
  - Yellow: Position 27
  - Blue: Position 40

---

## ⭐ SPECIAL SQUARES

### Safe Squares
- **Positions:** 1, 9, 14, 22, 27, 35, 40, 48
- **Rules:**
  - Tokens on safe squares CANNOT be killed
  - Multiple tokens can occupy the same safe square
  - Safe squares have a blue glow effect

### Star Squares
- **Positions:** 5, 18, 31, 44
- **Rules:**
  - Landing on a star square is safe
  - Star squares have a yellow/gold glow effect
  - No special movement bonus (cosmetic only in this version)

---

## ⚔️ KILL RULES

### Basic Kill
- Landing on the same square as an opponent's token **kills** it
- Killed token returns to its home area
- **Exception:** Cannot kill on safe squares or star squares

### Kill Bonus
- **Killing an opponent grants an EXTRA TURN**
- This stacks with other extra turn bonuses

### Block Rules
- **Two tokens of the SAME color on the same square form a BLOCK**
- Blocks are unbreakable - opponents cannot land on or pass through
- Own tokens also cannot land on the block
- Blocking is a strategic defensive move

---

## 🏠 HOME PATH AND FINAL HOME

### Entering Home Path
- Each color has a home entry position:
  - Red: Position 51
  - Green: Position 12
  - Yellow: Position 25
  - Blue: Position 38
- After completing the circuit, tokens enter the colored home path
- Home path has 6 squares leading to the center
- **Entering the home path grants an EXTRA TURN**

### Home Path Movement
- Tokens in home path move toward the center
- Cannot overshoot - must roll exact number to reach final home
- If roll is too high, no move is possible with that token

### Reaching Final Home
- **Exact roll required** to reach the center (position 6 in home path)
- **Reaching final home grants an EXTRA TURN**
- Token is marked as "finished"
- Finished tokens cannot be moved again

---

## 🎯 EXTRA TURN RULES (Ludo Pro Standard)

### 1. Single 6 → 1 Extra Turn
- Rolling ONE 6 (dice1=6, dice2≠6 OR dice1≠6, dice2=6)
- Grants **1 extra turn** after current turn completes

### 2. Double 6 → 2 Extra Turns
- Rolling BOTH 6s (dice1=6, dice2=6)
- Grants **2 extra turns** after current turn completes
- Does NOT count as two single 6s

### 3. Triple 6 → Turn Cancelled ⚠️
- Rolling double 6 THREE times in a row
- **Entire turn is CANCELLED**
- All moves made in that turn are UNDONE
- No extra turns granted
- Turn immediately passes to next player
- Counter resets after turn passes

### 4. Kill Bonus → Extra Turn
- Killing an opponent's token grants **1 extra turn**
- Stacks with other bonuses

### 5. Entering Home Path → Extra Turn
- First move into the colored home row grants **1 extra turn**
- Only triggers on initial entry, not subsequent moves

### 6. Reaching Final Home → Extra Turn
- Moving a token into the final center position grants **1 extra turn**
- Grants turn for EACH token that finishes

### 7. Stackable Bonuses
- Extra turns accumulate from multiple sources
- Example: Roll 6+6, kill opponent, enter home = 2+1+1 = 4 extra turns
- All bonuses stack EXCEPT when triple 6 occurs
- **Triple 6 cancels ALL bonuses** from that turn

### 8. No-Move Rule
- If a player cannot make ANY valid move, they get NO extra turn
- This applies even if they rolled a 6
- If all tokens are home and no 6 is rolled, turn passes immediately
- If valid moves exist but player cannot execute them (blocked), no extra turn

---

## 👥 PLAYER CONFIGURATION

### Player Count
- **2 Players:** Red vs Green
- **3 Players:** Red vs Green vs Yellow
- **4 Players:** Red vs Green vs Yellow vs Blue

### Player Types
- **Human:** Controlled by the player
- **Bot (Easy):** Makes random valid moves
- **Bot (Medium):** Prioritizes kills and progress
- **Bot (Hard):** Strategic play, aggressive killing, smart home entry

---

## 🏆 WINNING CONDITION

### How to Win
- **First player to get all 4 tokens to final home wins**
- Game displays winner with animation and sound
- Winner screen shows celebration effects

### Game End
- Game ends immediately when a player finishes their 4th token
- No further moves are made
- Players can start a new game or return to menu

---

## 🎮 TURN SEQUENCE

1. **Roll Dice Phase**
   - Player taps dice or roll button
   - Both dice roll simultaneously
   - Dice show result with animation

2. **Move Selection Phase**
   - Valid moves are highlighted
   - Player selects a token to move
   - If no valid moves, turn passes automatically

3. **Move Execution Phase**
   - Token animates to new position
   - Kill animation plays if applicable
   - Extra turns calculated

4. **Extra Turn Check**
   - If extra turns exist, same player goes again
   - If no extra turns, advance to next player
   - Triple 6 cancels turn and passes to next player

5. **Next Turn**
   - Turn indicator updates
   - Next player can roll dice

---

## 📊 GAME STATISTICS

### Token States
- **Home:** In starting area (not released)
- **Active:** On the main board
- **Home Path:** In colored path to center
- **Finished:** Reached final home

### Tracking
- Each player's finished token count (0-4)
- Current player indicator
- Extra turns remaining
- Turn count (total turns in game)

---

## 🎨 VISUAL INDICATORS

### Token Highlighting
- **Glow effect:** Token can be moved with current dice
- **Selected token:** Amber border
- **Normal token:** Standard color with gradient

### Turn Indicator
- **Current player:** Name shown with color
- **Pulse animation:** On current player's indicator
- **Status message:** Shows current game state

### Dice States
- **Ready to roll:** Subtle glow
- **Rolling:** Shake animation
- **Result:** Bounce and settle

---

## 🔧 ADVANCED RULES

### Exact Roll Rule
- Must roll exact number to enter final home
- Overshots are not allowed
- If only move available is overshoot, no move possible

### Starting Position Rules
- Released tokens always go to their color's starting square
- Starting square is a safe square
- Multiple own tokens can occupy starting square

### Home Path Priority
- Once in home path, tokens cannot leave
- Home path is color-specific
- Only own tokens can enter own home path

### Move Validation
- All moves validated before execution
- Invalid moves are filtered out automatically
- Only highlighted tokens can be selected

---

## 🎯 STRATEGY TIPS

1. **Release tokens early:** More tokens = more options
2. **Use blocking:** Two tokens together are safe
3. **Kill strategically:** Sends opponents back and grants extra turn
4. **Save 6s for releases:** If possible, use other values for movement
5. **Protect lead tokens:** Don't leave them vulnerable near opponents
6. **Home path timing:** Enter when you can make progress safely
7. **Extra turn stacking:** Combine bonuses for multiple consecutive turns

---

## 📱 CONTROLS

### Touch Controls
- **Tap Dice 1:** Roll both dice
- **Tap Dice 2:** Roll both dice
- **Tap ROLL button:** Roll both dice
- **Tap highlighted token:** Execute move with that token
- **Tap menu button:** Access game menu

### Automatic Actions
- **No valid moves:** Turn passes automatically after 1.5 seconds
- **Bot turns:** Execute automatically with AI delay
- **Win detection:** Game ends and shows winner immediately

---

## ❓ FREQUENTLY ASKED QUESTIONS

**Q: Can I split the dice between two tokens?**
A: Yes! That's one of the four movement options.

**Q: What happens if I roll triple 6?**
A: Your entire turn is cancelled, all moves undone, and play passes to the next player.

**Q: Can I kill on a safe square?**
A: No, safe squares protect all tokens.

**Q: Do extra turns stack?**
A: Yes! Except when triple 6 occurs - that cancels everything.

**Q: Can I pass my turn voluntarily?**
A: No, if valid moves exist, you must make one.

**Q: How many tokens can be on one square?**
A: Two same-color tokens form a block. Otherwise, only one token per square (except safe squares).

---

**Enjoy the strategic depth of Ludo Dual Dice! 🎲**
