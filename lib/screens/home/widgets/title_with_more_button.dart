import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/constants.dart';

class TitleWithMoreButton extends StatelessWidget {
  const TitleWithMoreButton(
      {Key? key, required this.title, required this.onPressed})
      : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          TitleWithCustomUnderLiner(
            title: title,
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              ),
              elevation: MaterialStateProperty.all<double>(0),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: const Text(
              'Xem thêm',
              style: TextStyle(
                color: Vx.green500,
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleWithCustomUnderLiner extends StatelessWidget {
  const TitleWithCustomUnderLiner({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              height: 4,
              color: kPrimaryColor.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
