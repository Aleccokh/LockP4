import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppCard extends StatefulWidget {
  const AppCard({Key? key}) : super(key: key);

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: const Text('Card Sample')),
        body: const CardExample(),
      ),
    );
  }
}

class CardExample extends StatefulWidget {
  const CardExample({super.key});

  @override
  State<CardExample> createState() => _CardExampleState();
}

class _CardExampleState extends State<CardExample> {
  bool locked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //App Icon
            CircleAvatar(
              child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/2048px-Instagram_icon.png"),
            ),
            const SizedBox(width: 8),
            const Text('Instagram'),
            const SizedBox(width: 8),
            Switch(
                value: locked,
                onChanged: (bool value) {
                  setState(() {
                    locked = value;
                  });
                }),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
