// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
//
// class ExpandableTutorial extends StatefulWidget {
//   @override
//   _ExpandableTutorialState createState() => _ExpandableTutorialState();
// }
//
// class _ExpandableTutorialState extends State<ExpandableTutorial> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Expanded"),
//       ),
//       body: ListView(
//         children: [
//           Card1(),
//           Card2(),
//         ],
//       ),
//     );
//   }
// }
//
// String loremIpsum = "loremIpsum lorem Ipsum lorem Ipsum";
//
// class Card1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ExpandableNotifier(
//       child: Padding(
//         padding: EdgeInsets.all(10),
//         child: Card(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 150,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.purple,
//                     shape: BoxShape.rectangle,
//                   ),
//                 ),
//               ),
//               ScrollOnExpand(
//                 child: ExpandablePanel(
//                   theme: ExpandableThemeData(
//                       tapBodyToCollapse: true,
//                       tapBodyToExpand: true
//                   ),
//                   header: Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Text(
//                       "Expandable Panel",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   expanded: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       for (var _ in Iterable.generate(5))
//                         Padding(
//                           padding: EdgeInsets.only(bottom: 10),
//                           child: Text(loremIpsum,
//                               softWrap: true,
//                               overflow: TextOverflow.fade,
//                               style: TextStyle(color: Colors.black)),
//                         ),
//                     ],
//                   ),
//                   collapsed: Text(loremIpsum,
//                       softWrap: true,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(color: Colors.black)),
//                   builder: (_, collapsed, expanded) {
//                     return Padding(
//                       padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                       child: Expandable(
//                         collapsed: collapsed,
//                         expanded: expanded,
//                         theme: const ExpandableThemeData(crossFadePoint: 0),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Card2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     buildImg(Color color, double height) {
//       return SizedBox(
//         height: height,
//         child: Container(
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.rectangle,
//           ),
//         ),
//       );
//     }
//
//     buildCollapsed1() {
//       return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Expandable",
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ],
//               ),
//             ),
//           ]);
//     }
//
//     buildCollapsed2() {
//       return buildImg(Colors.blue, 150);
//     }
//
//     buildCollapsed3() {
//       return Container();
//     }
//
//     buildExpanded1() {
//       return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Expandable",
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   Text(
//                     "3 Expandable widgets",
//                     style: Theme.of(context).textTheme.caption,
//                   ),
//                 ],
//               ),
//             ),
//           ]);
//     }
//
//     buildExpanded2() {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               Expanded(child: buildImg(Colors.lightGreenAccent, 100)),
//               Expanded(child: buildImg(Colors.orange, 100)),
//             ],
//           ),
//           Row(
//             children: <Widget>[
//               Expanded(child: buildImg(Colors.lightBlue, 100)),
//               Expanded(child: buildImg(Colors.cyan, 100)),
//             ],
//           ),
//         ],
//       );
//     }
//
//     buildExpanded3() {
//       return Padding(
//         padding: EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               loremIpsum,
//               softWrap: true,
//               style: TextStyle(color: Colors.black),
//             ),
//           ],
//         ),
//       );
//     }
//
//     return ExpandableNotifier(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//           child: ScrollOnExpand(
//             child: Card(
//               clipBehavior: Clip.antiAlias,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Expandable(
//                     collapsed: buildCollapsed1(),
//                     expanded: buildExpanded1(),
//                   ),
//                   Expandable(
//                     collapsed: buildCollapsed2(),
//                     expanded: buildExpanded2(),
//                   ),
//                   Expandable(
//                     collapsed: buildCollapsed3(),
//                     expanded: buildExpanded3(),
//                   ),
//                   Divider(
//                     height: 1,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       Builder(
//                         builder: (context) {
//                           var controller = ExpandableController.of(context,
//                               rebuildOnChange: true);
//                           return TextButton(
//                             child: Text(
//                               controller.expanded ? "COLLAPSE" : "EXPAND",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .button
//                                   .copyWith(color: Colors.deepPurple),
//                             ),
//                             onPressed: () {
//                               controller.toggle();
//                             },
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }