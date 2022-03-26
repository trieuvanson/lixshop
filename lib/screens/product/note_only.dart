
// Widget _tabSection(BuildContext context) {
//   return DefaultTabController(
//     length: 2,
//     child: Column(
//       children: <Widget>[
//         const TabBar(
//           physics: BouncingScrollPhysics(),
//           isScrollable: true,
//           labelColor: Vx.green500,
//           unselectedLabelColor: Vx.gray500,
//           labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           indicator: UnderlineTabIndicator(
//             borderSide: BorderSide(
//               width: 3,
//               color: Vx.green500,
//             ),
//           ),
//           tabs: [
//             Tab(text: "Thông tin sản phẩm"),
//             Tab(text: "Khuyến mãi"),
//           ],
//         ),
//         SizedBox(
//           height: 310,
//           child: TabBarView(
//             children: [
//               SingleChildScrollView(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     color: DesignCourseAppTheme.nearlyWhite,
//                     borderRadius:
//                         const BorderRadius.all(Radius.circular(8.0)),
//                     boxShadow: <BoxShadow>[
//                       BoxShadow(
//                           color: DesignCourseAppTheme.grey.withOpacity(0.2),
//                           offset: const Offset(1.1, 1.1),
//                           blurRadius: 8.0),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                           child: "Thông tin chi tiết".text.bold.make(),
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         Divider(
//                           color: DesignCourseAppTheme.grey.withOpacity(0.6),
//                           height: 1,
//                         ),
//                         for (var i = 0; i < 4; i++)
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SizedBox(
//                                   width: 120,
//                                   child: Text(
//                                     'Tồn kho ${i + 1}',
//                                     style: const TextStyle(
//                                       color: DesignCourseAppTheme.darkerText,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width:
//                                       MediaQuery.of(context).size.width - 136,
//                                   child: Text(
//                                     "Đây là văn bản test $i",
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         const _ExpandAbleDescription(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: DesignCourseAppTheme.nearlyWhite,
//                   borderRadius: const BorderRadius.all(Radius.circular(8.0)),
//                   boxShadow: <BoxShadow>[
//                     BoxShadow(
//                         color: DesignCourseAppTheme.grey.withOpacity(0.2),
//                         offset: const Offset(1.1, 1.1),
//                         blurRadius: 8.0),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         child: "Thông tin chi tiết".text.bold.make(),
//                       ),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                       Divider(
//                         color: DesignCourseAppTheme.grey.withOpacity(0.6),
//                         height: 1,
//                       ),
//                       for (var i = 0; i < 4; i++)
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 width: 120,
//                                 child: Text(
//                                   'Tồn kho ${i + 1}',
//                                   style: const TextStyle(
//                                     color: DesignCourseAppTheme.darkerText,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width:
//                                     MediaQuery.of(context).size.width - 136,
//                                 child: Text(
//                                   "Đây là văn bản test $i",
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       const _ExpandAbleDescription(),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
// Widget _buildProductDetailWidget(ProductDetailsDataModel detailsDataModel) {
//   return SizedBox(
//     child: SingleChildScrollView(
//       child: Column(
//         children: [
//           // _ProductImage(id: widget.id, img: widget.img),
//           Container(
//             decoration: BoxDecoration(
//               color: DesignCourseAppTheme.nearlyWhite,
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(32.0),
//                   topRight: Radius.circular(32.0)),
//               boxShadow: <BoxShadow>[
//                 BoxShadow(
//                     color: DesignCourseAppTheme.grey.withOpacity(0.2),
//                     offset: const Offset(1.1, 1.1),
//                     blurRadius: 10.0),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(top: 16.0, left: 8, right: 8),
//                   child: Text(
//                     product.name ?? "",
//                     textAlign: TextAlign.left,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 22,
//                       letterSpacing: 0.27,
//                       color: DesignCourseAppTheme.darkerText,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: 8, right: 8, bottom: 8, top: 16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(
//                         'đ${product.price ?? ""}',
//                         textAlign: TextAlign.left,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 22,
//                           letterSpacing: 0.27,
//                           color: Vx.red700,
//                         ),
//                       ),
//                       // SizedBox(
//                       //   child: Row(
//                       //     children: <Widget>[
//                       //       RatingBarIndicator(
//                       //         rating: double.parse(widget.rating),
//                       //         itemBuilder: (context, index) => const Icon(
//                       //           Icons.star,
//                       //           color: Colors.yellow,
//                       //         ),
//                       //         itemCount: 5,
//                       //         itemSize: 20.0,
//                       //         unratedColor: Colors.amber.withAlpha(50),
//                       //         direction: Axis.horizontal,
//                       //       ),
//                       //       Text(
//                       //         widget.rating,
//                       //         textAlign: TextAlign.left,
//                       //         style: const TextStyle(
//                       //           fontWeight: FontWeight.w200,
//                       //           fontSize: 16,
//                       //           letterSpacing: 0.27,
//                       //           color: DesignCourseAppTheme.grey,
//                       //         ),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // )
//                     ],
//                   ),
//                 ),
//                 10.heightBox,
//                 //Size
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     color: DesignCourseAppTheme.nearlyWhite,
//                     borderRadius:
//                         const BorderRadius.all(Radius.circular(8.0)),
//                     boxShadow: <BoxShadow>[
//                       BoxShadow(
//                           color: DesignCourseAppTheme.grey.withOpacity(0.2),
//                           offset: const Offset(1.1, 1.1),
//                           blurRadius: 8.0),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                               child: Row(
//                                 children: [
//                                   "Chọn loại hàng ".text.bold.make(),
//                                   "(1 sản phẩm, 4 hình thức)"
//                                       .text
//                                       .italic
//                                       .make(),
//                                 ],
//                               ),
//                             ),
//                             // 64.widthBox,
//                             const Icon(
//                               Icons.arrow_forward_ios,
//                               size: 16,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             children: [
//                               for (var i = 0;
//                                   i <
//                                       detailsDataModel
//                                           .productDetailsData!.sizes!.length;
//                                   i++)
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 8.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         color: index == i
//                                             ? Vx.green500
//                                             : DesignCourseAppTheme
//                                                 .nearlyWhite,
//                                         borderRadius: const BorderRadius.all(
//                                             Radius.circular(8.0)),
//                                         border:
//                                             Border.all(color: Vx.green500)),
//                                     child: Material(
//                                       color: Colors.transparent,
//                                       child: InkWell(
//                                         splashColor: Colors.white24,
//                                         borderRadius: const BorderRadius.all(
//                                             Radius.circular(8.0)),
//                                         onTap: () {
//                                           index = i;
//                                           setState(() {});
//                                           print(index);
//                                         },
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: 8,
//                                               bottom: 8,
//                                               left: 8,
//                                               right: 8),
//                                           child: Center(
//                                             child: Text(
//                                               detailsDataModel
//                                                   .productDetailsData!
//                                                   .sizes![i],
//                                               textAlign: TextAlign.left,
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: 14,
//                                                 letterSpacing: 0.27,
//                                                 color: index == i
//                                                     ? Vx.white
//                                                     : Vx.green500,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // InkWell(
//                 //   onTap: () {
//                 //     Navigator.of(context).push(
//                 //       HeroDialogRoute(
//                 //           builder: (context) => Column(
//                 //                 children: [
//                 //                   Flexible(child: Container(), flex: 2),
//                 //                   const VoucherPopup(),
//                 //                 ],
//                 //               ),
//                 //           fullscreenDialog: false),
//                 //     );
//                 //   },
//                 //   child: Container(
//                 //     width: MediaQuery.of(context).size.width,
//                 //     decoration: BoxDecoration(
//                 //       color: DesignCourseAppTheme.nearlyWhite,
//                 //       borderRadius:
//                 //           const BorderRadius.all(Radius.circular(8.0)),
//                 //       boxShadow: <BoxShadow>[
//                 //         BoxShadow(
//                 //             color: DesignCourseAppTheme.grey
//                 //                 .withOpacity(0.2),
//                 //             offset: const Offset(1.1, 1.1),
//                 //             blurRadius: 8.0),
//                 //       ],
//                 //     ),
//                 //     child: Padding(
//                 //       padding: const EdgeInsets.only(
//                 //           left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
//                 //       child: Column(
//                 //         crossAxisAlignment: CrossAxisAlignment.start,
//                 //         children: [
//                 //           Row(
//                 //             mainAxisAlignment:
//                 //                 MainAxisAlignment.spaceBetween,
//                 //             children: [
//                 //               SizedBox(
//                 //                 child: "Khuyến mãi sản phẩm".text.make(),
//                 //               ),
//                 //               // 64.widthBox,
//                 //               const Icon(
//                 //                 Icons.arrow_forward_ios,
//                 //                 size: 16,
//                 //               ),
//                 //             ],
//                 //           ),
//                 //           const SizedBox(
//                 //             height: 8,
//                 //           ),
//                 //           Container(
//                 //             width: MediaQuery.of(context).size.width,
//                 //             alignment: Alignment.centerLeft,
//                 //             height: 20,
//                 //             decoration: BoxDecoration(
//                 //               color: Vx.green700.withOpacity(0.4),
//                 //             ),
//                 //             child: "Đang áp dụng hình thức 1"
//                 //                 .text
//                 //                 .gray700
//                 //                 .make(),
//                 //           ),
//                 //         ],
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 10.heightBox,
//                 DefaultTabController(
//                   length: 2,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TabBar(
//                         onTap: (index) {
//                           setState(() {
//                             _selectedTapbar = index;
//                           });
//                         },
//                         physics: const BouncingScrollPhysics(),
//                         isScrollable: true,
//                         labelColor: Vx.green500,
//                         unselectedLabelColor: Vx.gray500,
//                         labelStyle: const TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                         indicator: const UnderlineTabIndicator(
//                           borderSide: BorderSide(
//                             width: 3,
//                             color: Vx.green500,
//                           ),
//                         ),
//                         tabs: const [
//                           Tab(text: "Thông tin sản phẩm"),
//                           Tab(text: "Khuyến mãi"),
//                         ],
//                       ),
//                       Builder(builder: (_) {
//                         if (_selectedTapbar == 0) {
//                           return Container(
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(
//                               color: DesignCourseAppTheme.nearlyWhite,
//                               borderRadius: const BorderRadius.all(
//                                   Radius.circular(8.0)),
//                               boxShadow: <BoxShadow>[
//                                 BoxShadow(
//                                     color: DesignCourseAppTheme.grey
//                                         .withOpacity(0.2),
//                                     offset: const Offset(1.1, 1.1),
//                                     blurRadius: 8.0),
//                               ],
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 8.0,
//                                   right: 8.0,
//                                   top: 12.0,
//                                   bottom: 12.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     child:
//                                         "Thông tin chi tiết".text.bold.make(),
//                                   ),
//                                   const SizedBox(
//                                     height: 8,
//                                   ),
//                                   Divider(
//                                     color: DesignCourseAppTheme.grey
//                                         .withOpacity(0.6),
//                                     height: 1,
//                                   ),
//                                   for (var i = 0; i < 4; i++)
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 8.0),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           SizedBox(
//                                             width: 120,
//                                             child: Text(
//                                               'Tồn kho ${i + 1}',
//                                               style: const TextStyle(
//                                                 color: DesignCourseAppTheme
//                                                     .darkerText,
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width -
//                                                 136,
//                                             child: Text(
//                                               "Đây là văn bản test $i",
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   const _ExpandAbleDescription(),
//                                 ],
//                               ),
//                             ),
//                           ); //1st custom tabBarView
//                         } else if (_selectedTapbar == 1) {
//                           return Container(); //2nd tabView
//                         } else {
//                           return Container(); //3rd tabView
//                         }
//                       }),
//                     ],
//                   ),
//                 ),
//
//                 //Đoạn này dành cho comment
//                 // 10.heightBox,
//                 /*  Container(
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                         color: DesignCourseAppTheme.nearlyWhite,
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(8.0)),
//                         boxShadow: <BoxShadow>[
//                           BoxShadow(
//                               color:
//                                   DesignCourseAppTheme.grey.withOpacity(0.2),
//                               offset: const Offset(1.1, 1.1),
//                               blurRadius: 8.0),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                               children: [
//                                 SizedBox(
//                                   child:
//                                       "Đoạn này là comment".text.bold.make(),
//                                 ),
//                                 Row(
//                                   children: [
//                                     "Xem tất cả".text.green600.make(),
//                                     const Icon(
//                                       Icons.arrow_forward_ios,
//                                       color: Vx.green600,
//                                       size: 16,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 8,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),*/
//                 //Đoạn này dành cho các sản phẩm cùng loại(Bột giặt, nước giặt,...)
//                 // 10.heightBox,
//                 10.heightBox,
//                 //Sản phẩm tương tự (Hương chanh, hương bưởi...)
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     color: DesignCourseAppTheme.nearlyWhite,
//                     borderRadius:
//                         const BorderRadius.all(Radius.circular(8.0)),
//                     boxShadow: <BoxShadow>[
//                       BoxShadow(
//                           color: DesignCourseAppTheme.grey.withOpacity(0.2),
//                           offset: const Offset(1.1, 1.1),
//                           blurRadius: 8.0),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                               child: "Sản phẩm tương tự".text.bold.make(),
//                             ),
//                             Row(
//                               children: [
//                                 "Xem tất cả".text.green600.make(),
//                                 const Icon(
//                                   Icons.arrow_forward_ios,
//                                   color: Vx.green600,
//                                   size: 16,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: List.generate(
//                                 6,
//                                 (index) => Padding(
//                                       padding:
//                                           const EdgeInsets.only(right: 8.0),
//                                       child: Container(
//                                         width: 100,
//                                         height: 140,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           border: Border.all(
//                                               color:
//                                                   Vx.gray700.withOpacity(0.2),
//                                               width: 1),
//                                           borderRadius: const BorderRadius
//                                                   .only(
//                                               topLeft: Radius.circular(16),
//                                               topRight: Radius.circular(8),
//                                               bottomLeft: Radius.circular(8),
//                                               bottomRight:
//                                                   Radius.circular(8)),
//                                           boxShadow: <BoxShadow>[
//                                             BoxShadow(
//                                                 color: DesignCourseAppTheme
//                                                     .grey
//                                                     .withOpacity(0.2),
//                                                 offset:
//                                                     const Offset(1.1, 1.1),
//                                                 blurRadius: 8.0),
//                                           ],
//                                         ),
//                                         child: Column(
//                                           children: [
//                                             // ClipRRect(
//                                             //   borderRadius:
//                                             //       const BorderRadius.only(
//                                             //     topLeft:
//                                             //         Radius.circular(16.0),
//                                             //   ),
//                                             //   child: Image.network(
//                                             //     widget.img,
//                                             //     width: double.infinity,
//                                             //     height: 80,
//                                             //     fit: BoxFit.cover,
//                                             //   ),
//                                             // ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: 4.0,
//                                                   left: 4,
//                                                   right: 8),
//                                               child: Text(
//                                                 productDetails
//                                                         .productDetails![0]
//                                                         .name ??
//                                                     "",
//                                                 overflow:
//                                                     TextOverflow.ellipsis,
//                                                 maxLines: 2,
//                                                 textAlign: TextAlign.left,
//                                                 style: const TextStyle(
//                                                   fontWeight: FontWeight.w400,
//                                                   fontSize: 12,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                             ),
//                                             Flexible(child: Container()),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   bottom: 4.0),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 4),
//                                                     child: Text(
//                                                       "đ ${productDetails.productDetails![0].price ?? ""}",
//                                                       style: const TextStyle(
//                                                         fontSize: 15,
//                                                         letterSpacing: 0.27,
//                                                         color: Vx.red600,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     )).toList(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 /*      Container(
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                         color: DesignCourseAppTheme.nearlyWhite,
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(8.0)),
//                         boxShadow: <BoxShadow>[
//                           BoxShadow(
//                               color:
//                                   DesignCourseAppTheme.grey.withOpacity(0.2),
//                               offset: const Offset(1.1, 1.1),
//                               blurRadius: 8.0),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               child: "Có thể bạn cần".text.bold.make(),
//                             ),
//                             const SizedBox(
//                               height: 8,
//                             ),
//                             AlignedGridView.count(
//                               crossAxisCount: 2,
//                               mainAxisSpacing: 4,
//                               shrinkWrap: true,
//                               physics: const ScrollPhysics(),
//                               crossAxisSpacing: 8,
//                               itemBuilder: (context, index) {
//                                 Map restaurant = restaurants.filter((element) => element['id'] != widget.id).toList()[index];
//                                 return ProductCardItem(
//                                   id: restaurant['id'],
//                                   img: restaurant['img'],
//                                   title: restaurant['title'],
//                                   address: restaurant['address'],
//                                   rating: restaurant['rating'],
//                                 );
//                               },
//                               itemCount: restaurants.length-1,
//
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),*/
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

/*
//Voucher
class VoucherPopup extends StatelessWidget {
  const VoucherPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: DesignCourseAppTheme.nearlyWhite,
      child: Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const _HeaderVoucher(),
              const Divider(),
              const _VoucherList().expand(),
              const Divider(),
              const _FooterVoucher(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderVoucher extends StatelessWidget {
  const _HeaderVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          const SizedBox(
            child: Center(
                child: Text("Khuyến mãi của sản phẩm",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          ),
          4.heightBox,
          const SizedBox(
            child: Text(
              "Các hình thức khuyến mãi của sản phẩm nhằm áp dụng để có thể tiết kiệm được một khoản chi phí.",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterVoucher extends StatelessWidget {
  const _FooterVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: Vx.green500,
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: DesignCourseAppTheme.nearlyBlue.withOpacity(0.5),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: const Center(
            child: Text(
              'Đóng',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: 0.0,
                color: DesignCourseAppTheme.nearlyWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _VoucherList extends StatefulWidget {
  const _VoucherList({Key? key}) : super(key: key);

  @override
  State<_VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<_VoucherList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 100, itemBuilder: (context, index) => Container());
  }
}

class _CheckoutItem extends StatelessWidget {
  const _CheckoutItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(
        Radius.circular(16.0),
      ),
      child: InkWell(
        onTap: () {
          Get.to(
            () => const OrderHistoryItemDetailScreen(),
            curve: Curves.easeInToLinear,
            transition: Transition.rightToLeft,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: "Đơn hàng #12412312".text.xl.bold.make(),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Vx.green200,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Vx.green50.withOpacity(0.5),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: "Đang chờ xác nhận"
                                    .text
                                    .green500
                                    .bold
                                    .make()),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Vx.green700,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
              5.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Đặt vào ngày 20/10/2020".text.gray500.make(),
                  "9,999,999đ"
                      .text
                      .color(Vx.red700.withOpacity(0.8))
                      .bold
                      .xl
                      .make(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (var i = 0; i < 5; i++)
                        SizedBox(
                          width: 100,
                          height: 130,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                "https://picsum.photos/200",
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Vx.gray500,
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
//Đoạn này những cái lược bỏ, có thể sẽ cần

// InkWell(
//   onTap: () {
//     Navigator.of(context).push(
//       HeroDialogRoute(
//           builder: (context) => Column(
//                 children: [
//                   Flexible(child: Container(), flex: 2),
//                   const VoucherPopup(),
//                 ],
//               ),
//           fullscreenDialog: false),
//     );
//   },
//   child: Container(
//     width: MediaQuery.of(context).size.width,
//     decoration: BoxDecoration(
//       color: DesignCourseAppTheme.nearlyWhite,
//       borderRadius:
//           const BorderRadius.all(Radius.circular(8.0)),
//       boxShadow: <BoxShadow>[
//         BoxShadow(
//             color: DesignCourseAppTheme.grey
//                 .withOpacity(0.2),
//             offset: const Offset(1.1, 1.1),
//             blurRadius: 8.0),
//       ],
//     ),
//     child: Padding(
//       padding: const EdgeInsets.only(
//           left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment:
//                 MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 child: "Khuyến mãi sản phẩm".text.make(),
//               ),
//               // 64.widthBox,
//               const Icon(
//                 Icons.arrow_forward_ios,
//                 size: 16,
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             alignment: Alignment.centerLeft,
//             height: 20,
//             decoration: BoxDecoration(
//               color: Vx.green700.withOpacity(0.4),
//             ),
//             child: "Đang áp dụng hình thức 1"
//                 .text
//                 .gray700
//                 .make(),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),
/*
                    //Đoạn này dành cho comment
                    // 10.heightBox,
                    */
/*  Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: DesignCourseAppTheme.nearlyWhite,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color:
                                      DesignCourseAppTheme.grey.withOpacity(0.2),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child:
                                          "Đoạn này là comment".text.bold.make(),
                                    ),
                                    Row(
                                      children: [
                                        "Xem tất cả".text.green600.make(),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Vx.green600,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                        ),*/
/*
                    //Đoạn này dành cho các sản phẩm cùng loại(Bột giặt, nước giặt,...)
                    // 10.heightBox,
                    10.heightBox,
                    //Sản phẩm tương tự (Hương chanh, hương bưởi...)
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //     color: DesignCourseAppTheme.nearlyWhite,
                    //     borderRadius:
                    //         const BorderRadius.all(Radius.circular(8.0)),
                    //     boxShadow: <BoxShadow>[
                    //       BoxShadow(
                    //           color: DesignCourseAppTheme.grey.withOpacity(0.2),
                    //           offset: const Offset(1.1, 1.1),
                    //           blurRadius: 8.0),
                    //     ],
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(
                    //         left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             SizedBox(
                    //               child: "Sản phẩm tương tự".text.bold.make(),
                    //             ),
                    //             Row(
                    //               children: [
                    //                 "Xem tất cả".text.green600.make(),
                    //                 const Icon(
                    //                   Icons.arrow_forward_ios,
                    //                   color: Vx.green600,
                    //                   size: 16,
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //         const SizedBox(
                    //           height: 8,
                    //         ),
                    //         SingleChildScrollView(
                    //           scrollDirection: Axis.horizontal,
                    //           child: Row(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: List.generate(
                    //                 6,
                    //                 (index) => Padding(
                    //                       padding:
                    //                           const EdgeInsets.only(right: 8.0),
                    //                       child: Container(
                    //                         width: 100,
                    //                         height: 140,
                    //                         decoration: BoxDecoration(
                    //                           color: Colors.white,
                    //                           border: Border.all(
                    //                               color:
                    //                                   Vx.gray700.withOpacity(0.2),
                    //                               width: 1),
                    //                           borderRadius: const BorderRadius
                    //                                   .only(
                    //                               topLeft: Radius.circular(16),
                    //                               topRight: Radius.circular(8),
                    //                               bottomLeft: Radius.circular(8),
                    //                               bottomRight:
                    //                                   Radius.circular(8)),
                    //                           boxShadow: <BoxShadow>[
                    //                             BoxShadow(
                    //                                 color: DesignCourseAppTheme
                    //                                     .grey
                    //                                     .withOpacity(0.2),
                    //                                 offset:
                    //                                     const Offset(1.1, 1.1),
                    //                                 blurRadius: 8.0),
                    //                           ],
                    //                         ),
                    //                         child: Column(
                    //                           children: [
                    //                             // ClipRRect(
                    //                             //   borderRadius:
                    //                             //       const BorderRadius.only(
                    //                             //     topLeft:
                    //                             //         Radius.circular(16.0),
                    //                             //   ),
                    //                             //   child: Image.network(
                    //                             //     widget.img,
                    //                             //     width: double.infinity,
                    //                             //     height: 80,
                    //                             //     fit: BoxFit.cover,
                    //                             //   ),
                    //                             // ),
                    //                             Padding(
                    //                               padding: const EdgeInsets.only(
                    //                                   top: 4.0,
                    //                                   left: 4,
                    //                                   right: 8),
                    //                               child: Text(
                    //                                 productDetails
                    //                                         .productDetails![0]
                    //                                         .name ??
                    //                                     "",
                    //                                 overflow:
                    //                                     TextOverflow.ellipsis,
                    //                                 maxLines: 2,
                    //                                 textAlign: TextAlign.left,
                    //                                 style: const TextStyle(
                    //                                   fontWeight: FontWeight.w400,
                    //                                   fontSize: 12,
                    //                                   color: Colors.black,
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                             Flexible(child: Container()),
                    //                             Padding(
                    //                               padding: const EdgeInsets.only(
                    //                                   bottom: 4.0),
                    //                               child: Row(
                    //                                 mainAxisAlignment:
                    //                                     MainAxisAlignment
                    //                                         .spaceBetween,
                    //                                 crossAxisAlignment:
                    //                                     CrossAxisAlignment.center,
                    //                                 children: [
                    //                                   Padding(
                    //                                     padding:
                    //                                         const EdgeInsets.only(
                    //                                             left: 4),
                    //                                     child: Text(
                    //                                       "đ ${productDetails.productDetails![0].price ?? ""}",
                    //                                       style: const TextStyle(
                    //                                         fontSize: 15,
                    //                                         letterSpacing: 0.27,
                    //                                         color: Vx.red600,
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     )).toList(),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    */
/*      Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: DesignCourseAppTheme.nearlyWhite,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color:
                                      DesignCourseAppTheme.grey.withOpacity(0.2),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: "Có thể bạn cần".text.bold.make(),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                AlignedGridView.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 4,
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  crossAxisSpacing: 8,
                                  itemBuilder: (context, index) {
                                    Map restaurant = restaurants.filter((element) => element['id'] != widget.id).toList()[index];
                                    return ProductCardItem(
                                      id: restaurant['id'],
                                      img: restaurant['img'],
                                      title: restaurant['title'],
                                      address: restaurant['address'],
                                      rating: restaurant['rating'],
                                    );
                                  },
                                  itemCount: restaurants.length-1,

                                ),
                              ],
                            ),
                          ),
                        ),*/

//InitState
// animationController = AnimationController(
//     duration: const Duration(milliseconds: 1000), vsync: this);
// animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//     parent: animationController!,
//     curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
// setData();
// Future<void> setData() async {
//   animationController?.forward();
//   await Future<dynamic>.delayed(const Duration(milliseconds: 200));
//   setState(() {
//     opacity1 = 1.0;
//   });
//   await Future<dynamic>.delayed(const Duration(milliseconds: 200));
//   setState(() {
//     opacity2 = 1.0;
//   });
//   await Future<dynamic>.delayed(const Duration(milliseconds: 200));
//   setState(() {
//     opacity3 = 1.0;
//   });
// }
//Rating
// SizedBox(
//   child: Row(
//     children: <Widget>[
//       RatingBarIndicator(
//         rating: double.parse(widget.rating),
//         itemBuilder: (context, index) => const Icon(
//           Icons.star,
//           color: Colors.yellow,
//         ),
//         itemCount: 5,
//         itemSize: 20.0,
//         unratedColor: Colors.amber.withAlpha(50),
//         direction: Axis.horizontal,
//       ),
//       Text(
//         widget.rating,
//         textAlign: TextAlign.left,
//         style: const TextStyle(
//           fontWeight: FontWeight.w200,
//           fontSize: 16,
//           letterSpacing: 0.27,
//           color: DesignCourseAppTheme.grey,
//         ),
//       ),
//     ],
//   ),
// )