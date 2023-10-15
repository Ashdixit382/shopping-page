import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:provider_learning/Boxes/box.dart';
import 'package:provider_learning/models/cart_model.dart';
import 'package:provider_learning/models/cart_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    void deleteItem(Cart cart) {
      cart.delete();
    }

    void UpdateItem(Cart cart, int quantity) {
      final updat = cart.tomap();
      updat['quantity'] = quantity.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: () {
              cart.ClearSharedData();
            },
            child: Text('Cart Page')),
        centerTitle: true,
        actions: [
          Center(
            child: badges.Badge(
              badgeContent:
                  Consumer<CartProvider>(builder: (context, value, child) {
                return Text(value.getCounter().toString());
              }),
              badgeAnimation: const badges.BadgeAnimation.rotation(
                animationDuration: Duration(seconds: 1),
              ),
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.orange,
              ),
              child: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          ValueListenableBuilder<Box<Cart>>(
            valueListenable: Boxes.getbox().listenable(),
            builder: (context, box, _) {
              final data = box.values.toList().cast<Cart>();
              return Expanded(
                child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: ((context, index) {
                    return Expanded(
                      child: Container(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Image(
                                      height: 100,
                                      width: 100,
                                      image: NetworkImage(
                                        data[index].image.toString(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data[index]
                                                    .productName
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  deleteItem(data[index]);
                                                  cart.removeItem();
                                                  if (cart
                                                          .getproductprice()
                                                          .toStringAsFixed(2) !=
                                                      "0.00") {
                                                    cart.removeProductPrice(
                                                        double.parse(data[index]
                                                            .productPrice
                                                            .toString()));
                                                  }
                                                },
                                                icon: const Icon(Icons.delete),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            data[index].uintTag.toString() +
                                                " " +
                                                r"$" +
                                                data[index]
                                                    .productPrice
                                                    .toString(),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: 35,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        int quantity = int
                                                            .parse(data[index]
                                                                .quantity
                                                                .toString());
                                                        quantity++;
                                                        cart.removeProductPrice(
                                                            double.parse(data[
                                                                    index]
                                                                .productPrice
                                                                .toString()));
                                                        UpdateItem(data[index],
                                                            quantity);
                                                      },
                                                      child: const Icon(
                                                          Icons.remove,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      data[index]
                                                          .quantity
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: const Icon(
                                                          Icons.add,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          ),
          Consumer<CartProvider>(
            builder: ((context, value, child) {
              return Visibility(
                visible: value.getproductprice().toStringAsFixed(2) == "0.00"
                    ? false
                    : true,
                child: Column(
                  children: [
                    ReuseableWidget(
                      title: "Sub Total",
                      value: r"$" + value.getproductprice().toStringAsFixed(2),
                    )
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class ReuseableWidget extends StatelessWidget {
  final String title, value;
  const ReuseableWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.subtitle1,
          )
        ],
      ),
    );
  }
}
