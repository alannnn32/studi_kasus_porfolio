import 'package:flutter/material.dart';

import '../widgets/about_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/page_scroll.dart';
import '../widgets/profile_header.dart';
import '../widgets/tech_dropdown.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _selectedTech;

  @override
  Widget build(BuildContext context) {
    return PageScroll(
      children: [
        const ProfileHeader(),
        const AboutSection(),
        TechDropdown(
          selected: _selectedTech,
          onChanged: (v) => setState(() => _selectedTech = v),
        ),
        const ContactSection(),
        const SizedBox(height: 24),
      ],
    );
  }
}