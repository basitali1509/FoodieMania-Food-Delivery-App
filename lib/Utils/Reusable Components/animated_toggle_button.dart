import 'package:flutter/material.dart';

class AnimatedToggleButton extends StatefulWidget {
  final bool isOn;
  final Function(bool) onToggle;

  const AnimatedToggleButton({
    Key? key,
    required this.isOn,
    required this.onToggle,
  }) : super(key: key);

  @override
  _AnimatedToggleButtonState createState() => _AnimatedToggleButtonState();
}

class _AnimatedToggleButtonState extends State<AnimatedToggleButton> {
  bool _isOn = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isOn = !_isOn;
                widget.onToggle(_isOn);
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue.shade100,
              ),
              child: Stack(
                alignment: _isOn ? Alignment.topLeft : Alignment.topRight,
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.blue.shade600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
