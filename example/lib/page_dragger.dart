import 'package:flutter/material.dart';
import 'dart:async';

class PageDragger extends StatefulWidget {
  final StreamController<double> stream;
  final Widget child;
  PageDragger({ this.stream, this.child });

  @override
  _PageDraggerState createState() => new _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  Offset dragStart;
  
  onDragStart(DragStartDetails details) {
    dragStart = details.globalPosition;
  }

  onDragUpdate(DragUpdateDetails details) {
    if(dragStart != null) {
      final newPosition = details.globalPosition;
      final dx = dragStart.dx - newPosition.dx;
      final slidePercent = (dx / 300).abs().clamp(0.0, 1.0);
      this.widget.stream.sink.add(slidePercent);
    }
  }

  onDragEnd(DragEndDetails details) {
    
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
      child: widget.child,
    );
  }
}