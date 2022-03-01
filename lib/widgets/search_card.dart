import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lixshop/screens/register_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: InkWell(
          // onTap: () => Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const LoginScreen(),
          //   ),
          // ),
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: 150,
            height: 50,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => Get.to(() => RegisterScreen(),
                      routeName: '/register',
                      transition: Transition.downToUp,
                      duration: const Duration(milliseconds: 300)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      "Search for Bột giặt, Nước giặt...".text.gray500.make(),
                    ],
                  ),
                ),
                // 64.widthBox,
                IconButton(
                  onPressed: () {
                    print('Search for camera');
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
