import 'package:flutter/material.dart';
import 'package:online_swissy/components/customer_drawer.dart';
import 'package:online_swissy/utils/api_serivce.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'cart_provider.dart';
import 'cart_screen.dart';
import 'CategoryTab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  fetchCategories() async {
    setState(() => isLoading = true);
    var data = await ApiService.fetchMenu();
    setState(() {
      categories = data;
      isLoading = false;
    });
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, "/auth");
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Foody"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
              ),
              if (cart.totalItems > 0)
                Positioned(
                  right: 5,
                  top: 5,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.green,
                    child: Text(
                      cart.totalItems.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(icon: Icon(Icons.logout), onPressed: logout),
        ],
      ),
      drawer: CustomDrawer(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: categories.length,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.green,
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.black,
                    tabs: categories
                        .map((category) => Tab(text: category['name']))
                        .toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: categories
                          .map((category) => CategoryTab(category: category))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
