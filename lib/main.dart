import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Represenst a Cart Item. Has <int>`id`, <String>`name`, <int>`quantity`
class CartItem {
  int cartItemID;
  String cartItemName;
  int cartItemQuantity;
  
  CartItem(int cartItemID, String cartItemName, int cartItemQuantity)
  {
      this.cartItemID = cartItemID;
      this.cartItemNamem = cartItemName;
      this.cartItemQuantity = cartItemQuantity;
  }
  
  int getCartID()
  {
    return this.cartItemID;
  }
  String getCartName()
  {
    return this.cartItemName;
  }
  int getCartQuantity()
  {
    return this.cartItemQuantity;
  }
  
  void setQuantity(int quantity)
  {
    this.cartItemQuantity = quantity;
  }
    
  void setCardID(int itemID)
  {
    this.cartItemID = itemID;
  }
  
  void setCartName(String newItemName)
  {
    this.cartItemName = newItemName;
  }
}

/// Manages a cart. Implements ChangeNotifier
class CartState with ChangeNotifier {
  List<CartItem> _products = [];

  CartState();

  /// The number of individual items in the cart. That is, all cart items' quantities.
  int get totalCartItems => 0; // TODO: return actual cart volume.

  /// The list of CartItems in the cart
  List<CartItem> get products => _products;

  /// Clears the cart. Notifies any consumers.
  void clearCart() {
    _products.clear();
    Notification("Cart has been cleared");
  }

  /// Adds a new CartItem to the cart. Notifies any consumers.
  void addToCart({required CartItem item}) {
    _products.add(item);
    Notification("Item added into cart");
  }

  /// Updates the quantity of the Cart item with this id. Notifies any consumers.
  void updateQuantity({required int id, required int newQty}) {
    for(int i =0; i<= _products.length; i++)
    {
      if(_products[i].getCartID() == id)
      {
        _products[i].setQuantity(newQty);
      }
    }
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartState(),
      child: MyCartApp(),
    ),
  );
}

class MyCartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              ListOfCartItems(),
              CartSummary(),
              CartControls(),
            ],
          ),
        ),
      ),
    );
  }
}

class CartControls extends StatelessWidget {
  /// Handler for Add Item pressed
  void _addItemPressed(BuildContext context) {
    /// mostly unique cartItemId.
    /// don't change this; not important for this test
    int nextCartItemId = Random().nextInt(10000);
    String nextCartItemName = 'A cart item';
    int nextCartItemQuantity = 1;

    CartItem item = new CartItem(nextCartItemID, nextCartItemName,nextCartItemQuantity) ; // Actually use the CartItem constructor to assign id, name and quantity
    
    // TODO: Get the cart current state through Provider. Add this cart item to cart.
      @override
    return Consumer<CartState>(
      builder: (BuildContext context, CartState cart, Widget? child) {
        return Text("Total items: ${cart.totalCartItems}");
        cart.addToCart(item);
      },
    );
  }

  /// Handle clear cart pressed. Should clear the cart
  void _clearCartPressed(BuildContext context) {
    
  }

  @override
  Widget build(BuildContext context) {
    final Widget addCartItemWidget = TextButton(
      child: Text('Add Item'),
      onPressed: () {
        _addItemPressed(context);
      },
    );

    final Widget clearCartWidget = TextButton(
      child: Text('Clear Cart'),
      onPressed: () {
        _clearCartPressed(context);
      },
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        addCartItemWidget,
        clearCartWidget,
      ],
    );
  }
}

class ListOfCartItems extends StatelessWidget {
  /// Handles adding 1 to the current cart item quantity.
  void _incrementQuantity(context, int id, int delta) {}

  /// Handles removing 1 to the current cart item quantity.
  /// Don't forget: we can't have negative numbers of an item in the cart
  void _decrementQuantity(context, int id, int delta) {}

  @override
  Widget build(BuildContext context) {
    return Consumer<CartState>(
        builder: (BuildContext context, CartState cart, Widget? child) {
      if (cart.totalCartItems == 0) {
        // TODO: return a Widget that tells us there are no items in the cart
      }

      return Column(children: [
        ...cart.products.map(
          (c) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // TODO: Widget for the line item name AND current quantity, eg "Item name x 4".
                //  Current quantity should update whenever a change occurs.
                // TODO: Button to handle incrementing cart quantity. Handler is above.
                // TODO: Button to handle decrementing cart quantity. Handler is above.
              ],
            ),
          ),
        ),
      ]);
    });
  }
}

class CartSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartState>(
      builder: (BuildContext context, CartState cart, Widget? child) {
        return Text("Total items: ${cart.totalCartItems}");
      },
    );
  }
}
