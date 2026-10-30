import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const LoopixApp());
}

// ================= GLASS WAVE COLORS =================

const Color navy = Color(0xFF061632);
const Color deepBlue = Color(0xFF0B2D63);
const Color blue = Color(0xFF1769E8);
const Color cyan = Color(0xFF00E5FF);
const Color violet = Color(0xFF7C3AED);
const Color lavender = Color(0xFFB9C8FF);
const Color lineWhite = Color(0x55B9D9FF);

// ================= APP THEME =================

ThemeData loopixTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: navy,
    colorScheme: ColorScheme.fromSeed(
      seedColor: violet,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: navy,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.5,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.08),
      labelStyle: const TextStyle(color: lavender),
      hintStyle: const TextStyle(color: Colors.white54),
      prefixIconColor: cyan,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: lineWhite),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: lineWhite),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: cyan, width: 1.5),
      ),
    ),
  );
}

// ================= MAIN APP =================

class LoopixApp extends StatelessWidget {
  const LoopixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOOPIX',
      theme: loopixTheme(),
      home: const LoginPage(),
    );
  }
}

// ================= LX MONOGRAM LOGO =================

class LXLogo extends StatelessWidget {
  final double size;
  final bool withGlow;

  const LXLogo({super.key, this.size = 72, this.withGlow = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.27),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF173F9B), Color(0xFF091B42), Color(0xFF3B167F)],
        ),
        border: Border.all(color: const Color(0x8876DFFF), width: 1.3),
        boxShadow: withGlow
            ? [
                BoxShadow(color: cyan.withOpacity(0.2), blurRadius: 22),
                BoxShadow(
                  color: violet.withOpacity(0.25),
                  blurRadius: 24,
                  offset: const Offset(4, 5),
                ),
              ]
            : [],
      ),
      child: Center(
        child: ShaderMask(
          shaderCallback: (bounds) {
            return const LinearGradient(
              colors: [Color(0xFF00E5FF), Color(0xFF72A7FF), Color(0xFFB15CFF)],
            ).createShader(bounds);
          },
          child: Text(
            'LX',
            style: TextStyle(
              color: Colors.white,
              fontSize: size * 0.48,
              fontWeight: FontWeight.w900,
              letterSpacing: -size * 0.055,
            ),
          ),
        ),
      ),
    );
  }
}

// ================= WAVE BACKGROUND =================

class WaveBackground extends StatelessWidget {
  final Widget child;
  final bool showWaves;

  const WaveBackground({super.key, required this.child, this.showWaves = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF061632), Color(0xFF0B3476), Color(0xFF17134B)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -110,
            left: -70,
            child: _GlowCircle(size: 260, color: cyan.withOpacity(0.22)),
          ),
          Positioned(
            top: 170,
            right: -110,
            child: _GlowCircle(size: 300, color: violet.withOpacity(0.30)),
          ),
          Positioned(
            bottom: -150,
            left: 30,
            child: _GlowCircle(size: 320, color: blue.withOpacity(0.24)),
          ),
          if (showWaves)
            Positioned.fill(
              child: IgnorePointer(child: CustomPaint(painter: WavePainter())),
            ),
          child,
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withOpacity(0)]),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * 0.30)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.18,
        size.width * 0.40,
        size.height * 0.48,
        size.width * 0.63,
        size.height * 0.34,
      )
      ..cubicTo(
        size.width * 0.80,
        size.height * 0.23,
        size.width * 0.90,
        size.height * 0.43,
        size.width,
        size.height * 0.29,
      )
      ..lineTo(size.width, size.height * 0.47)
      ..cubicTo(
        size.width * 0.75,
        size.height * 0.58,
        size.width * 0.45,
        size.height * 0.42,
        size.width * 0.25,
        size.height * 0.52,
      )
      ..cubicTo(
        size.width * 0.12,
        size.height * 0.58,
        size.width * 0.08,
        size.height * 0.43,
        0,
        size.height * 0.48,
      )
      ..close();

    canvas.drawPath(
      path,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0x4425D9FF), Color(0x447C3AED), Color(0x2225D9FF)],
        ).createShader(Offset.zero & size),
    );

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.3
        ..color = const Color(0x777DDFFF),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ================= GLASS PANEL =================

class GlassPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;

  const GlassPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.075),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: lineWhite),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ================= GRADIENT BUTTON =================

Widget gradientButton({
  required String text,
  required VoidCallback onPressed,
  required IconData icon,
}) {
  return SizedBox(
    width: double.infinity,
    height: 54,
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF1976F3), Color(0xFF6845E8)],
        ),
        boxShadow: [
          BoxShadow(
            color: blue.withOpacity(0.22),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0x777ADFFF)),
          ),
        ),
      ),
    ),
  );
}

void showAppMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

// ================= LOGIN PAGE =================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signIn() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || !email.endsWith('@gmail.com')) {
      showAppMessage(context, 'Please enter a valid Gmail address.');
      return;
    }

    if (password.isEmpty) {
      showAppMessage(context, 'Please enter your password.');
      return;
    }

    // Demo navigation only. Real account authentication is not configured.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaveBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    const Center(child: LXLogo(size: 92)),
                    const SizedBox(height: 18),
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          colors: [
                            Colors.white,
                            Color(0xFF8BEAFF),
                            Color(0xFFC7A5FF),
                          ],
                        ).createShader(bounds);
                      },
                      child: const Text(
                        'LOOPIX',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Your People. Your Loop.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: lavender, fontSize: 15),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Welcome to LOOPIX',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sign in to continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 25),
                    GlassPanel(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              labelText: 'Gmail address',
                              hintText: 'Enter your Gmail address',
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: passwordController,
                            obscureText: obscurePassword,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => signIn(),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline),
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 22),
                          gradientButton(
                            text: 'Sign In',
                            icon: Icons.login_rounded,
                            onPressed: signIn,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Connect  •  Chat  •  Share',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: lavender, letterSpacing: 1.1),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'By continuing, you agree to the app terms and privacy policy.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= HOME PAGE =================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<String> names = [
    'Arun',
    'Vignesh',
    'Karthik',
    'Murali',
    'Priya',
    'Sanjay',
  ];

  final List<String> messages = [
    'Hi macha!',
    'Enna panra?',
    'Tomorrow college varuviya?',
    'Call me when free.',
    'Good morning!',
    'Super da!',
  ];

  final List<String> times = [
    '10:30 AM',
    '10:15 AM',
    'Yesterday',
    'Yesterday',
    'Monday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      buildChats(),
      const ClipsPage(),
      const GamesPage(),
      buildCalls(),
    ];

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LXLogo(size: 32, withGlow: false),
            const SizedBox(width: 9),
            const Text('LOOPIX'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              showAppMessage(context, 'Search coming soon!');
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              } else if (value == 'settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              } else if (value == 'logout') {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'profile', child: Text('Profile')),
              PopupMenuItem(value: 'settings', child: Text('Settings')),
              PopupMenuItem(value: 'logout', child: Text('Log out')),
            ],
          ),
        ],
      ),
      body: WaveBackground(
        showWaves: false,
        child: IndexedStack(index: selectedIndex, children: pages),
      ),
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              foregroundColor: Colors.white,
              onPressed: () {
                showAppMessage(context, 'New chat coming soon!');
              },
              child: const Icon(Icons.chat_bubble_rounded),
            )
          : null,
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(12, 0, 12, 8),
        child: GlassPanel(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
          radius: 24,
          child: Row(
            children: [
              _NavItem(
                icon: Icons.chat_bubble_outline_rounded,
                label: 'Chats',
                selected: selectedIndex == 0,
                onTap: () => setState(() => selectedIndex = 0),
              ),
              _NavItem(
                icon: Icons.movie_outlined,
                label: 'Clips',
                selected: selectedIndex == 1,
                onTap: () => setState(() => selectedIndex = 1),
              ),
              _NavItem(
                icon: Icons.sports_esports_outlined,
                label: 'Games',
                selected: selectedIndex == 2,
                onTap: () => setState(() => selectedIndex = 2),
              ),
              _NavItem(
                icon: Icons.call_outlined,
                label: 'Calls',
                selected: selectedIndex == 3,
                onTap: () => setState(() => selectedIndex = 3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChats() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 100),
      children: [
        GlassPanel(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
          radius: 18,
          child: const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search_rounded),
              hintText: 'Search chats...',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              fillColor: Colors.transparent,
            ),
          ),
        ),
        const SizedBox(height: 14),
        for (int i = 0; i < names.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: GlassPanel(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
              radius: 19,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: _Avatar(name: names[i], index: i),
                title: Text(
                  names[i],
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    messages[i],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: lavender),
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      times[i],
                      style: const TextStyle(fontSize: 10, color: lavender),
                    ),
                    const SizedBox(height: 7),
                    if (i < 2)
                      const CircleAvatar(
                        radius: 4,
                        backgroundColor: Color(0xFF36E6A0),
                      )
                    else if (i == 2 || i == 3)
                      const Icon(Icons.done_all, size: 16, color: cyan),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ChatPage(name: names[i])),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  Widget buildCalls() {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Recent calls',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
          ),
        ),
        for (int i = 0; i < names.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: GlassPanel(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              child: ListTile(
                leading: _Avatar(name: names[i], index: i),
                title: Text(names[i]),
                subtitle: const Text(
                  'Tap to call',
                  style: TextStyle(color: lavender),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.call_rounded, color: cyan),
                  onPressed: () {
                    showAppMessage(context, 'Calling ${names[i]}...');
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ================= BOTTOM NAVIGATION =================

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: selected
                      ? const LinearGradient(colors: [blue, violet])
                      : null,
                ),
                child: Icon(
                  icon,
                  color: selected ? Colors.white : lavender,
                  size: 22,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: selected ? Colors.white : lavender,
                  fontWeight: selected ? FontWeight.w800 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= AVATAR =================

class _Avatar extends StatelessWidget {
  final String name;
  final int index;

  const _Avatar({required this.name, required this.index});

  @override
  Widget build(BuildContext context) {
    const gradients = [
      [Color(0xFF00C6FF), Color(0xFF7C3AED)],
      [Color(0xFF6A7BFF), Color(0xFF00D4FF)],
      [Color(0xFF7C3AED), Color(0xFF3B82F6)],
      [Color(0xFF00B4D8), Color(0xFF4361EE)],
    ];

    final colors = gradients[index % gradients.length];

    return Container(
      width: 49,
      height: 49,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: colors),
        border: Border.all(color: const Color(0x887DEBFF)),
      ),
      child: Center(
        child: Text(
          name[0],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

// ================= CLIPS PAGE =================

class ClipsPage extends StatelessWidget {
  const ClipsPage({super.key});

  static const String clipImage =
      'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=900&q=85';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 110),
      children: [
        const Text(
          'LOOPIX Clips',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 5),
        const Text('Photos and moments', style: TextStyle(color: lavender)),
        const SizedBox(height: 16),
        GlassPanel(
          padding: EdgeInsets.zero,
          radius: 24,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  clipImage,
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      height: 280,
                      color: deepBlue,
                      child: const Center(
                        child: Icon(Icons.image_not_supported, size: 60),
                      ),
                    );
                  },
                ),
                const ListTile(
                  leading: LXLogo(size: 42, withGlow: false),
                  title: Text(
                    'LOOPIX Clips',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  subtitle: Text(
                    'Featured image',
                    style: TextStyle(color: lavender),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 12, 12),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Color(0xFFFF82B2),
                        ),
                        onPressed: () {
                          showAppMessage(context, 'Liked!');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.share_outlined, color: cyan),
                        onPressed: () {
                          showAppMessage(context, 'Share coming soon!');
                        },
                      ),
                      const Spacer(),
                      const Text(
                        'Photo Clip',
                        style: TextStyle(color: lavender),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Center(
          child: Text(
            'More clips coming soon!',
            style: TextStyle(color: lavender),
          ),
        ),
      ],
    );
  }
}

// ================= CHAT PAGE =================

class ChatPage extends StatefulWidget {
  final String name;

  const ChatPage({super.key, required this.name});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  final List<String> sentMessages = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void sendMessage() {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      sentMessages.add(text);
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const LXLogo(size: 30, withGlow: false),
            const SizedBox(width: 9),
            Expanded(child: Text(widget.name, overflow: TextOverflow.ellipsis)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call_rounded),
            onPressed: () {
              showAppMessage(context, 'Calling ${widget.name}...');
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam_rounded),
            onPressed: () {
              showAppMessage(context, 'Video call coming soon!');
            },
          ),
        ],
      ),
      body: WaveBackground(
        showWaves: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'TODAY',
                        style: TextStyle(
                          color: lavender,
                          fontSize: 11,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: ChatBubble(
                      text: 'Hi! Welcome to LOOPIX.',
                      isSent: false,
                    ),
                  ),
                  for (final message in sentMessages)
                    Align(
                      alignment: Alignment.centerRight,
                      child: ChatBubble(text: message, isSent: true),
                    ),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Message...',
                          prefixIcon: Icon(Icons.add_circle_outline),
                        ),
                        onSubmitted: (_) => sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [blue, violet]),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                        ),
                        onPressed: sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= CHAT BUBBLE =================

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSent;

  const ChatBubble({super.key, required this.text, required this.isSent});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(13),
      constraints: const BoxConstraints(maxWidth: 290),
      decoration: BoxDecoration(
        gradient: isSent
            ? const LinearGradient(
                colors: [Color(0xFF235FE5), Color(0xFF7146E8)],
              )
            : null,
        color: isSent ? null : Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(17),
          topRight: const Radius.circular(17),
          bottomLeft: Radius.circular(isSent ? 17 : 4),
          bottomRight: Radius.circular(isSent ? 4 : 17),
        ),
        border: Border.all(color: lineWhite),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}

