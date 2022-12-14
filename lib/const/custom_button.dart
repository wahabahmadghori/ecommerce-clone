import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      this.radius,
      required this.buttonWidth,
      required this.function})
      : super(key: key);

  final String text;
  final BorderRadius? radius;
  final Function function;
  final double buttonWidth;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => function(),
      child: Material(
        elevation: 5,
        borderRadius: radius ?? BorderRadius.circular(20),
        color: const Color.fromRGBO(30, 62, 160, 1),
        child: Container(
            height: size.height / 17,
            width: size.width / buttonWidth,
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width / 22,
                fontWeight: FontWeight.w500,
              ),
            )),
      ),
    );
  }
}
