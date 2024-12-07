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
          _chartPendapatan(
              context, setState, "GRAFIK PENDAPATAN", "Golongan Tol"),
          _dataPendapatan(),
          _cardDownload(),
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
          _chartPendapatan(
              context, setState, "GARFIK LHR TERTIMBANG", "Golongan"),
          _dataTertimbang(),
          _cardDownload(),
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
          _chartPendapatan(
              context, setState, "GRAFIK VOLUME LALU LINTAS", "Golongan"),
          _buildSegmentGrid(),
          _cardDownload(),
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
          _chartPendapatan(
              context, setState, "GRAFIK LHR PERSEGEMEN", "Golongan"),
          _dataSegmen(),
          _cardDownload(),
        ],
      ),
    );
  }

  Widget _buildDateNavigator() {
    return Container(
      color: const Color(0xFFABD1C6),
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
      child: const Card(
        color: Color(0xFFFFFFFF),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:
                MainAxisAlignment.center, // Pastikan Row dipusatkan
            children: [
              Expanded(
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
              SizedBox(
                height: 50, // Sesuaikan tinggi divider
                child: VerticalDivider(
                  color: Color(0xff004643), // Warna garis
                  thickness: 0.3, // Ketebalan garis
                  width: 16, // Jarak horizontal di sekitar divider
                ),
              ),
              Expanded(
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
      child: const Card(
        color: Color(0xFFFFFFFF),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Baris pertama
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "JUMLAH LHR TERTIMBANG",
                          style: TextStyle(
                            color: Color(0xff004643),
                            fontWeight: FontWeight.w600,
                            fontSize: 9,
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
                          "KENDARAAN",
                          style: TextStyle(
                            color: Color(0xFF7EB7A6),
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
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
                      children: [
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
              SizedBox(height: 16), // Jarak antar baris
              // Baris kedua
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                  SizedBox(
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
                      children: [
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
      child: const Card(
        color: Color(0xFFFFFFFF),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
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
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "KENDARAAN",
                      style: TextStyle(
                        color: Color(0xFF7EB7A6),
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
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
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
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
      child: const Card(
        color: Color(0xFFFFFFFF),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "JUMLAH LHR PERSEGEMEN",
                      style: TextStyle(
                        color: Color(0xff004643),
                        fontWeight: FontWeight.w600,
                        fontSize: 9,
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
                      "KENDARAAN",
                      style: TextStyle(
                        color: Color(0xFF7EB7A6),
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
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
                  children: [
                    Text(
                      "RERATA LHR PERSEGEMEN",
                      style: TextStyle(
                        color: Color(0xff004643),
                        fontWeight: FontWeight.w600,
                        fontSize: 9,
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
                      "KENDARAAN",
                      style: TextStyle(
                        color: Color(0xFF7EB7A6),
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
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

  bool isDropdownOpen = false;
  bool isSearching = false;

  int? touchedIndex;
  double? selectedValue; // Nilai dari bar yang ditekan
  final List<double> barData = [
    120000,
    100000,
    150000,
    130000,
    90000,
    110000,
    80000,
    140000,
    95000,
    125000,
    125000,
    125000,
    125000,
    125000,
    125000,
    125000,
    125000,
    125000,
    125000,
    125000,
    125000,
  ];

  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> filters = [
    {"label": "Gerbang Tol 1", "value": false},
    {"label": "Gerbang Tol 2", "value": false},
    {"label": "Gerbang Tol 3", "value": false},
  ];

  int getSelectedCount() {
    return filters.where((filter) => filter["value"] == true).length;
  }

  bool isFullScreen = false;

  String judulGrafik = "Grafik Pendapatan";

  Widget _chartPendapatan(BuildContext context, StateSetter setState,
      String judulGrafik, String Select) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            judulGrafik,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF004643)),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isDropdownOpen = !isDropdownOpen;
                isSearching =
                    !isSearching; // Mengubah menjadi true agar tampil TextField
              });
            },
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF7EB7A6)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize:
                    MainAxisSize.min, // Menambahkan ini agar Row shrink-wrap
                children: [
                  // Menampilkan teks atau input pencarian
                  if (!isSearching)
                    Text(
                      Select,
                      style: const TextStyle(fontSize: 14),
                    ),
                  if (isSearching)
                    Flexible(
                      fit: FlexFit
                          .loose, // Memberikan fleksibilitas tanpa memaksa
                      child: SizedBox(
                        height: 20, // Atur tinggi Container sesuai kebutuhan
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: 'Cari Gerbang...',
                            prefixIcon: Icon(
                              Icons.search,
                              size: 20, // Atur ukuran ikon
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 0, // Mengatur lebar minimum ikon
                              minHeight: 0, // Mengatur tinggi minimum ikon
                            ),
                            border: InputBorder.none,
                            fillColor: Color(0xFF7EB7A6),
                            hoverColor: Color(0xFF7EB7A6),
                          ),
                          style: const TextStyle(
                            fontSize:
                                12, // Mengatur ukuran font teks di dalam TextField
                          ),
                          onChanged: (text) {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  const SizedBox(width: 4),
                  // Menampilkan count jika ada item yang dipilih
                  if (getSelectedCount() > 0)
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${getSelectedCount()}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  Icon(
                    isDropdownOpen
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        if (isDropdownOpen)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              width: 270,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "List Gerbang " + "(${getSelectedCount()})",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                        ),
                        if (getSelectedCount() > 0)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  filters.forEach(
                                      (filter) => filter["value"] = false);
                                });
                              },
                              child: const Text("Hapus Semua",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red)),
                            ),
                          ),
                        if (getSelectedCount() == 0)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  filters.forEach(
                                      (filter) => filter["value"] = true);
                                });
                              },
                              child: const Text("Pilih Semua",
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xFF004643))),
                            ),
                          ),
                      ],
                    ),
                    const Divider(), // Divider yang menjadi pemisah

                    // List Filter
                    filters
                            .where((filter) => filter["label"]
                                .toLowerCase()
                                .contains(searchController.text.toLowerCase()))
                            .isEmpty
                        // Jika tidak ada hasil pencarian
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Data tidak ditemukan', // Pesan jika tidak ada hasil
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xff3a3a3a)),
                            ),
                          )
                        : Column(
                            children: filters
                                .where((filter) => filter["label"]
                                    .toLowerCase()
                                    .contains(
                                        searchController.text.toLowerCase()))
                                .map((filter) {
                              return CheckboxListTile(
                                value: filter["value"],
                                onChanged: (bool? value) {
                                  setState(() {
                                    filter["value"] = value ?? false;
                                  });
                                },
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      filter["label"],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff001E1D)),
                                    ),
                                  ],
                                ),
                                activeColor: const Color(0xFF004643),
                                tileColor: filter["value"]
                                    ? const Color(0xFFF1FCF9)
                                    : null,
                                side:
                                    const BorderSide(color: Color(0xFF004643)),
                              );
                            }).toList(),
                          ),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: barData.length * 50.0,
              height: isFullScreen
                  ? MediaQuery.of(context).size.height
                  : 230, // Fullscreen mode atau ukuran normal
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        // tooltipBgColor: Colors.black,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            'Nilai\n${rod.toY.toStringAsFixed(0)}',
                            const TextStyle(color: Colors.white),
                          );
                        },
                      ),
                      touchCallback: (event, response) {
                        setState(() {
                          if (response != null && response.spot != null) {
                            touchedIndex = response.spot!.touchedBarGroupIndex;
                            selectedValue =
                                barData[touchedIndex!]; // Simpan nilai
                          } else {
                            touchedIndex = null;
                            selectedValue = null;
                          }
                        });
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, titleMeta) {
                            return Text(
                              value.toStringAsFixed(0),
                              style: const TextStyle(fontSize: 10),
                            );
                          },
                          reservedSize: 50,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        bottom: BorderSide(color: Colors.black, width: 1),
                        left: BorderSide(color: Colors.black, width: 1),
                        right: BorderSide.none,
                        top: BorderSide.none,
                      ),
                    ),
                    barGroups: barData.asMap().entries.map((entry) {
                      final isTouched = entry.key == touchedIndex;
                      return BarChartGroupData(
                        x: entry.key,
                        barRods: [
                          BarChartRodData(
                            toY: entry.value,
                            color: Color(0xFF7EB7A6),
                            width: 20,
                            borderRadius: BorderRadius.zero,
                            backDrawRodData:
                                BackgroundBarChartRodData(show: true),
                            borderSide: isTouched
                                ? BorderSide(color: Colors.black, width: 2)
                                : BorderSide.none,
                          ),
                        ],
                      );
                    }).toList(),
                    gridData: FlGridData(show: true),
                    extraLinesData: selectedValue != null
                        ? ExtraLinesData(horizontalLines: [
                            HorizontalLine(
                              y: selectedValue!, // Garis mengikuti nilai yang ditekan
                              color: Colors.black,
                              strokeWidth: 2,
                              dashArray: [4, 4],
                              label: HorizontalLineLabel(
                                show: true,
                                labelResolver: (_) =>
                                    ' ${selectedValue!.toStringAsFixed(0)}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ])
                        : ExtraLinesData(horizontalLines: []),
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => FullScreenChart(
                    barData: barData,
                  ),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              side: MaterialStateProperty.all(BorderSide(
                  color: Color(0xFF7EB7A6),
                  width: 1)), // Border color and width
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12), // Rounded corner radius
              )),
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                  vertical: 12, horizontal: 24)), // Padding for the button
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.fullscreen,
                    color: Color(0xFF7EB7A6)), // Icon before text
                SizedBox(width: 8), // Space between icon and text
                Text(
                  "Full Screen",
                  style: TextStyle(color: Color(0xFF7EB7A6), fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FullScreenChart extends StatelessWidget {
  final List<double> barData;

  FullScreenChart({required this.barData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Full Screen Chart"),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: barData.length * 50.0,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          'Nilai\n${rod.toY.toStringAsFixed(0)}',
                          TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
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
                          return Text(
                            value.toStringAsFixed(0),
                            style: TextStyle(fontSize: 10),
                          );
                        },
                        reservedSize: 50,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 1),
                      left: BorderSide(color: Colors.black, width: 1),
                      right: BorderSide.none,
                      top: BorderSide.none,
                    ),
                  ),
                  barGroups: barData.asMap().entries.map((entry) {
                    return BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value,
                          color: Color(0xFF7EB7A6),
                          width: 20,
                        ),
                      ],
                    );
                  }).toList(),
                  gridData: FlGridData(show: true),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _dataPendapatan() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "DETAIL PENDAPATAN",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xff004643),
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: List.generate(10, (index) {
            return Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jatikarya 1",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff001E1D),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "99.999.9999",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff001E1D),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Rerata",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffA3A3A3),
                          ),
                        ),
                        Text(
                          "99.999.9999",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 24,
                ),
              ],
            );
          }),
        )
      ],
    ),
  );
}

