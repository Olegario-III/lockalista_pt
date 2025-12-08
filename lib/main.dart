import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const LockalistaApp());

class LockalistaApp extends StatelessWidget {
  const LockalistaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lockalista',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ---------------- LOGIN PAGE ----------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _username = TextEditingController();
  final _password = TextEditingController();

  void _login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/Lockalista_logo02.jpg",
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Lockalista",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _username,
                      decoration: const InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text("Login", style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- MAIN PAGE ----------------
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = const [HomePage(), StorePage(), ProfilePage()];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.event, color: Colors.teal),
            title: const Text("Add Event"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AddEventPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.store, color: Colors.teal),
            title: const Text("Add Store"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AddStorePage()));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lockalista'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () => _showAddOptions(context),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Stores'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ---------------- HOME PAGE ----------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      {
        'title': 'Binangonan Street Festival',
        'date': 'Nov 15, 2025',
        'image': 'assets/sample_events/photo-1519681393784-d120267933ba.jpg',
        'likes': '245',
        'comments': '32'
      },
      {
        'title': 'Food Bazaar Weekend',
        'date': 'Dec 3, 2025',
        'image': 'assets/sample_events/photo-1498654896293-37aacf113fd9.jpg',
        'likes': '178',
        'comments': '20'
      },
      {
        'title': 'Art in the Park Exhibit',
        'date': 'Dec 20, 2025',
        'image': 'assets/sample_events/photo-1501594907352-04cda38ebc29.jpg',
        'likes': '320',
        'comments': '41'
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        const Text(
          "What's Happening in Binangonan",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        const SizedBox(height: 12),

        for (var e in events)
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  e['image']!,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e['title']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Date: ${e['date']}", style: const TextStyle(color: Colors.black54)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            const Icon(Icons.favorite_border, color: Colors.red),
                            const SizedBox(width: 4),
                            Text(e['likes']!),
                          ]),
                          Row(children: [
                            const Icon(Icons.comment_outlined, color: Colors.teal),
                            const SizedBox(width: 4),
                            Text(e['comments']!),
                          ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: 25),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text("Add Event", style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ],
    );
  }
}

// ---------------- STORE PAGE ----------------
class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final stores = [
      {
        'name': 'Lokal Brew Coffee',
        'rating': '4.8',
        'image': 'assets/sample_stores/photo-1509042239860-f550ce710b93.jpg',
        'map': 'https://www.google.com/maps?q=Binangonan+Coffee+Shop'
      },
      {
        'name': 'Binangonan Handicrafts',
        'rating': '4.5',
        'image': 'assets/sample_stores/photo-1526170375885-4d8ecf77b99f.jpg',
        'map': 'https://www.google.com/maps?q=Binangonan+Handicrafts'
      },
      {
        'name': 'Local Street Diner',
        'rating': '4.7',
        'image': 'assets/sample_stores/photo-1504674900247-0877df9cc836.jpg',
        'map': 'https://www.google.com/maps?q=Binangonan+Diner'
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        const Text("Local Stores", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),

        for (var store in stores)
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  store['image']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(store['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("⭐ ${store['rating']}"),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: () async {
                  final Uri url = Uri.parse(store['map']!);
                  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                    throw Exception("Could not launch ${store['map']}");
                  }
                },
                child: const Text("Map"),
              ),
            ),
          ),

        const SizedBox(height: 20),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text("Add Store"),
        ),
      ],
    );
  }
}

// ---------------- PROFILE PAGE ----------------
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/sample_profile_bg.jpg",
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage("assets/Lockalista_logo02.jpg"),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text("Juan Dela Cruz", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.event_note, color: Colors.teal),
            title: Text("Your Posted Events"),
          ),
          const ListTile(
            leading: Icon(Icons.star_rate, color: Colors.teal),
            title: Text("Your Rated Stores"),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => _logout(context),
                icon: const Icon(Icons.logout),
                label: const Text("Logout", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ---------------- ADD EVENT PAGE ----------------
class AddEventPage extends StatelessWidget {
  const AddEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Event"), backgroundColor: Colors.teal, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            TextField(decoration: InputDecoration(labelText: "Event Title")),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "Description")),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "Date")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: null, child: Text("Submit")),
          ],
        ),
      ),
    );
  }
}

// ---------------- ADD STORE PAGE ----------------
class AddStorePage extends StatelessWidget {
  const AddStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Store"), backgroundColor: Colors.teal, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            TextField(decoration: InputDecoration(labelText: "Store Name")),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "Description")),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "Location")),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "Rating")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: null, child: Text("Submit")),
          ],
        ),
      ),
    );
  }
}
