import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/app.dart';
import 'package:ludoteca/2_application/pages/home/home_page.dart';
import 'package:ludoteca/2_application/pages/pages_shell.dart';

void main() {
  testWidgets('should render PagesShell', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.byType(PagesShell), findsOneWidget);
  });

  testWidgets('should route to HomePage by default', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.byType(HomePage), findsOneWidget);
  });
}
