import 'package:flutter/material.dart';

class SampleScreen extends StatelessWidget {
  final Widget body;
  final Widget? title;

  const SampleScreen({Key? key, required this.body, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: body,
        ),
      ),
    );
  }
}
