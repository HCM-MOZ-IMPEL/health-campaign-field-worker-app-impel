import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class IRSWrapperPage extends StatelessWidget {
  const IRSWrapperPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "IRS Page",
            style: TextStyle(color: Colors.amber),
          ),
        ),
        body: Text("IRS BODY"));
  }
}
