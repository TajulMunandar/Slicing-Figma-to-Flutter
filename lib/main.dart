import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

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
          _chartPendapatan(),
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

  final List<BarChartGroupData> barChartData = [
    BarChartGroupData(x: 0, barRods: [
      BarChartRodData(
        toY: 140000,
        color: Color(0xFF7EB7A6),
        width: 10,
        borderRadius: BorderRadius.zero,
      ),
    ]),
    BarChartGroupData(x: 1, barRods: [
      BarChartRodData(
        toY: 100000,
        color: Color(0xFF7EB7A6),
        width: 10,
        borderRadius: BorderRadius.zero,
      ),
    ]),
    BarChartGroupData(x: 2, barRods: [
      BarChartRodData(
        toY: 100000,
        color: Color(0xFF7EB7A6),
        width: 10,
        borderRadius: BorderRadius.zero,
      ),
    ]),
    BarChartGroupData(x: 3, barRods: [
      BarChartRodData(
        toY: 100000,
        color: Color(0xFF7EB7A6),
        width: 10,
        borderRadius: BorderRadius.zero,
      ),
    ]),
    BarChartGroupData(x: 4, barRods: [
      BarChartRodData(
        toY: 100000,
        color: Color(0xFF7EB7A6),
        width: 10,
        borderRadius: BorderRadius.zero,
      ),
    ]),
    BarChartGroupData(x: 5, barRods: [
      BarChartRodData(
        toY: 100000,
        color: Color(0xFF7EB7A6),
        width: 10,
        borderRadius: BorderRadius.zero,
      ),
    ]),
    BarChartGroupData(x: 6, barRods: [
      BarChartRodData(
        toY: 100000,
        color: Color(0xFF7EB7A6),
        width: 10,
        borderRadius: BorderRadius.zero,
      ),
    ]),
    BarChartGroupData(x: 7, barRods: [
      BarChartRodData(
        toY: 100000,
        color: Color(0xFF7EB7A6),
        width: 10,
        borderRadius: BorderRadius.zero,
      ),
    ]),
    BarChartGroupData(x: 8, barRods: [
      BarChartRodData(
        toY: 100000,
        color: Color(0xFF7EB7A6),
        width: 10,
        borderRadius: BorderRadius.zero,
      ),
    ]),
    BarChartGroupData(x: 9, barRods: [
      BarChartRodData(
        toY: 100000,
        color: Color(0xFF7EB7A6),
        width: 10,
        borderRadius: BorderRadius.zero,
      ),
    ]),
    BarChartGroupData(x: 10, barRods: [
      BarChartRodData(
        toY: 100000,
        color: Color(0xFF7EB7A6),
        width: 10,
        borderRadius: BorderRadius.zero,
      ),
    ]),
    BarChartGroupData(x: 12, barRods: [
      BarChartRodData(
        toY: 100000,
        color: Color(0xFF7EB7A6),
        width: 10,
        borderRadius: BorderRadius.zero,
      ),
    ]),
    BarChartGroupData(x: 11, barRods: [
      BarChartRodData(
        toY: 100000,
        color: Color(0xFF7EB7A6),
        width: 10,
        borderRadius: BorderRadius.zero,
      ),
    ]),
    BarChartGroupData(x: 13, barRods: [
      BarChartRodData(
        toY: 100000,
        color: Color(0xFF7EB7A6),
        width: 10,
        borderRadius: BorderRadius.zero,
      ),
    ]),
    BarChartGroupData(x: 15, barRods: [
      BarChartRodData(
        toY: 100000,
        color: Color(0xFF7EB7A6),
        width: 10,
        borderRadius: BorderRadius.zero,
      ),
    ]),
  ];

  Widget _chartPendapatan() {
    double maxY =
        150000; // Tentukan batas atas sumbu Y lebih tinggi dari data tertinggi
    double minY = 0; // Tentukan batas bawah sumbu Y (bisa disesuaikan)

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Grafik Pendapatan",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Menambahkan scroll horizontal
            child: Container(
              width: barChartData.length *
                  30.0, // Tentukan lebar sesuai dengan banyaknya data
              height: 230,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: BarChart(
                  BarChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                            showTitles: false), // Menghilangkan label kanan
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, titleMeta) {
                            // Menampilkan angka penuh tanpa singkatan
                            return Text(
                              value.toStringAsFixed(
                                  0), // Angka penuh tanpa format singkatan
                              style: TextStyle(fontSize: 10),
                            );
                          },
                          reservedSize:
                              40, // Menyesuaikan ukuran ruang kiri untuk label
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(
                            color: Colors.black, width: 1), // garis bawah
                        left: BorderSide(
                            color: Colors.black, width: 1), // garis kiri
                        right: BorderSide.none, // menghilangkan garis kanan
                        top: BorderSide.none, // menghilangkan garis atas
                      ),
                    ),
                    barGroups: barChartData, // Menyisipkan data chart batang
                    minY: minY, // Menetapkan batas bawah sumbu Y
                    maxY: maxY, // Menetapkan batas atas sumbu Y
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
