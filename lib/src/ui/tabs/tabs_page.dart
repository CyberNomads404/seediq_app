import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seediq_app/src/core/themes/app_colors.dart';

import 'screens/home_page.dart';
import 'screens/history_page.dart';
import 'screens/profile_page.dart';

class TabsPage extends ConsumerStatefulWidget {
  const TabsPage({super.key});

  @override
  ConsumerState<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends ConsumerState<TabsPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: 'Início',
                ),
                _buildNavItem(
                  index: 1,
                  icon: Icons.history_outlined,
                  activeIcon: Icons.history,
                  label: 'Histórico',
                ),
                _buildNavItem(
                  index: 2,
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: 'Perfil',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isSelected = _currentIndex == index;
    
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _currentIndex = index),
        splashColor: AppColors.greenDark.withOpacity(0.1),
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: 3,
              width: isSelected ? 40 : 0,
              decoration: BoxDecoration(
                color: AppColors.greenDark,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 8),

            AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? AppColors.greenDark : Colors.grey[600],
                size: 24,
              ),
            ),
            const SizedBox(height: 4),

            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.greenDark : Colors.grey[600],
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}