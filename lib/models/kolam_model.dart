class Kolam {
  String namaKolam;
  String jenisIkan;
  int jumlahIkan;
  int pakanPerHariKg;
  int umurHari;

  Kolam({
    required this.namaKolam,
    required this.jenisIkan,
    required this.jumlahIkan,
    required this.pakanPerHariKg,
    required this.umurHari,
  });

  // Aturan Usaha 1: Kebutuhan pakan sebulan dihitung dari pakan harian dikalikan 30
  int hitungPakanBulanan() {
    return pakanPerHariKg * 30;
  }

  // Aturan Usaha 2: Kolam berumur 90 hari ke atas ditandai "siap panen"
  bool get isSiapPanen => umurHari >= 90;

  // Aturan Usaha 3: Kolam berumur di bawah 14 hari ditandai "masa awal"
  bool get isMasaAwal => umurHari < 14;
}