Widget _dataTertimbang() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Golongan",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xff004643),
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: List.generate(10, (index) {
            // Tentukan warna yang ingin digunakan untuk setiap titik bulat
            Color circleColor = index.isEven
                ? Colors.blue
                : Colors.green; // Contoh warna berbeda

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Ganti Icon dengan titik bulat (Container)
                    Container(
                      width: 10, // Ukuran diameter titik
                      height: 10, // Ukuran diameter titik
                      decoration: BoxDecoration(
                        color: circleColor, // Ganti warna sesuai index
                        shape:
                            BoxShape.circle, // Membuatnya berbentuk lingkaran
                      ),
                    ),
                    SizedBox(width: 8),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Golongan 1",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff212121),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "99.999.9999",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "KENDARAAN",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFFA3A3A3),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 24,
                ),
              ],
            );
          }),
        )
      ],
    ),
  );
}

Widget _dataSegmen() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Data LHR Persegmen",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xff004643),
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: List.generate(10, (index) {
            return Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Cimanggis - Jatikarya",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "3,78Km",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffE16162),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Rerata",
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xffa3a3a3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "99.999.999",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff001E1D),
                      ),
                    ),
                    Text(
                      "99.999.9999",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff001E1D),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Golongan 1
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gol 1",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xffa3a3a3),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "99.999.9999",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff001E1D),
                          ),
                        ),
                      ],
                    ),
                    // Golongan 2
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gol 2",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xffa3a3a3),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "99.999.9999",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff001E1D),
                          ),
                        ),
                      ],
                    ),
                    // Golongan 3
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gol 3",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xffa3a3a3),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "99.999.9999",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff001E1D),
                          ),
                        ),
                      ],
                    ),
                    // Golongan 4
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gol 4",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xffa3a3a3),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "99.999.9999",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff001E1D),
                          ),
                        ),
                      ],
                    ),
                    // Golongan 5
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gol 5",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xffa3a3a3),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "99.999.9999",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff001E1D),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 24,
                ),
              ],
            );
          }),
        )
      ],
    ),
  );
}

