import 'package:flutter/material.dart';
import 'package:lixshop/contains/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: "Cart".text.black.make(),
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
      body: Column(
        children: [
          const _CartList().expand(),
          const Divider(),
          const _CartTotal(),
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "\$9999".text.color(Vx.red700).bold.xl4.make(),
          30.widthBox,
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.background),
                shape: MaterialStateProperty.all(const StadiumBorder())),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: context.theme.colorScheme.primary,
                content: "Buying not supported yet".text.make(),
              ));
            },
            child: "Buy".text.color(Colors.white).bold.make().py16(),
          ).w32(context)
        ],
      ),
    );
  }
}

class _CartList extends StatefulWidget {
  const _CartList({Key? key}) : super(key: key);

  @override
  State<_CartList> createState() => _CartListState();
}

class _CartListState extends State<_CartList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) => const _CartItem(),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      hoverColor: context.theme.primaryColor.withOpacity(0.1),
      child: ListTile(
        // padding
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        hoverColor: Colors.white,
        focusColor: Colors.white,
        leading: const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage("https://picsum.photos/200"),
        ),
        title: "Product Name".text.make(),
        subtitle: "Product Description".text.make(),
        // trailing: "\$9999".text.make(),
        trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove_circle_outline),
            color: context.theme.colorScheme.primary),
      ),
    );
  }
}
