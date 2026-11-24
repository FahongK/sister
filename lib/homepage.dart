import 'package:flutter/material.dart';
import 'login_page.dart';
import 'presensi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabIndex = 0;
  bool _hadir = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
              decoration: const BoxDecoration(
                color: Color(0xFF0F2854),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sister Skansika • SMK Negeri 1 Bukateja',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Selamat pagi, Farhan!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Dashboard Siswa',
                        style: TextStyle(color: Color(0xFF93C5FD)),
                      ),
                    ],
                  ),
                  IconButton(
                    tooltip: 'Keluar',
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(0xFFDBEAFE),
                        child: Text('FR'),
                      ),
                      title: Text(
                        'Farhan Radit Setyawan',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('XI RPL 1 • Siswa Aktif'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Card(
                    color: Color(0xFFEFF6FF),
                    child: Padding(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jadwal Pelajaran Hari Ini',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F2854),
                            ),
                          ),
                          Divider(),
                          Text('08.00  •  Matematika (R. 203)'),
                          SizedBox(height: 6),
                          Text('09.40  •  Pemrograman Web (Lab RPL 1)'),
                          SizedBox(height: 6),
                          Text('11.20  •  Basis Data (Lab RPL 2)'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                const Text(
                                  'Presensi Saya',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _hadir ? 'Hadir • 97%' : 'Hadir • 96%',
                                  style: const TextStyle(color: Colors.green),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () async {
                                    final berhasil =
                                        await Navigator.push<bool>(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const PresensiPage(),
                                      ),
                                    );
                                    if (berhasil == true) {
                                      setState(() => _hadir = true);
                                    }
                                  },
                                  child: Text(
                                    _hadir ? 'Sudah Hadir' : 'Isi Presensi',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Icon(Icons.assignment,
                                    color: Color(0xFF0F2854)),
                                SizedBox(height: 6),
                                Text(
                                  'Tugas & LMS',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '3 tugas menunggu',
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (i) => setState(() => _tabIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0F2854),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Jadwal'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'LMS'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}