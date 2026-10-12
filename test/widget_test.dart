import 'package:flutter_test/flutter_test.dart';
import 'package:buildlock/main.dart';

void main() {
  testWidgets('BuildLock app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BuildLockApp());
    expect(find.text('BuildLock'), findsOneWidget);
  });
}
