import 'package:flutter/material.dart';

import 'widgets.dart';

class BottomNavigationFrave extends StatelessWidget {

  final int index;

  const BottomNavigationFrave(this.index);

  @override
  Widget build(BuildContext context)
  {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: -5)
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ItemButton(
            i: 0, 
            index: index, 
            iconData: Icons.home_outlined, 
            text: 'Home',
            onPressed: () {}
            ),
          _ItemButton(
            i: 1, 
            index: index, 
            iconData: Icons.search, 
            text: 'Search',
            onPressed:  () {}
            ),
          _ItemButton(
            i: 2, 
            index: index, 
            iconData: Icons.local_mall_outlined, 
            text: 'Cart',
            onPressed:  () {}
          ),
          _ItemButton(
            i: 3, 
            index: index, 
            iconData: Icons.person_outline_outlined, 
            text: 'Profile',
            onPressed: () {}
            ),
        ],
      )
    );
  }
}

class _ItemButton extends StatelessWidget {
  
  final int i;
  final int index;
  final IconData iconData;
  final String text;
  final VoidCallback? onPressed;

  const _ItemButton({ required this.i, required this.index, required this.iconData, required this.text, this.onPressed });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
        decoration: BoxDecoration(
          color: ( i == index ) ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(15.0)
        ),
        child: ( i == index ) 
          ? Row(
            children: [
                Icon(iconData, color: Colors.white, size: 25),
                const SizedBox(width: 6.0),
                TextFrave(text: text, fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500 )
              ],
            )
          :  Icon(iconData, size: 28),
      ),
    );
  }
}