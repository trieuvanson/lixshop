import 'package:flutter/material.dart';
import 'package:lixshop/repositories/slide/slide_repository.dart';
import 'package:readmore/readmore.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/design_course_app_theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    getSlides();
    super.initState();
  }

  getSlides() {
    slideRepository.getSlides();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ContactsPage(),
    );


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: "Thông báo".text.black.make(),
      ),
      body: const Center(
        child: Text(
          'Chức năng đang được phát triển',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final String title;
  final String content;
  final String time;
  final String image;
  final GestureTapCallback? onTap;

  const _NotificationItem(
      {Key? key,
      required this.title,
      required this.content,
      required this.time,
      required this.image,
      this.onTap})
      : super(key: key);
  static const content1 = "Công ti xin thông báo chương trình khuyến mãi "
      "Công ti xin thông báo chương trình khuyến mãi "
      "Công ti xin thông báo chương trình khuyến mãi "
      "Công ti xin thông báo chương trình khuyến mãi "
      "Công ti xin thông báo chương trình khuyến mãi "
      "Công ti xin thông báo chương trình khuyến mãi "
      "Công ti xin thông báo chương trình khuyến mãi "
      "Công ti xin thông báo chương trình khuyến mãi "
      "Công ti xin thông báo chương trình khuyến mãi123";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title.text.bold.xl.make(),
                time.text.gray500.make(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ReadMoreText(
                content1,
                trimLines: 2,
                textAlign: TextAlign.justify,
                trimMode: TrimMode.Line,
                trimCollapsedText: "Xem thêm",
                trimExpandedText: "Ẩn bớt",
                lessStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
                moreStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Contact {
  final String name;

  Contact(this.name);
}

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  final contacts = [
    Contact("sahar"),
    Contact("Joe"),
    Contact("fo"),
    Contact("Fifo"),
    Contact("Moshe"),
  ];

  var _displayAll = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("contacts"),),
      backgroundColor: Colors.white,
      body: Center(
        child:_gridContacts(),
      ),
    );
  }

  Widget _gridContacts() {
    final size = _displayAll ? contacts.length : contacts.length - 2;
    final contactsWidget = List.generate(
        size, (index) => _contactItem(contacts[index]))
      ..add(_seeNoSeeMore());
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 2/1,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: contactsWidget,);
  }


  Widget _contactItem(Contact item) {
    return Container(
      color: Colors.blue.withOpacity(0.5),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.person),
          Text(item.name),
        ],
      ),
    );
  }

  Widget _seeNoSeeMore() {
    return InkWell(
      onTap: ()=>setState(()=>_displayAll = !_displayAll),
      child: Container(
        color: Colors.blue.withOpacity(0.5),
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person),
            Text(_displayAll?"hide":"Show all"),
          ],
        ),
      ),
    );
  }
}