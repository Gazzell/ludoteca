import 'package:flutter_test/flutter_test.dart';
import 'package:ludoteca/2_application/app.dart';
import 'package:ludoteca/2_application/pages/home/home_page.dart';


void main() {
  testWidgets('should render HomePage', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.byType(HomePage), findsOneWidget);
  });
}
