import 'package:e_commerce/src/view/screen/product_detail_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/src/controller/product_controller.dart';
import 'package:e_commerce/src/view/widget/product_grid_view.dart';
import 'package:e_commerce/src/view/widget/empty_fav.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getFavoriteItems();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GetBuilder<ProductController>(
          builder: (ProductController controller) {
            if (controller.filteredProducts.isEmpty) {
              return const EmptyFav();
            }

            return ProductGridView(
              items: controller.filteredProducts,
              likeButtonPressed: (index) => controller.isFavorite(index),
              isPriceOff: (product) => controller.isPriceOff(product),
            );
          },
        ),
      ),
    );
  }
}
