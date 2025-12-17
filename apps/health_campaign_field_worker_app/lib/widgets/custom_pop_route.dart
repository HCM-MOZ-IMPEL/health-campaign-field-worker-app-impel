import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class GlobalBackHandler extends StatelessWidget {
  final Widget child;
  const GlobalBackHandler({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) => PopScope(
              canPop: !isKeyboardVisible, // ✅ check keyboard
              onPopInvoked: (didPop) {
                final isKeyboardVisible =
                    MediaQuery.of(context).viewInsets.bottom > 0;
                if (!didPop && isKeyboardVisible) {
                  FocusScope.of(context).unfocus(); // ✅ close keyboard
                }
              },
              child: child,
            ));
  }
}
