// ignore_for_file: file_names

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/pages/WritePages/com_write_com.dart';
import 'package:flutter_main_page/pages/WritePages/com_write_event.dart';
import 'package:flutter_main_page/pages/WritePages/com_wrtie_job.dart';
import 'package:flutter_main_page/pages/mainPage/main_page_sub/main_community/FAB/action_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

const Duration _duration = Duration(milliseconds: 300);

class ExpandableFab extends StatefulWidget {
  final String user;
  final bool? isAdmin;
  const ExpandableFab(this.user, this.isAdmin, {Key? key}) : super(key: key);

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  bool _open = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        value: _open ? 1.0 : 0.0, duration: _duration, vsync: this);
    _expandAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          _ExpadableActionButton(
            distance: 210,
            degree: 90.0,
            progress: _expandAnimation,
            child: ActionButton(
                onPressed: () {
                  if (widget.isAdmin == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                WriteEventPage(widget.user))));
                  } else {
                    Fluttertoast.showToast(
                      msg: "관리자만 작성가능합니다.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      fontSize: 16,
                    );
                  }
                },
                icon: const Icon(
                  Icons.card_giftcard,
                  color: Colors.white,
                )),
          ),
          _ExpadableActionButton(
            distance: 140,
            degree: 90.0,
            progress: _expandAnimation,
            child: ActionButton(
                onPressed: () {
                  if (widget.isAdmin == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => WriteJobPage(widget.user))));
                  } else {
                    Fluttertoast.showToast(
                      msg: "관리자만 작성가능합니다.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      fontSize: 16,
                    );
                  }
                },
                icon: const Icon(
                  Icons.lightbulb,
                  color: Colors.white,
                )),
          ),
          _ExpadableActionButton(
            distance: 70,
            degree: 90.0,
            progress: _expandAnimation,
            child: ActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => WriteComPage(widget.user))));
                },
                icon: const Icon(
                  Icons.reorder,
                  color: Colors.white,
                )),
          ),
          _buildTabtoCloseFab(),
          _buildTabtoOpenFab(),
        ],
      ),
    );
  }

  AnimatedContainer _buildTabtoCloseFab() {
    return AnimatedContainer(
      duration: _duration,
      transformAlignment: Alignment.center,
      transform: Matrix4.rotationZ(_open ? 0 : pi / 4),
      child: FloatingActionButton(
        heroTag: null,
        backgroundColor: Colors.white,
        onPressed: toggle,
        child: Icon(
          Icons.close,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  AnimatedContainer _buildTabtoOpenFab() {
    return AnimatedContainer(
      duration: _duration,
      transformAlignment: Alignment.center,
      transform: Matrix4.rotationZ(_open ? 0 : pi / 4),
      child: AnimatedOpacity(
        duration: _duration,
        opacity: _open ? 0.0 : 1.0,
        child: FloatingActionButton(
          heroTag: null,
          onPressed: toggle,
          child: const Icon(Icons.close),
        ),
      ),
    );
  }

  void toggle() {
    _open = !_open;
    setState(() {
      if (_open)
        _controller.forward();
      else
        _controller.reverse();
    });
  }
}

class _ExpadableActionButton extends StatelessWidget {
  final double distance;
  final double degree;
  final Animation<double> progress;
  final Widget child;

  const _ExpadableActionButton(
      {Key? key,
      required this.distance,
      required this.degree,
      required this.progress,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: progress,
        builder: (context, child) {
          final Offset offset = Offset.fromDirection(
              degree * (pi / 180), progress.value * distance);

          return Positioned(
            right: offset.dx + 4,
            bottom: offset.dy + 4,
            child: child!,
          );
        },
        child: child);
  }
}