// ================= GAMES PAGE =================

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 110),
      children: [
        const Text(
          'LOOPIX Games',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 8),
        const Text(
          'Play a quick game or challenge yourself.',
          style: TextStyle(color: lavender),
        ),
        const SizedBox(height: 16),
        gameTile(
          context,
          'Rock Paper Scissors',
          Icons.sports_martial_arts,
          const RockPaperScissorsPage(),
        ),
        gameTile(
          context,
          'Number Guess',
          Icons.numbers_rounded,
          const NumberGuessPage(),
        ),
        gameTile(
          context,
          'Quick Quiz',
          Icons.quiz_outlined,
          const QuickQuizPage(),
        ),
        gameTile(
          context,
          'Tic-Tac-Toe',
          Icons.grid_3x3_rounded,
          const TicTacToePage(),
        ),
      ],
    );
  }

  Widget gameTile(
    BuildContext context,
    String title,
    IconData icon,
    Widget page,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassPanel(
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(colors: [blue, violet]),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: cyan,
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => page));
          },
        ),
      ),
    );
  }
}

// ================= ROCK PAPER SCISSORS =================

class RockPaperScissorsPage extends StatefulWidget {
  const RockPaperScissorsPage({super.key});

  @override
  State<RockPaperScissorsPage> createState() => _RockPaperScissorsPageState();
}

