import 'package:flutter/material.dart';

class IconCategory extends StatelessWidget {
  final String title;
  final String? imageUrl;

  const IconCategory({Key? key, required this.title, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 100.0,
        height: 130,
        child: Column(
          children: [
            Container(
              height: 80.0,
              width: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.5)
                ],
                image: DecorationImage(
                  image: NetworkImage(imageUrl ?? 'assets/images/cm1.jpeg'),
                  onError: (context, error) {
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: Theme.of(context).textTheme.button,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
