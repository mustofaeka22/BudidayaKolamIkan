import 'package:flutter/material.dart';

import '../models/kolam_model.dart';

import '../screens/halaman_rincian_kolam.dart';

class KolamCard extends StatelessWidget {
  final Kolam kolam;

  final VoidCallback onUpdatePakan;

  const KolamCard({
    super.key,
    required this.kolam,
    required this.onUpdatePakan,
  });

  @override
  Widget build(BuildContext context) {
    bool siapPanen = kolam.isSiapPanen;
    bool masaAwal = kolam.isMasaAwal;

    // Menentukan ikon representasi visual di pojok kiri atas
    IconData getFishIcon() {
      String spesies = kolam.jenisIkan.toLowerCase();

      if (spesies.contains('lele')) {
        return Icons.set_meal;
      }

      if (spesies.contains('nila')) {
        return Icons.tsunami;
      }

      if (spesies.contains('gurame')) {
        return Icons.phishing;
      }

      return Icons.water_drop;
    }

    // ============================================================
    // URL FOTO IKAN
    // ============================================================
    String getFishImageUrl() {
      String spesies = kolam.jenisIkan.toLowerCase();

      if (spesies.contains('lele')) {
        return 'assets/images/lele.png';
      } else if (spesies.contains('nila')) {
        return 'assets/images/nila.png';
      } else if (spesies.contains('gurame')) {
        return 'assets/images/gurame.png';
      } else if (spesies.contains('patin')) {
        return 'assets/images/patin.png';
      } else {
        return 'assets/images/lele.png';
      }
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HalamanRincianKolam(
              kolam: kolam,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: siapPanen
                ? Colors.green.shade400
                : (masaAwal
                    ? Colors.amber.shade400
                    : Colors.blue.shade300),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============================================================
              // HEADER KARTU
              // ============================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade700,
                              Colors.blue.shade900,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.shade900.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          getFishIcon(),
                          color: Colors.white,
                          size: 20,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            kolam.namaKolam,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),

                          const SizedBox(height: 1),

                          Text(
                            'Spesies: ${kolam.jenisIkan}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // ============================================================
                  // STATUS BADGE
                  // ============================================================
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: siapPanen
                          ? Colors.green.shade50
                          : (masaAwal
                              ? Colors.amber.shade50
                              : Colors.blue.shade50),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: siapPanen
                            ? Colors.green.shade300
                            : (masaAwal
                                ? Colors.amber.shade300
                                : Colors.blue.shade200),
                      ),
                    ),
                    child: Text(
                      siapPanen
                          ? 'SIAP PANEN'
                          : (masaAwal ? 'MASA AWAL' : 'PEMBESARAN'),
                      style: TextStyle(
                        fontSize: 8.5,
                        fontWeight: FontWeight.bold,
                        color: siapPanen
                            ? Colors.green.shade800
                            : (masaAwal
                                ? Colors.amber.shade800
                                : Colors.blue.shade800),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ============================================================
              // FOTO IKAN
              // ============================================================
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          getFishImageUrl(),
                          fit: BoxFit.cover,

                          // Jika gambar gagal dimuat
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return Container(
                              color: Colors.blue.shade50,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey.shade500,
                                    size: 30,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Gambar tidak tersedia',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        // ====================================================
                        // GRADIENT GELAP DI BAGIAN BAWAH FOTO
                        // ====================================================
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                            ),
                          ),
                        ),

                        // ====================================================
                        // NAMA IKAN + LABEL REAL
                        // ====================================================
                        Positioned(
                          bottom: 8,
                          left: 10,
                          right: 10,
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ikan ${kolam.jenisIkan}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 3,
                                      color: Colors.black54,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius:
                                      BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'REAL',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 7.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFE2E8F0),
              ),

              const SizedBox(height: 10),

              // ============================================================
              // INFORMASI STATISTIK
              // ============================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statItem(
                    Icons.pets,
                    '${kolam.jumlahIkan} ekor',
                    Colors.blue,
                  ),

                  _statItem(
                    Icons.timer,
                    '${kolam.umurHari} Hari',
                    Colors.amber.shade800,
                  ),

                  _statItem(
                    Icons.food_bank,
                    '${kolam.pakanPerHariKg} kg/hr',
                    Colors.green.shade700,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ============================================================
              // TOMBOL AKSI
              // ============================================================
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: masaAwal ? null : onUpdatePakan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade100,
                    disabledForegroundColor: Colors.grey.shade400,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 9,
                    ),
                  ),
                  child: Text(
                    masaAwal
                        ? 'Pakan Terkunci (Masa Awal)'
                        : 'Atur Pakan',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // STATISTIK KECIL
  // ============================================================
  Widget _statItem(
    IconData icon,
    String text,
    Color color,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 13,
          color: color,
        ),

        const SizedBox(width: 4),

        Text(
          text,
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF334155),
          ),
        ),
      ],
    );
  }
}