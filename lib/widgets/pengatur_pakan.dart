import 'package:flutter/material.dart';
import '../models/kolam_model.dart';

class PengaturPakan extends StatefulWidget {
  final Kolam kolam;
  final ValueChanged<int> onChanged;

  const PengaturPakan({
    super.key,
    required this.kolam,
    required this.onChanged,
  });

  @override
  State<PengaturPakan> createState() => _PengaturPakanState();
}

class _PengaturPakanState extends State<PengaturPakan> {
  late int _currentPakan;

  @override
  void initState() {
    super.initState();
    _currentPakan = widget.kolam.pakanPerHariKg;
  }

  @override
  Widget build(BuildContext context) {
    int pakanBulanan = widget.kolam.hitungPakanBulanan();

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text('Pengatur Pakan: ${widget.kolam.namaKolam}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Jenis Ikan: ${widget.kolam.jenisIkan}'),
          const SizedBox(height: 12),
          Text(
            'Pakan Harian: $_currentPakan kg / hari',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _currentPakan > 1
                    ? () {
                        setState(() {
                          _currentPakan--;
                          widget.kolam.pakanPerHariKg = _currentPakan;
                        });
                      }
                    : null,
                icon: const Icon(Icons.remove_circle, color: Colors.red, size: 36),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentPakan++;
                    widget.kolam.pakanPerHariKg = _currentPakan;
                  });
                },
                icon: const Icon(Icons.add_circle, color: Colors.green, size: 36),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Estimasi Pakan Sebulan (30x):'),
                Text(
                  '$pakanBulanan kg',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3A8A),
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            widget.onChanged(_currentPakan);
            Navigator.pop(context);
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}