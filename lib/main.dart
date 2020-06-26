import 'package:flutter/material.dart';
import 'package:nandjung_wangi_flutter/models/Data.dart';
import 'package:nandjung_wangi_flutter/services/ApiService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: 'Nandjung Wangi',
      ),
    );
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
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
          // final String label = tab.text.toLowerCase();
          return SafeArea(
            child: FutureBuilder(
              future: apiService.getProfiles(),
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
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: GridView.builder(
            itemCount: profiles.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              Data data = profiles[index];
              return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      focusColor: Colors.orange,
                      onTap: () {
                        print(profiles[index]);
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.network(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: EdgeInsets.all(2),
                              child: Row(
                                children: <Widget>[Text('Test'), Text('Test')],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
            }));
  }
}
