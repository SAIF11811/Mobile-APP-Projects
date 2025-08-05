import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:e_commerce/src/model/product.dart';
import 'package:e_commerce/src/view/widget/empty_cart.dart';
import 'package:e_commerce/src/controller/product_controller.dart';
import 'package:e_commerce/src/view/animation/animated_switcher_wrapper.dart';

import 'order_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ProductController controller = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    controller.getCartItems();
    controller.calculateTotalPrice();
  }

  Widget cartList() {
    return SingleChildScrollView(
      child: Column(
        children: controller.cartProducts.mapWithIndex((index, _) {
          Product product = controller.cartProducts[index];
          return Dismissible(
            key: ValueKey(product.name),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              controller.removeFromCart(product);
              controller.calculateTotalPrice();
            },
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.delete, color: Colors.white, size: 30),
            ),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200]?.withAlpha(150),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            product.images[0],
                            width: 100,
                            height: 90,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name.nextLine,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          controller.getCurrentSize(product),
                          style: TextStyle(
                            color: Colors.black.withAlpha(120),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          controller.isPriceOff(product)
                              ? "\$${product.off}"
                              : "\$${product.price}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 23,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          splashRadius: 10.0,
                          onPressed: () =>
                              controller.decreaseItemQuantity(product),
                          icon: const Icon(
                            Icons.remove,
                            color: Color(0xFFEC6813),
                          ),
                        ),
                        GetBuilder<ProductController>(
                          builder: (_) {
                            return AnimatedSwitcherWrapper(
                              child: Text(
                                '${product.quantity}',
                                key: ValueKey<int>(product.quantity),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          splashRadius: 10.0,
                          onPressed: () =>
                              controller.increaseItemQuantity(product),
                          icon: const Icon(
                            Icons.add,
                            color: Color(0xFFEC6813),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget bottomBarTitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Total",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
          Obx(
                () {
              return AnimatedSwitcherWrapper(
                child: Text(
                  "\$${controller.totalPrice.value}",
                  key: ValueKey<int>(controller.totalPrice.value),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFEC6813),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget bottomBarButton(List<Product> cartProducts) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
          onPressed: cartProducts.isEmpty
              ? null
              : () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OrderScreen(
                  products: cartProducts,
                  total: controller.totalPrice.value,
                ),
              ),
            );
          },
          child: const Text("Buy Now"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: !controller.isEmptyCart
                    ? cartList()
                    : const EmptyCart(),
              ),
              bottomBarTitle(),
              bottomBarButton(controller.cartProducts),
            ],
          ),
        ),
      ),
    );
  }
}
