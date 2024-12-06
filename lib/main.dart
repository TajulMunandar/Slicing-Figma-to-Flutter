import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TransactionScreen(),
      theme: ThemeData(
        textTheme: GoogleFonts.lexendTextTheme(),
      ),
    );
  }
}

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Layanan Transaksi"),
        backgroundColor: const Color(0xFFABD1C6),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(
            child: IndexedStack(
              index: _selectedTabIndex,
              children:
                  List.generate(4, (index) => _buildPendapatanContent(index)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      color: const Color(0xFFABD1C6),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildTabButton("LHR Tertimbang", 1, "assets/icons/tertimbang.png"),
            _buildTabButton("Pendapatan", 0, "assets/icons/wallet.png"),
            _buildTabButton("VLL", 2, "assets/icons/vll.png"),
            _buildTabButton("LHR Persegmen", 3, "assets/icons/segmen.png"),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index, String iconPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        style: TextButton.styleFrom(
          backgroundColor: _selectedTabIndex == index
              ? const Color(0xFF40635D)
              : const Color(0xFFE4EFEC),
          foregroundColor: _selectedTabIndex == index
              ? Colors.white
              : const Color(0xFF004643),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 20.0,
              height: 20.0,
              color: _selectedTabIndex == index
                  ? Colors.white
                  : const Color(0xFF40635D),
            ),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Lexend',
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendapatanContent(int tabIndex) {
    switch (tabIndex) {
      case 1:
        return _buildLHRContent();
      case 2:
        return _buildVLLContent();
      case 3:
        return _buildLHRPersegmenContent();
      default:
        return _buildPendapatanCard();
    }
  }

  // Tab Pendapatan
  Widget _buildPendapatanCard() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildDateNavigator(),
          _buildTotalPendapatanCard(),
        ],
      ),
    );
  }

  // Tab LHR Tertimbang
  Widget _buildLHRContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildDateNavigator(),
          _buildLHRTertimbangCard(),
        ],
      ),
    );
  }

  // Tab VLL
  Widget _buildVLLContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildDateNavigator(),
          _buildVLLCard(),
        ],
      ),
    );
  }

  // Tab LHR Persegmen
  Widget _buildLHRPersegmenContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildDateNavigator(),
          _buildLHRPersegmenCard(),
        ],
      ),
    );
  }

  Widget _buildDateNavigator() {
    return Container(
      color: const Color(0xFFABD1C6),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              // Logic to go to previous month
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          const Text(
            "Agustus 2024",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {
              // Logic to go to next month
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }

  // Pendapatan Card
  Widget _buildTotalPendapatanCard() {
    return Container(
      color: const Color(0xFFABD1C6),
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:
                MainAxisAlignment.center, // Pastikan Row dipusatkan
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "TOTAL PENDAPATAN",
                      style: TextStyle(
                        color: Color(0xff004643),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Rp. 60.603.596.000,-",
                      style: TextStyle(
                        color: Color(0xff001E1D),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Pastikan Divider tidak terbungkus Expanded
              const SizedBox(
                height: 50, // Sesuaikan tinggi divider
                child: VerticalDivider(
                  color: Color(0xff004643), // Warna garis
                  thickness: 0.3, // Ketebalan garis
                  width: 16, // Jarak horizontal di sekitar divider
                ),
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "RATA-RATA",
                      style: TextStyle(
                        color: Color(0xff004643),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Rp. 1.954.954.710,-",
                      style: TextStyle(
                        color: Color(0xff001E1D),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
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

  // LHR Tertimbang Card
  Widget _buildLHRTertimbangCard() {
    return Container(
      color: const Color(0xFFABD1C6), // Background color
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Baris pertama
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "JUMLAH LHR TERTIMBANG",
                          style: TextStyle(
                            color: Color(0xff004643),
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          "145.880",
                          style: TextStyle(
                            color: Color(0xff001E1D),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Kendaraan",
                          style: TextStyle(
                            color: Color(0xFF7EB7A6),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50, // Tinggi divider
                    child: VerticalDivider(
                      color: Color(0xff004643), // Warna garis
                      thickness: 0.3, // Ketebalan garis
                      width: 16, // Jarak horizontal
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "LHR TERTIMBANG TERATA",
                          style: TextStyle(
                            color: Color(0xff004643),
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          "145.880",
                          style: TextStyle(
                            color: Color(0xff001E1D),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Kendaraan",
                          style: TextStyle(
                            color: Color(0xFF7EB7A6),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16), // Jarak antar baris
              // Baris kedua
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "RKAP (2024)",
                          style: TextStyle(
                            color: Color(0xff004643),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "145.880",
                          style: TextStyle(
                            color: Color(0xff001E1D),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Kendaraan",
                          style: TextStyle(
                            color: Color(0xFF7EB7A6),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50, // Tinggi divider
                    child: VerticalDivider(
                      color: Color(0xff004643), // Warna garis
                      thickness: 0.3, // Ketebalan garis
                      width: 16, // Jarak horizontal
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "PPJT (2024)",
                          style: TextStyle(
                            color: Color(0xff004643),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "145.880",
                          style: TextStyle(
                            color: Color(0xff001E1D),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Kendaraan",
                          style: TextStyle(
                            color: Color(0xFF7EB7A6),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // VLL Card
  Widget _buildVLLCard() {
    return Container(
      color: const Color(0xFFABD1C6),
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "VOLUME LHR",
                      style: TextStyle(
                        color: Color(0xff004643),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "145.880",
                      style: TextStyle(
                        color: Color(0xff001E1D),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "KENDARAAN",
                      style: TextStyle(
                        color: Color(0xFF7EB7A6),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50, // Tinggi divider
                child: VerticalDivider(
                  color: Color(0xff004643), // Warna garis
                  thickness: 0.3, // Ketebalan garis
                  width: 16, // Jarak horizontal
                ),
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "JUMLAH VOL LHR",
                      style: TextStyle(
                        color: Color(0xff004643),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "145.880",
                      style: TextStyle(
                        color: Color(0xff001E1D),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "KENDARAAN",
                      style: TextStyle(
                        color: Color(0xFF7EB7A6),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
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

  // LHR Persegmen Card
  Widget _buildLHRPersegmenCard() {
    return Container(
      color: const Color(0xFFABD1C6),
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "JUMLAH LHR PERSEGEMEN",
                      style: TextStyle(
                        color: Color(0xff004643),
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "145.880",
                      style: TextStyle(
                        color: Color(0xff001E1D),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "KENDARAAN",
                      style: TextStyle(
                        color: Color(0xFF7EB7A6),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50, // Tinggi divider
                child: VerticalDivider(
                  color: Color(0xff004643), // Warna garis
                  thickness: 0.3, // Ketebalan garis
                  width: 16, // Jarak horizontal
                ),
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "RERATA LHR PERSEGEMEN",
                      style: TextStyle(
                        color: Color(0xff004643),
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "145.880",
                      style: TextStyle(
                        color: Color(0xff001E1D),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "KENDARAAN",
                      style: TextStyle(
                        color: Color(0xFF7EB7A6),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
