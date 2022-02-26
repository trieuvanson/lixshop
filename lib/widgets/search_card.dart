import 'package:flutter/material.dart';
import 'package:lixshop/screens/login_screen.dart';
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
                  onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  ),
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
        // child: TextFormField(
        //   onTap: () => Navigator.of(context).pushNamed("/login"),
        //   readOnly: true,
        //   style: const TextStyle(
        //     fontSize: 15.0,
        //     color: Colors.black,
        //   ),
        //   focusNode: FocusNode(),
        //   decoration: InputDecoration(
        //     focusedBorder: InputBorder.none,
        //     // contentPadding: const EdgeInsets.all(10.0),
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(5.0),
        //       borderSide: const BorderSide(
        //         color: Colors.white,
        //       ),
        //     ),
        //     enabledBorder: OutlineInputBorder(
        //       borderSide: const BorderSide(
        //         color: Colors.white,
        //       ),
        //       borderRadius: BorderRadius.circular(5.0),
        //     ),
        //     hintText: "Search for Bột giặt, Nước giặt...",
        //     prefixIcon: const Icon(
        //       Icons.search,
        //       color: Colors.black,
        //     ),
        //     suffixIcon: const Icon(
        //       Icons.filter_list,
        //       color: Colors.black,
        //     ),
        //     hintStyle: const TextStyle(
        //       fontSize: 15.0,
        //       color: Colors.black,
        //     ),
        //   ),
        //   maxLines: 1,
        // ),
      ),
    );
  }
}