class _RockPaperScissorsPageState extends State<RockPaperScissorsPage> {
  final Random random = Random();

  String userChoice = '❔';
  String computerChoice = '❔';
  String result = 'Choose your move!';

  final List<String> choices = ['✊', '✋', '✌️'];

  void play(String choice) {
    final computer = choices[random.nextInt(choices.length)];
    String outcome;

    if (choice == computer) {
      outcome = 'It is a draw!';
    } else if ((choice == '✊' && computer == '✌️') ||
        (choice == '✋' && computer == '✊') ||
        (choice == '✌️' && computer == '✋')) {
      outcome = 'You win!';
    } else {
      outcome = 'Computer wins!';
    }

    setState(() {
      userChoice = choice;
      computerChoice = computer;
      result = outcome;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemedGameScaffold(
      title: 'Rock Paper Scissors',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            result,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 24),
          Text('You: $userChoice', style: const TextStyle(fontSize: 28)),
          Text(
            'Computer: $computerChoice',
            style: const TextStyle(fontSize: 28),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            children: [
              for (final choice in choices)
                ElevatedButton(
                  onPressed: () => play(choice),
                  child: Text(choice, style: const TextStyle(fontSize: 30)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ================= NUMBER GUESS =================

class NumberGuessPage extends StatefulWidget {
  const NumberGuessPage({super.key});

  @override
  State<NumberGuessPage> createState() => _NumberGuessPageState();
}

class _NumberGuessPageState extends State<NumberGuessPage> {
  final Random random = Random();
  final controller = TextEditingController();

  late int target;
  String result = 'Guess a number from 1 to 10';

  @override
  void initState() {
    super.initState();
    target = random.nextInt(10) + 1;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void checkGuess() {
    final guess = int.tryParse(controller.text.trim());

    if (guess == null || guess < 1 || guess > 10) {
      setState(() {
        result = 'Enter a number from 1 to 10';
      });
      return;
    }

    setState(() {
      if (guess == target) {
        result = 'Correct! You win!';
      } else if (guess < target) {
        result = 'Too low! Try again.';
      } else {
        result = 'Too high! Try again.';
      }
    });
  }

  void restart() {
    setState(() {
      target = random.nextInt(10) + 1;
      result = 'Guess a number from 1 to 10';
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemedGameScaffold(
      title: 'Number Guess',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.numbers_rounded, size: 70, color: cyan),
          const SizedBox(height: 20),
          Text(
            result,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Your guess'),
          ),
          const SizedBox(height: 12),
          gradientButton(
            text: 'Check',
            icon: Icons.check_rounded,
            onPressed: checkGuess,
          ),
          TextButton(onPressed: restart, child: const Text('Play Again')),
        ],
      ),
    );
  }
}

// ================= QUICK QUIZ =================

class QuickQuizPage extends StatefulWidget {
  const QuickQuizPage({super.key});

  @override
  State<QuickQuizPage> createState() => _QuickQuizPageState();
}

class _QuickQuizPageState extends State<QuickQuizPage> {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Which language is used with Flutter?',
      'options': ['Java', 'Dart', 'Python', 'C'],
      'answer': 'Dart',
    },
    {
      'question': 'What does CPU stand for?',
      'options': [
        'Central Processing Unit',
        'Computer Personal Unit',
        'Central Program Utility',
        'Control Processing User',
      ],
      'answer': 'Central Processing Unit',
    },
    {
      'question': 'Which company develops Flutter?',
      'options': ['Google', 'Apple', 'Meta', 'Microsoft'],
      'answer': 'Google',
    },
  ];

  int current = 0;
  int score = 0;
  bool answered = false;

  void chooseAnswer(String answer) {
    if (answered) return;

    setState(() {
      answered = true;
      if (answer == questions[current]['answer']) {
        score++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      current++;
      answered = false;
    });
  }

  void restartQuiz() {
    setState(() {
      current = 0;
      score = 0;
      answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final finished = current >= questions.length;

    return ThemedGameScaffold(
      title: 'Quick Quiz',
      child: finished
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.emoji_events_rounded,
                  size: 75,
                  color: Color(0xFFFFD166),
                ),
                const SizedBox(height: 16),
                Text(
                  'Quiz completed!\nScore: $score/${questions.length}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                gradientButton(
                  text: 'Play Again',
                  icon: Icons.refresh_rounded,
                  onPressed: restartQuiz,
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'QUESTION ${current + 1}/${questions.length}',
                  style: const TextStyle(color: cyan, letterSpacing: 1.5),
                ),
                const SizedBox(height: 20),
                Text(
                  questions[current]['question'],
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 20),
                for (final option
                    in questions[current]['options'] as List<String>)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: OutlinedButton(
                      onPressed: () => chooseAnswer(option),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: lineWhite),
                        padding: const EdgeInsets.all(14),
                      ),
                      child: Text(option),
                    ),
                  ),
                if (answered) ...[
                  Text(
                    'Correct answer: ${questions[current]['answer']}',
                    style: const TextStyle(color: cyan),
                  ),
                  const SizedBox(height: 18),
                  gradientButton(
                    text: current == questions.length - 1
                        ? 'Show Result'
                        : 'Next Question',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: nextQuestion,
                  ),
                ],
              ],
            ),
    );
  }
}

// ================= TIC TAC TOE =================

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({super.key});

  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String result = '';

  void playMove(int index) {
    if (board[index].isNotEmpty || result.isNotEmpty) return;

    setState(() {
      board[index] = currentPlayer;

      if (hasWon(currentPlayer)) {
        result = '$currentPlayer wins!';
      } else if (!board.contains('')) {
        result = 'It is a draw!';
      } else {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
    });
  }

  bool hasWon(String player) {
    const combos = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (final c in combos) {
      if (board[c[0]] == player &&
          board[c[1]] == player &&
          board[c[2]] == player) {
        return true;
      }
    }

    return false;
  }

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemedGameScaffold(
      title: 'Tic-Tac-Toe',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            result.isEmpty ? "Player $currentPlayer's turn" : result,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: ElevatedButton(
                    onPressed: () => playMove(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.10),
                      foregroundColor: cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(color: lineWhite),
                      ),
                    ),
                    child: Text(
                      board[index],
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          gradientButton(
            text: 'Restart Game',
            icon: Icons.refresh_rounded,
            onPressed: resetGame,
          ),
        ],
      ),
    );
  }
}

