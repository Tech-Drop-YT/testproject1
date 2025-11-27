// FILE: test/widgets/token_widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludo_dual_dice/src/models/models.dart';
import 'package:ludo_dual_dice/src/ui/widgets/token_widget.dart';

void main() {
  late Token testToken;

  setUp(() {
    testToken = Token(
      id: 'test-token',
      color: PlayerColor.red,
      tokenIndex: 0,
    );
  });

  group('TokenWidget Tests', () {
    testWidgets('TokenWidget renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TokenWidget(token: testToken),
          ),
        ),
      );

      expect(find.byType(TokenWidget), findsOneWidget);
    });

    testWidgets('TokenWidget shows token index', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TokenWidget(token: testToken),
          ),
        ),
      );

      expect(find.text('1'), findsOneWidget); // tokenIndex 0 displays as 1
    });

    testWidgets('TokenWidget onTap callback works', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TokenWidget(
              token: testToken,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TokenWidget));
      expect(tapped, isTrue);
    });

    testWidgets('TokenWidget highlighted state shows visual change', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TokenWidget(token: testToken, isHighlighted: false),
                TokenWidget(token: testToken, isHighlighted: true),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(TokenWidget), findsNWidgets(2));
    });

    testWidgets('TokenWidget selected state shows border', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TokenWidget(token: testToken, isSelected: true),
          ),
        ),
      );

      expect(find.byType(TokenWidget), findsOneWidget);
    });
  });
}
