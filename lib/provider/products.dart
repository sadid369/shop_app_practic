import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String imageUrl;
  final String description;
  final double price;
  bool isFavorite;
  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.price,
    this.isFavorite = false,
  });
  void toggleIsFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get item {
    return [..._items];
  }

  List<Product> get toggleIsFavorite {
    return _items.where((item) => item.isFavorite).toList();
  }

  void updateProduct(String id, Product newProduct) {
    final productIndex = _items.indexWhere((product) => product.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = newProduct;
      notifyListeners();
    } else {
      print('.....');
    }
  }

  Future<void> fetchAndSetData() async {
    final url =
        'https://shop-app-practic-default-rtdb.asia-southeast1.firebasedatabase.app/products.json';
    http.get(Uri.parse(url)).then((response) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedData = [];
      extractedData.forEach((productID, prodyctData) {
        loadedData.add(Product(
            id: productID,
            title: prodyctData['title'],
            imageUrl: prodyctData['imageUrl'],
            description: prodyctData['description'],
            price: prodyctData['price']));
      });
      _items = loadedData;
      notifyListeners();
      print(json.decode(response.body));
    }).catchError((error) {
      print(error);
      throw error;
    });
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://shop-app-practic-default-rtdb.asia-southeast1.firebasedatabase.app/products.json';
    await http
        .post(Uri.parse(url),
            body: json.encode({
              'title': product.title,
              'price': product.price,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'isFavorite': product.isFavorite
            }))
        .catchError((error) {
      print(error);
      throw error;
    }).then((response) {
      print(json.decode(response.body)['name']);
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          imageUrl: product.imageUrl,
          description: product.description,
          price: product.price);
      _items.add(newProduct);
      notifyListeners();
    });
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void deleteItem(String id) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
