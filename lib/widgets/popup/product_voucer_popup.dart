import 'package:flutter/material.dart';
import 'package:lixshop/utils/design_course_app_theme.dart';
import 'package:velocity_x/velocity_x.dart';

class TodoPopupCard extends StatelessWidget {
  const TodoPopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "null",
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: DesignCourseAppTheme.nearlyWhite,
        child: Container(
          padding: EdgeInsets.zero,
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const _HeaderVoucher(),
                const _VoucherList().expand(),
              ],
            ),
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

class _VoucherList extends StatefulWidget {
  const _VoucherList({Key? key}) : super(key: key);

  @override
  State<_VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<_VoucherList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: InkWell(
          onTap: () {},
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          hoverColor: context.theme.primaryColor.withOpacity(0.1),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Container(
                padding: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        radius: 50,
                        backgroundImage: const AssetImage("assets/images/lix4.jpg",),
                      ),
                    ),
                    Expanded(
                      child: Text("Khuyến mãi $index"),
                    ),
                    Text("-"),
                    Text("-"),
                    Text("-"),
                  ],
                ),
              )),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
    );
  }
}
