import 'package:flutter/material.dart';
import '../models/kolam_model.dart';

class HalamanRincianKolam extends StatelessWidget {
  final Kolam kolam;

  const HalamanRincianKolam({
    super.key,
    required this.kolam,
  });

  @override
  Widget build(BuildContext context) {
    final int pakanBulanan = kolam.hitungPakanBulanan();
    final bool siapPanen = kolam.isSiapPanen;
    final bool masaAwal = kolam.isMasaAwal;

    final String statusText = siapPanen
        ? 'SIAP PANEN'
        : masaAwal
            ? 'MASA AWAL'
            : 'PEMBESARAN';

    final Color statusTextColor = siapPanen
        ? const Color(0xFF166534)
        : masaAwal
            ? const Color(0xFFB45309)
            : const Color(0xFF1D4ED8);

    final Color statusBackgroundColor = siapPanen
        ? const Color(0xFFDCFCE7)
        : masaAwal
            ? const Color(0xFFFEF3C7)
            : const Color(0xFFDBEAFE);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),

      // ==========================================================
      // APP BAR
      // ==========================================================
      appBar: AppBar(
        title: Text(
          'Rincian ${kolam.namaKolam}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // ==========================================================
      // BODY
      // ==========================================================
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
        children: [
          // ========================================================
          // HERO / BANNER
          // ========================================================
          Container(
            height: 154,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF2563EB),
                  Color(0xFF1E3A8A),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1E3A8A).withOpacity(0.12),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ICON
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.13),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.water_rounded,
                    color: Colors.white,
                    size: 27,
                  ),
                ),

                const SizedBox(width: 15),

                // TEXT
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kolam.namaKolam,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),

                      const SizedBox(height: 7),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.13),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          'Spesies: ${kolam.jenisIkan}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 7),

                      const Text(
                        'Kelola budidaya dengan lebih mudah,\n'
                        'untuk hasil yang lebih baik.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // STATUS
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: statusBackgroundColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusTextColor,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ========================================================
          // SECTION HEADER
          // ========================================================
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(width: 9),

              const Text(
                'Informasi & Metrik Budidaya',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF172554),
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          const Text(
            'Pantau kondisi kolam dan perkembangan budidaya secara real-time.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
              height: 1.4,
            ),
          ),

          const SizedBox(height: 15),

          // ========================================================
          // METRICS
          // ========================================================
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            mainAxisExtent: 128,
            children: [
              _buildMetricCard(
                icon: Icons.set_meal_outlined,
                title: 'Populasi Ikan',
                value: '${kolam.jumlahIkan}',
                unit: 'Ekor',
                footerText: '+5% dari minggu lalu',
                footerColor: const Color(0xFF16A34A),
              ),

              _buildMetricCard(
                icon: Icons.calendar_today_outlined,
                title: 'Umur Budidaya',
                value: '${kolam.umurHari}',
                unit: 'Hari',
                footerText: masaAwal
                    ? 'Masih dalam fase awal pertumbuhan'
                    : 'Fase pertumbuhan stabil',
                footerColor: const Color(0xFF64748B),
              ),

              _buildMetricCard(
                icon: Icons.inventory_2_outlined,
                title: 'Pakan Harian',
                value: '${kolam.pakanPerHariKg}',
                unit: 'Kg / Hari',
                footerText: '+2% dari minggu lalu',
                footerColor: const Color(0xFF16A34A),
              ),

              _buildMetricCard(
                icon: Icons.calendar_month_outlined,
                title: 'Pakan Bulanan',
                value: '$pakanBulanan',
                unit: 'Kg / Bulan',
                footerText: 'Estimasi kebutuhan bulan ini',
                footerColor: const Color(0xFF64748B),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ========================================================
          // CATATAN
          // ========================================================
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.025),
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
                    color: const Color(0xFFEAF3FF),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(
                    Icons.lightbulb_outline_rounded,
                    color: Color(0xFF2563EB),
                    size: 22,
                  ),
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Catatan Pengelolaan',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF172554),
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        'Pastikan kualitas air tetap stabil, lakukan '
                        'pemberian pakan sesuai jadwal, dan pantau '
                        'pertumbuhan ikan secara rutin.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF64748B),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 7),

                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF94A3B8),
                  size: 23,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // METRIC CARD
  // ================================================================
  Widget _buildMetricCard({
    required IconData icon,
    required String title,
    required String value,
    required String unit,
    required String footerText,
    required Color footerColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ICON
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF3FF),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF2563EB),
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          // CONTENT
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF172554),
                        height: 1,
                      ),
                    ),

                    const SizedBox(width: 5),

                    Flexible(
                      child: Text(
                        unit,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  footerText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: footerColor,
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