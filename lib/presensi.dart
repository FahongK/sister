import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PresensiPage extends StatefulWidget {
  const PresensiPage({super.key});

  @override
  State<PresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  CameraController? _controller;
  bool _kameraSiap = false;
  String? _errorKamera;
  Uint8List? _fotoBytes;
  String? _waktuAbsen;

  @override
  void initState() {
    super.initState();
    _nyalakanKamera();
  }

  Future<void> _nyalakanKamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        if (!mounted) return;
        setState(() => _errorKamera = 'Kamera tidak ditemukan.');
        return;
      }

      final kameraDepan = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        kameraDepan,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await controller.initialize();
      if (!mounted) return;

      setState(() {
        _controller = controller;
        _kameraSiap = true;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _errorKamera = 'Izin kamera ditolak atau error: $e');
    }
  }

  Future<void> _jepretFoto() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    final XFile foto = await _controller!.takePicture();
    final bytes = await foto.readAsBytes();
    final now = DateTime.now();

    if (!mounted) return;
    setState(() {
      _fotoBytes = bytes;
      _waktuAbsen =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} WIB';
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presensi Kamera Siswa'),
        backgroundColor: const Color(0xFF0F2854),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Card(
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.person, color: Color(0xFF0F2854)),
                title: Text(
                  'Farhan Radit Setyawan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('XI RPL 1 • Absen 10'),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 300,
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFCBD5E1), width: 2),
              ),
              child: _buildLayarKamera(),
            ),
            const SizedBox(height: 12),
            if (_waktuAbsen != null)
              Text(
                'Foto diambil pukul: $_waktuAbsen',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: !_kameraSiap
                    ? null
                    : () {
                        if (_fotoBytes == null) {
                          _jepretFoto();
                        } else {
                          setState(() {
                            _fotoBytes = null;
                            _waktuAbsen = null;
                          });
                        }
                      },
                icon: Icon(
                  _fotoBytes == null ? Icons.camera_alt : Icons.refresh,
                ),
                label: Text(
                  _fotoBytes == null ? 'Jepret Foto Absensi' : 'Foto Ulang',
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F2854),
                  foregroundColor: Colors.white,
                ),
                onPressed: _fotoBytes == null
                    ? null
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Presensi kamera berhasil dikirim!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context, true);
                      },
                icon: const Icon(Icons.check_circle),
                label: const Text('Kirim Presensi'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLayarKamera() {
    if (_errorKamera != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            _errorKamera!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    if (_fotoBytes != null) {
      return Image.memory(_fotoBytes!, fit: BoxFit.cover);
    }
    if (_kameraSiap && _controller != null) {
      return CameraPreview(_controller!);
    }
    return const Center(
      child: CircularProgressIndicator(color: Colors.white),
    );
  }
}