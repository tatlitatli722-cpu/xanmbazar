import 'package:flutter/material.dart';

void main() {
  runApp(XanmBazarApp());
}

class XanmBazarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xanm Bazar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: MainNavigation(),
    );
  }
}

// سیستەمی گۆڕینی شاشەکان (کڕیار و بەڕێوەبەر)
class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  
  // لێرەدا هەموو بەشەکانی ئەپەکە پێکەوە بەستراونەتەوە
  final List<Widget> _screens = [
    CustomerHomeScreen(), // شاشەی کڕیاران
    AdminPanelScreen(),   // پانێڵی بەڕێوەبردن (بۆ خۆت)
    AdminOrdersScreen(),  // شاشەی بینینی ئەدرەس و داواکارییەکان
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'خانم بازار'),
          BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: 'داخڵکردنی کاڵا'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'داواکارییەکان'),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// ١. شاشەی کڕیاران (CUSTOMER HOME SCREEN)
// -------------------------------------------------------------
class CustomerHomeScreen extends StatefulWidget {
  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final List<String> categories = ['جلوبەرگ', 'بۆن', 'مۆبایل', 'ئێکسسوارات', 'Beauty', 'کاتژمێر'];
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xanm Bazar - خانم بازار', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('بەشەکان', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.pink[50],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Center(child: Text(categories[index], style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold))),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 25),
              Text('نوێترین کاڵاکان', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              
              // کارتێکی نموونەیی بۆ کڕیار
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=600',
                        height: 280,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('کراسی خانمانەی شاهانە', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text('35,000 دینار', style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
                          SizedBox(height: 15),
                          Text(':قەبارە بەردەستەکان (خۆت ڕێکت خستووە)', style: TextStyle(color: Colors.grey[700])),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: ['S', 'M', 'L', 'XL'].map((size) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: ChoiceChip(
                                  label: Text(size),
                                  selected: selectedSize == size,
                                  selectedColor: Colors.pink,
                                  textColor: selectedSize == size ? Colors.white : Colors.black,
                                  onSelected: (selected) {
                                    setState(() {
                                      selectedSize = selected ? size : null;
                                    });
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen()));
                              },
                              icon: Icon(Icons.shopping_cart, color: Colors.white),
                              label: Text('داواکردن و پارەدان', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, padding: EdgeInsets.vertical(12)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// ٢. شاشەی داخڵکردنی کاڵا لەلایەن خۆتەوە (ADMIN PANEL SCREEN)
// -------------------------------------------------------------
class AdminPanelScreen extends StatefulWidget {
  @override
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _sizeController = TextEditingController();
  String selectedCategory = 'جلوبەرگ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('کۆنترۆڵ و دانانی کاڵا', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('لێرەوە وێنەی ڕاستەقینە، نرخ، و سایزەکان دابنێ', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // کۆدی کردنەوەی ستۆدیۆی مۆبایلەکەت
                },
                icon: Icon(Icons.add_a_photo),
                label: Text('زیادکردنی وێنە لە گەلەری مۆبایلەکەتەوە'),
                style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _nameController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(labelText: 'ناوی کاڵا', border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _priceController,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'نرخی کاڵا', border: OutlineInputBorder()),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _sizeController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'قەبارەکان (بەم شێوەیە جیا بکەرەوە: S,M,L)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('کاڵاکە بە سەرکەوتوویی بڵاوکرایەوە')));
                  },
                  child: Text('بڵاوکردنەوەی کاڵا', style: TextStyle(color: Colors.white, fontSize: 16)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.vertical(14)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// ٣. شاشەی فۆرمی ئەدرەس و پارەدانی فاستپەی بۆ کڕیار (CHECKOUT SCREEN)
// -------------------------------------------------------------
class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('زانیاری و پارەدان'), backgroundColor: Colors.pink),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('تکایە ناونیشانی خۆت داخل بکە', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              TextField(textAlign: TextAlign.right, decoration: InputDecoration(labelText: 'ناوی سیانی', border: OutlineInputBorder())),
              SizedBox(height: 12),
              TextField(textAlign: TextAlign.right, keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: 'ژمارەی مۆبایل', border: OutlineInputBorder())),
              SizedBox(height: 12),
              TextField(textAlign: TextAlign.right, decoration: InputDecoration(labelText: 'ناونیشان (شار / گەڕەک)', border: OutlineInputBorder())),
              SizedBox(height: 25),
              
              Text('ڕێگای پارەدان', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(12),
                color: Colors.purple[50],
                width: double.infinity,
                child: Column(
                  children: [
                    Text('FastPay یان FIB حیسابی پۆستەری', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
                    SizedBox(height: 5),
                    Text('ژمارەی حیساب: 0750XXXXXXX', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.upload_file),
                label: Text('ئەپڵۆدکردنی وێنەی پسوولەی پارەدان (Screenshot)'),
                style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 45)),
              ),
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('داواکارییەکەت نێردرا بۆ خانم بازار')));
                  },
                  child: Text('کۆتاییهێنان بە داواکاری', style: TextStyle(color: Colors.white, fontSize: 16)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, padding: EdgeInsets.vertical(14)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// ٤. شاشەی بینینی داواکارییەکان بۆ خۆت (ADMIN ORDERS SCREEN)
// -------------------------------------------------------------
class AdminOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('لیستی داواکاری خەڵک'), backgroundColor: Colors.black87),
      body: ListView.builder(
        itemCount: 1, // بۆ نموونە یەک داواکاری هاتووە
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(12),
            child: ListTile(
              trailing: Icon(Icons.pending_actions, color: Colors.orange),
              title: Text('کڕیار: ژوان ئەحمەد', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('ناونیشان: هەولێر - بەختیاری', textAlign: TextAlign.right),
                  Text('مۆبایل: 07501234567', textAlign: TextAlign.right),
                  Text('کاڵا: کراسی خانمانە - سایز: M', textAlign: TextAlign.right, style: TextStyle(color: Colors.pink)),
                  Text('پارەدان: FastPay (پسوولە هاوپێچە)', textAlign: TextAlign.right, style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
