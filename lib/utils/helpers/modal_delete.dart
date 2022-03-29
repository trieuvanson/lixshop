
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

void modalDelete(BuildContext context, String name, String image, VoidCallback onPressed){

  showDialog(
    context: context,
    barrierColor: Colors.white54, 
    builder: (context) 
      => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        content: Container(
          height: 196,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      TextFrave(text: 'Frave ', color: Colors.red, fontWeight: FontWeight.w500 ),
                      TextFrave(text: 'Food', fontWeight: FontWeight.w500),
                    ],
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close)
                  )
                ],
              ),
              const Divider(),
              const SizedBox(height: 10.0),
              const TextFrave(text: 'Are you sure?'),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        scale: 7,
                        image: NetworkImage("https://fravefood.com/wp-content/uploads/2019/06/frave-food-logo-1.png")
                      )
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  TextFrave(
                    text: name,
                    maxLine: 2,
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              BtnFrave(
                height: 45,
                color: Colors.red,
                text: 'DELETE',
                fontWeight: FontWeight.bold,
                onPressed: onPressed,
              )
            ],
          ),
        ),
      ),
  );

}