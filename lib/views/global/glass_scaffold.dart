import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skycast/views/theme/app_pallete.dart';

class GlassScaffold extends StatefulWidget {
  GlassScaffold({
    super.key,
    this.body,
  });
  final Widget? body;

  @override
  State<GlassScaffold> createState() => _GlassScaffoldState();
}

class _GlassScaffoldState extends State<GlassScaffold>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween(
      begin: 0.2,
      end: 0.3,
    ).animate(_controller);
  }
  // dispose

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _scaff(context);
  }

  Scaffold _scaff(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppPallete.primaryYellow.level1
                                .withOpacity(_animation.value)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppPallete.primaryPurple.level1
                                .withOpacity(_animation.value)),
                      ),
                    ),
                  ],
                );
              }),
          BackdropFilter(
            blendMode: BlendMode.srcOver,
            filter: ImageFilter.blur(
              sigmaX: 100.0,
              sigmaY: 100.0,
            ),
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, kToolbarHeight, 20, 20),
            child: widget.body ?? const SizedBox(),
          ),
        ],
      ),
    );
  }
}
