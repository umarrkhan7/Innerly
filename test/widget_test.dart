import 'package:flutter_test/flutter_test.dart';
import 'package:innerly/app/app.dart';

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const InnerlyApp());
    await tester.pump();
  });
}