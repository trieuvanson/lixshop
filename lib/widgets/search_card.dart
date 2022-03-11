import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lixshop/screens/auth/register_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Card(
        elevation: 6.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        "Search for Bột giặt, Nước giặt..."
                            .text
                            .gray500
                            .size(16)
                            .make(),
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
      ),
    );
  }
}
