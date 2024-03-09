import 'package:flutter/material.dart';

class RoundButton extends StatefulWidget {
  final VoidCallback Onpress;
  final Text title;
  final bool? Loading;
  RoundButton(
      {super.key, required this.Onpress, required this.title, this.Loading});

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 350,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
          onPressed: widget.Onpress,
          child: widget.Loading != null && widget.Loading!
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )
              : widget.title),
    );
  }
}
