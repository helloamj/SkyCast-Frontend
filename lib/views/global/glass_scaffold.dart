import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skycast/views/theme/app_pallete.dart';

class GlassScaffold extends StatefulWidget {
  const GlassScaffold({
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

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    // Define the animation
    _animation = Tween(
      begin: 0.2,
      end: 0.3,
    ).animate(_controller);
  }

  @override
  void dispose() {
    // Dispose the animation controller when the state is disposed
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
          // Animated background container with gradient
          AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      // Apply opacity to the gradient colors based on the animation value
                      AppPallete.primaryWhite.level1
                          .withOpacity(_animation.value),
                      AppPallete.primaryBlue.level3!
                          .withOpacity(_animation.value),
                    ],
                  )),
                );
              }),

          // Backdrop filter to apply blur effect
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

          // Padding with the main content of the scaffold
          Padding(
            padding: const EdgeInsets.fromLTRB(20, kToolbarHeight, 20, 20),
            child: widget.body ?? const SizedBox(),
          ),
        ],
      ),
    );
  }
}
