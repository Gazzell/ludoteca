import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/pages/collection/widgets/item_play_properties.dart';

void main() {
  group('ItemPlayProperties', () {
    Widget widgetUnderTest(
        {int? minAge, int? minPlayers, int? maxPlayers, int? playingTime}) {
      return MaterialApp(
        home: Material(
          child: Column(children: [
            ItemPlayProperties(
              minAge: minAge,
              minPlayers: minPlayers,
              maxPlayers: maxPlayers,
              playingTime: playingTime,
            )
          ]),
        ),
      );
    }

    testWidgets('should not render anything if no data',
        (WidgetTester tester) async {
      await tester.pumpWidget(widgetUnderTest());

      expect(find.byIcon(Icons.child_care), findsNothing);
      expect(find.byIcon(Icons.people_alt_outlined), findsNothing);
      expect(find.byIcon(Icons.timer_outlined), findsNothing);
    });

    group('should render min age', () {
      testWidgets('with icon and age formated', (WidgetTester tester) async {
        await tester.pumpWidget(widgetUnderTest(minAge: 10));

        expect(find.byIcon(Icons.child_care), findsOneWidget);
        expect(find.text('10+'), findsOneWidget);
      });
    });

    group('should render players', () {
      testWidgets(
        'with icon and players, min and max players if minPlayers and maxPlayers are different',
        (WidgetTester tester) async {
          await tester
              .pumpWidget(widgetUnderTest(minPlayers: 2, maxPlayers: 4));

          expect(find.byIcon(Icons.people_alt_outlined), findsOneWidget);
          expect(find.text('2-4'), findsOneWidget);
        },
      );

      testWidgets(
        'with icon and players if minPlayers and maxPlayers are the same',
        (WidgetTester tester) async {
          await tester
              .pumpWidget(widgetUnderTest(minPlayers: 2, maxPlayers: 2));

          expect(find.byIcon(Icons.people_alt_outlined), findsOneWidget);
          expect(find.text('2'), findsOneWidget);
        },
      );
    });

    group('should render playing time', () {
      testWidgets(
        'with icon and time formated',
        (WidgetTester tester) async {
          await tester.pumpWidget(widgetUnderTest(playingTime: 100));

          expect(find.byIcon(Icons.timer_outlined), findsOneWidget);
          expect(find.text('100\''), findsOneWidget);
        },
      );
    });
  });
}
