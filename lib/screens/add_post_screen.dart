import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';


class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  // bool _stop = false;
  // final dio = Dio();
  // final list = [];
  //
  // void ddos() async {
  //   int i = 0;
  //   while (!_stop) {
  //     try {
  //       final response = await dio
  //           .get('http://192.168.0.226:65/shopee/datas/KxQcAQ9cWEJYLw==');
  //       print("done: $i");
  //     } catch (e) {
  //       print(e);
  //     }
  //     i++;
  //   }
  // }
  //
  // String htmlData =
  //     "<h2><strong><img src=\"data:image/jpeg;base64,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\"></strong></h2><p><strong>Nước rửa chén siêu sạch</strong></p><p>Sản phẩm mới ra</p><p>Sản phẩm mới ra</p><p>Sản phẩm mới ra</p>";
  //
  // final _appRepository = AppRepository();
  //
  // @override
  // void initState() {
  //   BlocProvider.of<ResultDetailsDataCubit>(context).getProductOutside(462);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: "Hộp thư".text.black.make(),
      ),
      body: Container(),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       FutureBuilder(
      //           future: orderRepository.getOrdersByUser(),
      //           builder: (context, AsyncSnapshot<List<Order>?> snapshot) {
      //             return snapshot.hasData
      //                 ? Text(snapshot.data.toString())
      //                 : const Text('load');
      //           }),
      //       // BlocBuilder<ResultDetailsDataCubit, ResultDetailsDataState>(
      //       //   builder: (context, state) {
      //       //     if (state.isLoading) {
      //       //       return const CircularProgressIndicator();
      //       //     } else if (state.isError) {
      //       //       return const Text("Error");
      //       //     } else if (state.isSuccess) {}
      //       //     return const Text("");
      //       //   },
      //       // ),
      //       IconButton(
      //         icon: const Icon(
      //           Icons.upload,
      //         ),
      //         onPressed: () async {},
      //       ),
      //       IconButton(
      //         icon: const Icon(
      //           Icons.stop,
      //         ),
      //         onPressed: () {
      //           setState(() {
      //             _stop = !_stop;
      //             print(_stop);
      //           });
      //         },
      //       ),
      //       Html(
      //         data: htmlData,
      //         customImageRenders: {
      //           networkSourceMatcher(domains: ["data:image/"]):
      //               (context, attributes, element) {
      //             return const FlutterLogo(size: 100);
      //           },
      //           networkSourceMatcher(domains: ["data:image/"]):
      //               networkImageRender(
      //             headers: {"Custom-Header": "some-value"},
      //             altWidget: (alt) => Text(alt ?? ""),
      //             loadingWidget: () => const Text("Loading..."),
      //           ),
      //           // On relative paths starting with /wiki, prefix with a base url
      //           (attr, _) =>
      //                   attr["src"] != null && attr["src"]!.startsWith("/wiki"):
      //               networkImageRender(
      //                   mapUrl: (url) => "https://upload.wikimedia.org" + url!),
      //           // Custom placeholder image for broken links
      //           networkSourceMatcher():
      //               networkImageRender(altWidget: (_) => const FlutterLogo()),
      //         },
      //         onLinkTap: (url, _, __, ___) {
      //           print("Opening $url...");
      //         },
      //         onImageTap: (src, _, __, ___) {
      //           print(src);
      //         },
      //         onImageError: (exception, stackTrace) {
      //           print(exception);
      //         },
      //         onCssParseError: (css, messages) {
      //           print("css that errored: $css");
      //           print("error messages:");
      //           messages.forEach((element) {
      //             print(element);
      //           });
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
