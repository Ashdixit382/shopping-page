import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  void _SetPrefItem() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('cart_item', _counter);
    pref.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void ClearSharedData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  void _GetPrefItem() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _counter = pref.getInt('cart_item') ?? 0;
    _totalPrice = pref.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addItem() {
    _counter++;
    _SetPrefItem();
    notifyListeners();
  }

  void removeItem() {
    _counter--;
    _SetPrefItem();
    notifyListeners();
  }

  int getCounter() {
    _GetPrefItem();
    return _counter;
  }

  void addProductPrice(double productprice) {
    _totalPrice = _totalPrice + productprice;
    _SetPrefItem();
    notifyListeners();
  }

  void removeProductPrice(double productprice) {
    _totalPrice = _totalPrice - productprice;
    _SetPrefItem();
    notifyListeners();
  }

  double getproductprice() {
    _GetPrefItem();
    return _totalPrice;
  }
}
