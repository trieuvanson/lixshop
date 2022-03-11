import 'package:flutter/material.dart';
import '../utils/const.dart';

class SlideItem extends StatefulWidget {
  final String img;
  final String title;
  final String address;
  final String rating;

  const SlideItem({
    Key? key,
    required this.img,
    required this.title,
    required this.address,
    required this.rating,
  }) : super(key: key);

  @override
  _SlideItemState createState() => _SlideItemState();
}

class _SlideItemState extends State<SlideItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                constraints: const BoxConstraints(
                    minHeight: 300),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.network(
                    widget.img,
                    height: 300,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      print('$error');
                      return const Center(
                        child: Icon(Icons.error),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 6.0,
                right: 6.0,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Constants.ratingBG,
                          size: 10,
                        ),
                        Text(
                          " ${widget.rating} ",
                          style: const TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 6.0,
                left: 6.0,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      " OPEN ",
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
