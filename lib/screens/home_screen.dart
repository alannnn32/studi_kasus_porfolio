import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../l10n/app_strings.dart';
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

  // Kunci terjemahan judul & subjudul AppBar tiap tab.
  static const _titleKeys = [
    ['t_home_title', 't_home_sub'],
    ['t_profile_title', 't_profile_sub'],
    ['t_portfolio_title', 't_portfolio_sub'],
    ['t_polije_title', 't_polije_sub'],
    ['t_settings_title', 't_settings_sub'],
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
        title: context.tr(_titleKeys[_tab][0]),
        subtitle: context.tr(_titleKeys[_tab][1]),
      ),
      drawer: _buildDrawer(),
      body: IndexedStack(index: _tab, children: pages),
      floatingActionButton: _tab == 2
          ? FloatingActionButton.extended(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              onPressed: _add,
              icon: const Icon(Icons.add),
              label: Text(context.tr('fab_add')),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        backgroundColor: AppColors.card(context),
        indicatorColor: AppColors.primary.withAlpha(40),
        selectedIndex: _tab,
        onDestinationSelected: _goTo,
        destinations: [
          NavigationDestination(
              icon: const Icon(Icons.home), label: context.tr('nav_home')),
          NavigationDestination(
              icon: const Icon(Icons.person), label: context.tr('nav_profile')),
          NavigationDestination(
              icon: const Icon(Icons.work), label: context.tr('nav_portfolio')),
          NavigationDestination(
              icon: const Icon(Icons.school), label: context.tr('nav_polije')),
          NavigationDestination(
              icon: const Icon(Icons.settings),
              label: context.tr('nav_settings')),
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
        selectedTileColor: AppColors.primary.withAlpha(30),
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
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(ProfileData.photo),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(ProfileData.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      Text('${context.tr('nim')}: ${ProfileData.nim}',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          item(Icons.home, context.tr('drawer_home'), () => _goTo(0),
              selected: _tab == 0),
          item(Icons.person, context.tr('drawer_profile'), () => _goTo(1),
              selected: _tab == 1),
          item(Icons.work, context.tr('drawer_portfolio'), () => _goTo(2),
              selected: _tab == 2),
          item(Icons.add_circle, context.tr('drawer_add'), _add),
          item(Icons.school, context.tr('drawer_polije'), () => _goTo(3),
              selected: _tab == 3),
          item(Icons.settings, context.tr('drawer_settings'), () => _goTo(4),
              selected: _tab == 4),
        ],
      ),
    );
  }
}