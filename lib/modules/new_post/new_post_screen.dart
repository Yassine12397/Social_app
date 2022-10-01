import 'package:flutter/material.dart';
import 'package:flutter_app/shared/components/component.dart';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context,title: 'Add Post'),
    );
  }
}
