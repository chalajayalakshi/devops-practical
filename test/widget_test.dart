import 'package:flutter_test/flutter_test.dart';

import 'package:devops_practical/main.dart';

void main() {
  testWidgets('shows the V1 welcome message', (WidgetTester tester) async {
    await tester.pumpWidget(const DevOpsApp());

    expect(find.text('Hello, DevOps World! V1'), findsOneWidget);
  });
}
