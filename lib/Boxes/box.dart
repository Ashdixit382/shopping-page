import 'package:hive/hive.dart';
import 'package:provider_learning/models/cart_model.dart';

class Boxes {
  static Box<Cart> getbox() {
    return Hive.box<Cart>('addproduct');
  }
}
