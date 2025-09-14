import 'package:flutter/material.dart';

class Joinclass extends StatefulWidget {
  const Joinclass({super.key});

  @override
  State<Joinclass> createState() => _JoinclassState();
}

class _JoinclassState extends State<Joinclass>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}