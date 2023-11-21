import 'package:ai_chatty/Utils/constants.dart';
import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({Key? key}) : super(key: key);

  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Row(
            children: [
              SizedBox(
                width: 10,
                child: Opacity(
                  opacity: _animation.value,
                  child: Container(
                    color: Colors.grey,
                    height: 8,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: 10,
                child: Opacity(
                  opacity: _animation.value,
                  child: Container(
                    color: purple_clr,
                    height: 16,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: 10,
                child: Opacity(
                  opacity: _animation.value,
                  child: Container(
                    color: Colors.grey,
                    height: 8,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
