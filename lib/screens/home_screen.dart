import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../widgets/gradient_app_bar.dart';
import 'beranda_page.dart';
import 'polije_page.dart';
import 'portfolio_page.dart';
import 'profile_page.dart';
import 'project_form_page.dart';
import 'settings_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  static const _titles = [
    ['My Portfolio', 'Build • Learn • Create'],
    ['Profil Saya', 'Identitas & kontak'],
    ['Portofolio / Karya', 'Kelola karya (CRUD)'],
    ['Tentang POLIJE', 'Politeknik Negeri Jember'],
    ['Pengaturan', 'Data & aplikasi'],
  ];

  void _goTo(int i) => setState(() => _tab = i);
  void _add() => openProjectForm(context);

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      BerandaPage(onNavigate: _goTo, onAdd: _add),
      const ProfilePage(),
      const PortfolioPage(),
      const PolijePage(),
      const SettingsPage(),
    ];

    return Scaffold(
      appBar: GradientAppBar(
        title: _titles[_tab][0],
        subtitle: _titles[_tab][1],
      ),
      drawer: _buildDrawer(),
      body: IndexedStack(index: _tab, children: pages),
      floatingActionButton: _tab == 2
          ? FloatingActionButton.extended(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              onPressed: _add,
              icon: const Icon(Icons.add),
              label: const Text('Tambah'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.primary.withAlpha(30),
        selectedIndex: _tab,
        onDestinationSelected: _goTo,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
          NavigationDestination(icon: Icon(Icons.work), label: 'Portofolio'),
          NavigationDestination(icon: Icon(Icons.school), label: 'POLIJE'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Pengaturan'),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    Widget item(IconData icon, String label, VoidCallback onTap,
        {bool selected = false}) {
      return ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(label),
        selected: selected,
        selectedTileColor: AppColors.primary.withAlpha(20),
        onTap: () {
          Navigator.pop(context); // tutup drawer
          onTap();
        },
      );
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                16, MediaQuery.of(context).padding.top + 16, 16, 16),
            decoration:
                const BoxDecoration(gradient: AppColors.headerGradient),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  backgroundImage: const AssetImage(ProfileData.photo),
                  onBackgroundImageError: (_, __) {},
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ProfileData.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      Text('NIM: ${ProfileData.nim}',
                          style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          item(Icons.home, 'Beranda', () => _goTo(0), selected: _tab == 0),
          item(Icons.person, 'Profil Saya', () => _goTo(1), selected: _tab == 1),
          item(Icons.work, 'Portofolio / Karya', () => _goTo(2),
              selected: _tab == 2),
          item(Icons.add_circle, 'Tambah Portofolio', _add),
          item(Icons.school, 'Tentang POLIJE', () => _goTo(3),
              selected: _tab == 3),
          item(Icons.settings, 'Pengaturan', () => _goTo(4),
              selected: _tab == 4),
        ],
      ),
    );
  }
}