// ================= GAME SCREEN WRAPPER =================

class ThemedGameScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const ThemedGameScaffold({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: WaveBackground(
        showWaves: false,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: GlassPanel(
                child: SizedBox(width: double.infinity, child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= PROFILE PAGE =================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: WaveBackground(
        showWaves: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GlassPanel(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const LXLogo(size: 100),
                  const SizedBox(height: 18),
                  const Text(
                    'LOOPIX User',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Your People. Your Loop.',
                    style: TextStyle(color: lavender),
                  ),
                  const SizedBox(height: 20),
                  gradientButton(
                    text: 'Edit Profile',
                    icon: Icons.edit_rounded,
                    onPressed: () {
                      showAppMessage(context, 'Edit profile coming soon!');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= SETTINGS PAGE =================

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifications = true;
  bool sound = true;
  bool darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: WaveBackground(
        showWaves: false,
        child: ListView(
          padding: const EdgeInsets.all(14),
          children: [
            GlassPanel(
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(
                      Icons.notifications_active_outlined,
                      color: cyan,
                    ),
                    title: const Text('Notifications'),
                    value: notifications,
                    onChanged: (value) {
                      setState(() => notifications = value);
                    },
                  ),
                  const Divider(color: lineWhite),
                  SwitchListTile(
                    secondary: const Icon(
                      Icons.volume_up_outlined,
                      color: cyan,
                    ),
                    title: const Text('Sound'),
                    value: sound,
                    onChanged: (value) {
                      setState(() => sound = value);
                    },
                  ),
                  const Divider(color: lineWhite),
                  SwitchListTile(
                    secondary: const Icon(
                      Icons.dark_mode_outlined,
                      color: cyan,
                    ),
                    title: const Text('Dark Mode'),
                    value: darkMode,
                    onChanged: (value) {
                      setState(() => darkMode = value);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const GlassPanel(
              child: ListTile(
                leading: LXLogo(size: 42, withGlow: false),
                title: Text(
                  'About LOOPIX',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: Text(
                  'Version 1.0.0 • Your People. Your Loop.',
                  style: TextStyle(color: lavender),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
