import 'package:e_commerce/src/model/categorical.dart';
import 'package:e_commerce/src/model/numerical.dart';

class ProductSizeType {
  List<Numerical>? numerical;
  List<Categorical>? categorical;

  ProductSizeType({this.numerical, this.categorical});
}
