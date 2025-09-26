import 'package:flutter/material.dart';

class DashboardPageAI extends StatelessWidget {
  const DashboardPageAI({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF673AB7), // Ungu
              Color(0xFF42A5F5), // Biru terang
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: screenHeight * 0.25, // Tinggi app bar saat expanded
              floating: false,
              pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: EdgeInsets.only(bottom: isLargeScreen ? 20 : 16, top: isLargeScreen ? 0 : 20),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (!isLargeScreen) // Tampilkan avatar hanya di layar kecil saat app bar menyusut
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Color(0xFF673AB7)),
                      ),
                    if (!isLargeScreen) const SizedBox(height: 8),
                    Text(
                      'Selamat Datang di Dashboard!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isLargeScreen ? 28 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (!isLargeScreen)
                      Text(
                        'User Name', // Ganti dengan nama pengguna aktual
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: isLargeScreen ? 18 : 14,
                        ),
                      ),
                  ],
                ),
                background: Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Color(0xFF673AB7),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Halo, User Name!', // Ganti dengan nama pengguna aktual
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isLargeScreen ? 32 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Siap untuk hari yang produktif?',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: isLargeScreen ? 18 : 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(isLargeScreen ? 20.0 : 16.0),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isLargeScreen ? 3 : 2, // 3 kolom di layar besar, 2 di layar kecil
                  crossAxisSpacing: isLargeScreen ? 20 : 16,
                  mainAxisSpacing: isLargeScreen ? 20 : 16,
                  childAspectRatio: 1.0, // Rasio aspek 1:1 untuk kartu
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final List<Map<String, dynamic>> items = [
                      {'icon': Icons.analytics, 'title': 'Analitik'},
                      {'icon': Icons.notifications, 'title': 'Notifikasi'},
                      {'icon': Icons.settings, 'title': 'Pengaturan'},
                      {'icon': Icons.folder, 'title': 'Proyek Saya'},
                      {'icon': Icons.message, 'title': 'Pesan'},
                      {'icon': Icons.help_outline, 'title': 'Bantuan'},
                    ];
                    final item = items[index];
                    return DashboardCard(
                      icon: item['icon'],
                      title: item['title'],
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Anda menekan ${item['title']}')),
                        );
                        // TODO: Implement navigation for each card
                      },
                    );
                  },
                  childCount: 6,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isLargeScreen ? 20.0 : 16.0,
                    vertical: isLargeScreen ? 30.0 : 20.0),
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/'); // Kembali ke halaman login
                    },
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text('Logout',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: isLargeScreen ? 40 : 30,
                          vertical: isLargeScreen ? 15 : 12),
                      elevation: 10,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}