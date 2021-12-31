import 'package:flutter/material.dart';

const decorationInvisible = InputDecoration(
  border: InputBorder.none,
  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
  isDense: true,
  isCollapsed: true,
);

typedef ContactBuilder<T> = Widget Function(T? contact);

typedef GestureBuilder = Widget Function(void Function() pick, Widget child);
