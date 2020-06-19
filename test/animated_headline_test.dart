import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:animated_headline/animated_headline.dart';

void main() {
  testWidgets('AnimatedHeadline changes and animates text correctly',
      (WidgetTester tester) async {
    final headlineKey = GlobalKey();
    final buttonKey = GlobalKey();
    int index = 0;
    final widget = StatefulBuilder(
      builder: (context, void Function(void Function()) setState) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: <Widget>[
              AnimatedHeadline(
                key: headlineKey,
                texts: ['Title 1', 'Title 2'],
                colors: [Colors.blue, Colors.red],
                index: index,
              ),
              RaisedButton(
                key: buttonKey,
                child: Text('Tap'),
                onPressed: () => setState(() => index = 1),
              ),
            ],
          ),
        );
      },
    );

    await tester.pumpWidget(widget);

    expect(find.text('Title 1'), findsOneWidget);
    expect(find.text('Title 2'), findsNothing);

    await tester.tap(find.byKey(buttonKey));

    await tester.pumpAndSettle();

    expect(find.text('Title 1'), findsNothing);
    expect(find.text('Title 2'), findsOneWidget);
  });
}