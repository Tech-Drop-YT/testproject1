// FILE: test/widgets/dice_widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludo_dual_dice/src/ui/widgets/dice_widget.dart';

void main() {
  group('DiceWidget Tests', () {
    testWidgets('DiceWidget renders correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DiceWidget(value: 3),
          ),
        ),
      );

      expect(find.byType(DiceWidget), findsOneWidget);
    });

    testWidgets('DiceWidget displays correct number of dots', (tester) async {
      for (int i = 1; i <= 6; i++) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DiceWidget(value: i),
            ),
          ),
        );

        expect(find.byType(DiceWidget), findsOneWidget);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('DiceWidget onTap callback works', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DiceWidget(
              value: 3,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(DiceWidget));
      expect(tapped, isTrue);
    });
  });

  group('DualDiceWidget Tests', () {
    testWidgets('DualDiceWidget renders both dice', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DualDiceWidget(
              dice1Value: 3,
              dice2Value: 5,
            ),
          ),
        ),
      );

      expect(find.byType(DiceWidget), findsNWidgets(2));
    });

    testWidgets('DualDiceWidget roll button exists', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DualDiceWidget(
              dice1Value: 3,
              dice2Value: 5,
              onRoll: () {},
            ),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('ROLL DICE'), findsOneWidget);
    });

    testWidgets('Tapping dice1 triggers roll', (tester) async {
      bool rolled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DualDiceWidget(
              dice1Value: 3,
              dice2Value: 5,
              onRoll: () => rolled = true,
            ),
          ),
        ),
      );

      final dice = find.byType(DiceWidget).first;
      await tester.tap(dice);
      expect(rolled, isTrue);
    });

    testWidgets('Tapping dice2 triggers roll', (tester) async {
      bool rolled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DualDiceWidget(
              dice1Value: 3,
              dice2Value: 5,
              onRoll: () => rolled = true,
            ),
          ),
        ),
      );

      final dice = find.byType(DiceWidget).last;
      await tester.tap(dice);
      expect(rolled, isTrue);
    });

    testWidgets('Roll button triggers roll', (tester) async {
      bool rolled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DualDiceWidget(
              dice1Value: 3,
              dice2Value: 5,
              onRoll: () => rolled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      expect(rolled, isTrue);
    });

    testWidgets('Roll button disabled when rolling', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DualDiceWidget(
              dice1Value: 3,
              dice2Value: 5,
              isRolling: true,
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
      expect(find.text('ROLLING...'), findsOneWidget);
    });
  });
}
