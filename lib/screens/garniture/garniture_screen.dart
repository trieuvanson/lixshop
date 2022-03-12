import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/design_course_app_theme.dart';
import '../../utils/hero_dialog_route.dart';

class GarnitureScreen extends StatelessWidget {
  const GarnitureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: "Gian hàng trưng bày".text.size(18).black.make(),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for(var i = 0; i<10; i++)
              const _CheckoutItem(
                // icon: Icons.shopping_basket,
                // title: 'Gian hàng trưng bày',
                // subtitle: 'Gian hàng trưng bày',
                // imagePath: 'assets/images/garniture.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckoutItem extends StatelessWidget {
  const _CheckoutItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: DesignCourseAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: DesignCourseAppTheme.grey.withOpacity(0.2),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 8.0),
            ],
          ),
          child: Material(
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      height: 170,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 130,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                "https://picsum.photos/200",
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          16.widthBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  width: MediaQuery.of(context).size.width - 180,
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: const TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        text:
                                            'Tone trưng bày Iron & Stone213 12312 123123 12312312 123123  12312123123'),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  //Icon calendar
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.black,
                                    size: 14,
                                  ),
                                  5.widthBox,
                                  //Text date
                                  "12/12/2021 - 31/12/2012".text.sm.gray500.make(),
                                ],
                              ),
                              5.heightBox,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Mức thưởng tối đa".text.gray500.make(),
                                  "200,000đ".text.red700.bold.make(),
                                ],
                              ),

                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  width: MediaQuery.of(context).size.width - 180,
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: const TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                        text:
                                            'Công ty xin thông báo chương trình trưng bày sản phẩm dầu gội sữa tắm Iron & Stone tại'
                                            ' các cửa hàng chính yếu với thời gian dự kiến..., điều kiện tham gia chương trình, hình ảnh '
                                            ' và kích thước trưng bày sản phẩm sẽ được công ty xác nhận trước khi tham gia chương trình.'),
                                  ),
                                ),
                              ),
                              //Text date
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
                                        child:
                                        "Đang đăng ký".text.green500.bold.make()),
                                  ),
                                ),
                              ),

                              // SizedBox(
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       SizedBox(
                              //         child: "Thùng 13 bịch x 12 gói x 25g"
                              //             .text
                              //             .gray500
                              //             .make(),
                              //       ),
                              //       SizedBox(
                              //         child: "Chi tiết".text.green500.xl.make(),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // 5.heightBox,
                              // SizedBox(
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       "100,000đ/Thùng".text.xl.gray500.make(),
                              //       "100,000đ"
                              //           .text
                              //           .color(Vx.black.withOpacity(0.8))
                              //           .bold
                              //           .xl2
                              //           .make(),
                              //     ],
                              //   ),
                              // ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
