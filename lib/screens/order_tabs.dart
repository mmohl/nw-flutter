import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:nandjung_wangi_flutter/models/Data.dart';
import 'package:nandjung_wangi_flutter/provider/Transaction.dart';
import 'package:nandjung_wangi_flutter/screens/cart.dart';
import 'package:nandjung_wangi_flutter/services/ApiService.dart';
import 'package:nandjung_wangi_flutter/widgets/grid_item.dart';
import 'package:provider/provider.dart';

class OrderTab extends StatefulWidget {
  static String routeName = '/order-tab';
  OrderTab({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OrderTab>
    with SingleTickerProviderStateMixin {
  ApiService apiService;
  TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Paket',
      icon: Icon(Icons.attach_money),
    ),
    Tab(
      text: 'Makanan',
      icon: Icon(Icons.fastfood),
    ),
    Tab(
      text: 'Minuman',
      icon: Icon(Icons.local_drink),
    ),
    Tab(
      text: 'Lain - Lain',
      icon: Icon(Icons.restaurant_menu),
    ),
  ];

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Transaction _transcation = Provider.of<Transaction>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Nandjung Wangi'),
        actions: <Widget>[
          Badge(
            position: BadgePosition.topLeft(left: 1, top: 0.1),
            alignment: Alignment.center,
            // elevation: 1,
            // padding: EdgeInsets.all(5),
            badgeContent: Text(
              _transcation.listOrders.length.toString(),
              style: TextStyle(fontSize: 8, color: Colors.white),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Cart.routeName);
              },
              icon: const Icon(Icons.shopping_cart),
              tooltip: 'Keranjang',
            ),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
          onTap: (int index) {
            print(index);
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          final String category = tab.text.toLowerCase();

          return SafeArea(
            child: FutureBuilder(
              future: apiService.getMenus(category),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                        "Something wrong with message: ${snapshot.error.toString()}"),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<Data> items = snapshot.data;
                  return _buildListView(items);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildListView(List<Data> items) {
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) =>
            GridItem(items[index]));
  }
}
