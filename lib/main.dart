import 'package:flutter/material.dart';

void main() {
  runApp(const ControlMoneyApp());
}

class ControlMoneyApp extends StatelessWidget {
  const ControlMoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Money',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF167DFF)),
        fontFamily: 'Noto Sans',
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final entries = _sampleEntries
        .where((entry) => isSameDay(entry.date, today))
        .toList();
    final incomeTotal = entries
        .where((entry) => entry.type == EntryType.income)
        .fold<int>(0, (sum, entry) => sum + entry.amount);
    final expenseTotal = entries
        .where((entry) => entry.type == EntryType.expense)
        .fold<int>(0, (sum, entry) => sum + entry.amount);

    return Scaffold(
      backgroundColor: const Color(0xFF0B5CC5),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        elevation: 6,
        child: const Icon(Icons.edit, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const _BottomNavBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF4EA6FF),
                    Color(0xFF1368D3),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    'Control Money',
                    style: const TextStyle(
                      fontFamily: 'PoetsenOne',
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hari ini',
                        style: const TextStyle(
                          fontFamily: 'Noto Sans',
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        formatIndonesianDate(DateTime.now()),
                        style: const TextStyle(
                          fontFamily: 'Noto Sans',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: _SummaryCard(
                          title: 'Pemasukan',
                          amount: incomeTotal,
                          backgroundColor: const Color(0xFF35E05D),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _SummaryCard(
                          title: 'Pengeluaran',
                          amount: expenseTotal,
                          backgroundColor: const Color(0xFFFF5A58),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 24,
                      bottom: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.black12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      itemCount: entries.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final entry = entries[index];
                        return _EntryTile(entry: entry);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.backgroundColor,
  });

  final String title;
  final int amount;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Noto Sans',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            formatRupiah(amount),
            style: const TextStyle(
              fontFamily: 'Noto Sans',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _EntryTile extends StatelessWidget {
  const _EntryTile({required this.entry});

  final Entry entry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.title,
                    style: const TextStyle(
                      fontFamily: 'Noto Sans',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.category,
                    style: const TextStyle(
                      fontFamily: 'Noto Sans',
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              formatRupiah(entry.amount),
              style: const TextStyle(
                fontFamily: 'Noto Sans',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 4,
          decoration: BoxDecoration(
            color: entry.accentColor,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ],
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _NavItem(
            icon: Icons.savings,
            label: 'Saving',
            isActive: false,
          ),
          _NavItem(
            icon: Icons.insert_chart_outlined,
            label: 'Report',
            isActive: false,
          ),
          _NavItem(
            icon: Icons.home_filled,
            label: 'Home',
            isActive: true,
          ),
          _NavItem(
            icon: Icons.analytics_outlined,
            label: 'Analyst',
            isActive: false,
          ),
          _NavItem(
            icon: Icons.settings,
            label: 'Settings',
            isActive: false,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  final IconData icon;
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? Colors.black : Colors.black45;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Noto Sans',
            color: color,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

String formatIndonesianDate(DateTime date) {
  const weekdays = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];
  const months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];
  final weekday = weekdays[date.weekday - 1];
  final month = months[date.month - 1];
  final day = date.day.toString().padLeft(2, '0');
  return '$weekday, $day $month ${date.year}';
}

String formatRupiah(int amount) {
  final value = amount.abs().toString();
  final formatted = value.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]}.',
  );
  return 'Rp $formatted';
}

enum EntryType { income, expense }

class Entry {
  Entry({
    required this.title,
    required this.category,
    required this.amount,
    required this.type,
    required this.accentColor,
    required this.date,
  });

  final String title;
  final String category;
  final int amount;
  final EntryType type;
  final Color accentColor;
  final DateTime date;
}

final List<Entry> _sampleEntries = [
  Entry(
    title: 'Snack',
    category: 'Belanja',
    amount: 30000,
    type: EntryType.expense,
    accentColor: const Color(0xFFFF9C3F),
    date: DateTime.now(),
  ),
  Entry(
    title: 'Gaji',
    category: 'Pemasukan',
    amount: 250000,
    type: EntryType.income,
    accentColor: const Color(0xFF35E05D),
    date: DateTime.now(),
  ),
  Entry(
    title: 'Parkir',
    category: 'Lainnya',
    amount: 2000,
    type: EntryType.expense,
    accentColor: const Color(0xFFB05CC6),
    date: DateTime.now(),
  ),
  Entry(
    title: 'Mie Ayam',
    category: 'Makanan',
    amount: 11000,
    type: EntryType.expense,
    accentColor: const Color(0xFFFF5A58),
    date: DateTime.now(),
  ),
  Entry(
    title: 'Parkir',
    category: 'Lainnya',
    amount: 2000,
    type: EntryType.expense,
    accentColor: const Color(0xFFB05CC6),
    date: DateTime.now(),
  ),
  Entry(
    title: 'Bensin',
    category: 'Transportasi',
    amount: 25000,
    type: EntryType.expense,
    accentColor: const Color(0xFFFF5A58),
    date: DateTime.now(),
  ),
  Entry(
    title: 'Laundry Sepatu',
    category: 'Lainnya',
    amount: 10000,
    type: EntryType.expense,
    accentColor: const Color(0xFFB05CC6),
    date: DateTime.now(),
  ),
  Entry(
    title: 'Parkir',
    category: 'Lainnya',
    amount: 2000,
    type: EntryType.expense,
    accentColor: const Color(0xFFB05CC6),
    date: DateTime.now(),
  ),
  Entry(
    title: 'Es Teh Jumbo',
    category: 'Makanan',
    amount: 3000,
    type: EntryType.expense,
    accentColor: const Color(0xFFFF5A58),
    date: DateTime.now(),
  ),
];

bool isSameDay(DateTime first, DateTime second) {
  return first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}
