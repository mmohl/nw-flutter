import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:nandjung_wangi_flutter/screens/cart.dart';
import 'package:nandjung_wangi_flutter/models/Data.dart';
import 'package:nandjung_wangi_flutter/screens/item_detail.dart';
import 'package:nandjung_wangi_flutter/services/ApiService.dart';
import 'package:nandjung_wangi_flutter/widgets/grid_item.dart';
import 'package:provider/provider.dart';
import 'package:nandjung_wangi_flutter/provider/Transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Transaction(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Nandjung Wangi',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(title: 'Nandjung Wangi'),
          routes: {
            Cart.routeName: (context) => Cart(),
            ItemDetail.routeName: (context) => ItemDetail()
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  ApiService apiService;
  TabController _tabController;
  TextEditingController _dialogInputController;
  Transaction _Transaction;

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
    _dialogInputController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _Transaction = Provider.of<Transaction>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Cart.routeName);
            },
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Keranjang',
          ),
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
                  List<Data> profiles = snapshot.data;
                  return _buildListView(profiles);
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

  Widget _buildListView(List<Data> profiles) {
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: profiles.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) =>
            GridItem(profiles[index]));
  }

  void showCustomDialogWithImage(BuildContext context, Data data) {
    Dialog dialogWithImage = Dialog(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeJdFAv-yuL608hmTmtZ6o9eUjTwzCA-u9ZQOnzqvONNxMhACX&s",
            // "http://10.0.2.2:8080/images/${data.img}",
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: _dialogInputController,
                decoration:
                    InputDecoration(labelText: "Masukan jumlah pesanan"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
              )),
          SizedBox(
            height: 100,
          ),
          Row(
            children: [
              Expanded(
                  child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: Colors.blue,
                onPressed: () {
                  _Transaction.addOrder(
                      item: data,
                      totalOrder: int.parse(_dialogInputController.text));
                  Navigator.of(context).pop();
                  _dialogInputController.clear();
                  // print(_Transaction.listOrders);
                },
                child: Text(
                  'Tambah',
                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                ),
              )),
              Expanded(
                child: InkWell(
                    child: RaisedButton(
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Tutup',
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                )),
              ),
            ],
          )
        ],
      ),
    ));

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => dialogWithImage);
  }
}
