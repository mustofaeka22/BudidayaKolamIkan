import 'package:flutter/material.dart';

import '../models/kolam_model.dart';
import '../widgets/kolam_card.dart';
import '../widgets/pengatur_pakan.dart';

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({super.key});

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {
  late TextEditingController _searchController;

  String _searchQuery = '';

  final List<Kolam> _daftarKolam = [
    Kolam(
      namaKolam: 'Kolam A1',
      jenisIkan: 'Lele',
      jumlahIkan: 1500,
      pakanPerHariKg: 8,
      umurHari: 10,
    ),
    Kolam(
      namaKolam: 'Kolam A2',
      jenisIkan: 'Nila',
      jumlahIkan: 1200,
      pakanPerHariKg: 6,
      umurHari: 95,
    ),
    Kolam(
      namaKolam: 'Kolam B1',
      jenisIkan: 'Gurame',
      jumlahIkan: 800,
      pakanPerHariKg: 4,
      umurHari: 45,
    ),
    Kolam(
      namaKolam: 'Kolam B2',
      jenisIkan: 'Lele',
      jumlahIkan: 2000,
      pakanPerHariKg: 10,
      umurHari: 12,
    ),
    Kolam(
      namaKolam: 'Kolam C1',
      jenisIkan: 'Nila',
      jumlahIkan: 1000,
      pakanPerHariKg: 5,
      umurHari: 92,
    ),
    Kolam(
      namaKolam: 'Kolam C2',
      jenisIkan: 'Patin',
      jumlahIkan: 1500,
      pakanPerHariKg: 7,
      umurHari: 60,
    ),
    Kolam(
      namaKolam: 'Kolam D1',
      jenisIkan: 'Gurame',
      jumlahIkan: 600,
      pakanPerHariKg: 3,
      umurHari: 100,
    ),
    Kolam(
      namaKolam: 'Kolam D2',
      jenisIkan: 'Lele',
      jumlahIkan: 2500,
      pakanPerHariKg: 12,
      umurHari: 8,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Kolam> filteredList = _daftarKolam.where((kolam) {
      final query = _searchQuery.toLowerCase().trim();

      return kolam.namaKolam.toLowerCase().contains(query) ||
          kolam.jenisIkan.toLowerCase().contains(query);
    }).toList();

    int totalPakanHariIni = 0;
    int totalSiapPanen = 0;

    for (final kolam in filteredList) {
      totalPakanHariIni += kolam.pakanPerHariKg;

      if (kolam.isSiapPanen) {
        totalSiapPanen++;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),

      // ==========================================================
      // APP BAR
      // ==========================================================
      appBar: AppBar( 
        title: const Text(
          'Monitoring & Pencatatan Budidaya',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),

      // ==========================================================
      // BODY
      // ==========================================================
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                20,
                16,
                20,
                24,
              ),
              children: [
                // ======================================================
                // 1. BANNER KELOLA KOLAM IKAN
                // ======================================================
                _buildWelcomeBanner(),

                const SizedBox(height: 16),

                // ======================================================
                // 2. PENCARIAN
                // ======================================================
                SizedBox(
                  height: 44,
                  child: _buildSearchField(),
                ),

                const SizedBox(height: 16),

                // ======================================================
                // 3. RINGKASAN
                // ======================================================
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount;
                    double cardHeight;

                    if (constraints.maxWidth < 600) {
                      crossAxisCount = 1;
                      cardHeight = 88;
                    } else if (constraints.maxWidth < 900) {
                      crossAxisCount = 2;
                      cardHeight = 100;
                    } else {
                      crossAxisCount = 3;
                      cardHeight = 100;
                    } 

                    return GridView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        mainAxisExtent: cardHeight,
                      ),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return _buildInfoCard(
                            'Total Kolam',
                            '${filteredList.length} Kolam',
                            'Kolam aktif terpantau',
                            Icons.water_rounded,
                            Colors.blue,
                          );
                        }

                        if (index == 1) {
                          return _buildInfoCard(
                            'Total Pakan Hari Ini',
                            '$totalPakanHariIni kg',
                            'Pakan yang diberikan hari ini',
                            Icons.inventory_2_rounded,
                            Colors.green,
                          );
                        }

                        return _buildInfoCard(
                          'Siap Panen',
                          '$totalSiapPanen Kolam',
                          'Kolam berumur >= 90 hari',
                          Icons.verified_rounded,
                          Colors.amber,
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 22),

                // ======================================================
                // 4. JUDUL DAFTAR KOLAM
                // ======================================================
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    const SizedBox(width: 8),

                    const Expanded(
                      child: Text(
                        'Daftar Kolam',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),

                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Semua Kolam →',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF2563EB),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ======================================================
                // 5. GRID KOLAM RESPONSIVE
                // ======================================================
                if (filteredList.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(
                      child: Text(
                        'Pencarian kolam tidak ditemukan',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                else
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount;

                      if (constraints.maxWidth < 600) {
                        crossAxisCount = 1;
                      } else if (constraints.maxWidth < 900) {
                        crossAxisCount = 2;
                      } else {
                        crossAxisCount = 3;
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(),
                        itemCount: filteredList.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 330,
                        ),
                        itemBuilder: (context, index) {
                          final kolam = filteredList[index];

                          return KolamCard(
                            kolam: kolam,
                            onUpdatePakan: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    PengaturPakan(
                                  kolam: kolam,
                                  onChanged: (newPakan) {
                                    setState(() {
                                      kolam.pakanPerHariKg =
                                          newPakan;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // SEARCH FIELD
  // ================================================================
  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Cari nama kolam atau jenis ikan...',
        prefixIcon: const Icon(
          Icons.search,
          size: 20,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: const Color(0xFFF1F5F9),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ================================================================
  // WELCOME BANNER
  // ================================================================
  Widget _buildWelcomeBanner() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool smallScreen = constraints.maxWidth < 600;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(
            smallScreen ? 18 : 22,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF38BDF8),
                Color(0xFF1E40AF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: smallScreen
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selamat Datang di',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'Kelola Kolam Ikan',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Pantau kondisi kolam, kelola pakan, '
                      'dan catat perkembangan dengan mudah.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.waves_rounded,
                        color: Colors.white30,
                        size: 55,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat Datang di',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Kelola Kolam Ikan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),

                          SizedBox(height: 7),

                          Text(
                            'Pantau kondisi kolam, kelola pakan, '
                            'dan catat perkembangan dengan mudah.',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 20),

                    const Icon(
                      Icons.waves_rounded,
                      color: Colors.white30,
                      size: 70,
                    ),
                  ],
                ),
        );
      },
    );
  }

  // ================================================================
  // INFO CARD
  // ================================================================
  Widget _buildInfoCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    MaterialColor color,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color.shade700,
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF64748B),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}