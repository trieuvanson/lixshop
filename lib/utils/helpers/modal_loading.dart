
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

void modalLoading(BuildContext context){

  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white54, 
    builder: (context) 
      => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        content: SizedBox(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  TextFrave(text: 'Frave ', color: Colors.black, fontWeight: FontWeight.w500 ),
                  TextFrave(text: 'Food', fontWeight: FontWeight.w500),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10.0),
              Row(
                children: const [
                  CircularProgressIndicator( color: Colors.black),
                  SizedBox(width: 15.0),
                  TextFrave(text: 'Loading...')
                ],
              ),
            ],
          ),
        ),
      ),
  );

}