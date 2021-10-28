import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app_practic/provider/products.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = 'edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusdNode = FocusNode();
  final _descriptionFocusdNode = FocusNode();
  final _imageUrlFocusdNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final fromKey = GlobalKey<FormState>();
  var _exitingProduct =
      Product(id: null, title: '', description: '', price: 0, imageUrl: '');
  var _initialValue = {
    'title': '',
    'description': '',
    'price': 0,
    'imageUrl': '',
  };
  @override
  void dispose() {
    _imageUrlController.removeListener(updateImageUrl);
    _imageUrlController.dispose();
    _priceFocusdNode.dispose();
    _descriptionFocusdNode.dispose();
    _imageUrlFocusdNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imageUrlController.addListener(updateImageUrl);
    super.initState();
  }

  void updateImageUrl() {
    if (!_imageUrlFocusdNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.jpg') &&
              _imageUrlController.text.endsWith('.Jpeg') &&
              _imageUrlController.text.endsWith('.png'))) {
        return;
      }
      setState(() {});
    }
  }

  var init = true;
  @override
  void didChangeDependencies() {
    if (init) {
      final productData = ModalRoute.of(context)!.settings.arguments;
      if (productData != null) {
        _exitingProduct =
            Provider.of<Products>(context).findById(productData.toString());
        _initialValue = {
          'title': _exitingProduct.title,
          'description': _exitingProduct.description,
          'price': _exitingProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _exitingProduct.imageUrl;
      }
    }
    init = false;
    super.didChangeDependencies();
  }

  void _saveFrom() {
    final isValid = fromKey.currentState!.validate();
    if (!isValid) {
      print(isValid);
      return;
    }
    fromKey.currentState!.save();
    if (_exitingProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_exitingProduct.id!, _exitingProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_exitingProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _saveFrom();
              },
              icon: Icon(Icons.save)),
        ],
        title: Text('Add Product'),
      ),
      body: Form(
          key: fromKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _initialValue['title'].toString(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a Title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _exitingProduct = Product(
                      isFavorite: _exitingProduct.isFavorite,
                      title: value!,
                      id: _exitingProduct.id,
                      description: _exitingProduct.description,
                      imageUrl: _exitingProduct.imageUrl,
                      price: _exitingProduct.price,
                    );
                  },
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusdNode);
                  },
                ),
                TextFormField(
                  initialValue: _initialValue['price'].toString(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a Price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please Enter a valid number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please Enter a price greater than 0';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _exitingProduct = Product(
                      isFavorite: _exitingProduct.isFavorite,
                      title: _exitingProduct.title,
                      id: _exitingProduct.id,
                      description: _exitingProduct.description,
                      imageUrl: _exitingProduct.imageUrl,
                      price: double.parse(value!),
                    );
                  },
                  focusNode: _priceFocusdNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusdNode);
                  },
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  initialValue: _initialValue['description'].toString(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a Description';
                    }
                    if (value.length <= 10) {
                      return 'Description must 10 Character Long';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _exitingProduct = Product(
                      isFavorite: _exitingProduct.isFavorite,
                      title: _exitingProduct.title,
                      id: _exitingProduct.id,
                      description: value!,
                      imageUrl: _exitingProduct.imageUrl,
                      price: _exitingProduct.price,
                    );
                  },
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  focusNode: _descriptionFocusdNode,
                  keyboardType: TextInputType.multiline,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_imageUrlFocusdNode);
                  },
                ),
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10, right: 10),
                        child: _imageUrlController.text.isEmpty
                            ? Text('Please Enter a Image URL')
                            : FittedBox(
                                child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              )),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                        )),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter a Image Url';
                          }
                          if (value.startsWith('http') == false &&
                              value.startsWith('https') == false) {
                            return 'Please Enter a valid URL';
                          }
                          if (value.endsWith('.jpg') == false &&
                              value.endsWith('.jpeg') == false &&
                              value.endsWith('.png') == false) {
                            return 'Please Enter a valid URL';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _exitingProduct = Product(
                            isFavorite: _exitingProduct.isFavorite,
                            title: _exitingProduct.title,
                            id: _exitingProduct.id,
                            description: _exitingProduct.description,
                            imageUrl: value!,
                            price: _exitingProduct.price,
                          );
                        },
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusdNode,
                        decoration: InputDecoration(labelText: 'ImageUrl'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {
                          _saveFrom();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}