Widget _buildSegmentGrid() {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendItem("Off Ramp", Colors.orange),
              _buildLegendItem("Enterance", Colors.teal),
              _buildLegendItem("Exit", Colors.red),
            ],
          ),
          const SizedBox(height: 16),
          // Grid Items
          Column(
            children: [
              // Baris pertama
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildGridItem(
                        "Jatikarya 1", "99,999,9999", Colors.orange),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildGridItem(
                        "Jatikarya 2", "99,999,9999", Colors.orange),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Baris kedua
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildGridItem(
                        "Jatikarya U 1", "99,999,9999", Colors.teal),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildGridItem(
                        "Jatikarya U 2", "99,999,9999", Colors.red),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            children: [
              // Baris pertama
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildGridItem(
                        "Jatikarya 1", "99,999,9999", Colors.orange),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildGridItem(
                        "Jatikarya 2", "99,999,9999", Colors.orange),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Baris kedua
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildGridItem(
                        "Jatikarya U 1", "99,999,9999", Colors.teal),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildGridItem(
                        "Jatikarya U 2", "99,999,9999", Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildLegendItem(String label, Color color) {
  return Row(
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 8),
      Text(
        label,
        style: const TextStyle(fontSize: 12, color: Colors.black87),
      ),
    ],
  );
}

Widget _buildGridItem(String title, String value, Color borderColor) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: borderColor, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        // Dot
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        // Text Info
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _cardDownload() {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Card(
      color: const Color(0xffE4EFEC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // rounded corners
      ),
      elevation: 4, // shadow effect
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'DETAIL LAPORAN',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xff004643), // Dark teal color for the header
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Silahkan download untuk informasi detail laporan ini atau akses di iomsct.com',
              style: TextStyle(fontSize: 12, color: Color(0xff004643)),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight, // Align the button to the left
              child: ElevatedButton(
                onPressed: () {
                  // Define your download functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff004643), // Button color
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // rounded corners for the button
                  ),
                ),
                child: const Text(
                  'DOWNLOAD LAPORAN',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
