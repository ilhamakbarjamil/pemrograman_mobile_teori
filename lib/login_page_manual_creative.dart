import 'package:flutter/material.dart';

class LoginPageManualCreative extends StatefulWidget {
  const LoginPageManualCreative({super.key});

  @override
  State<LoginPageManualCreative> createState() => _LoginPageManualCreativeState();
}

class _LoginPageManualCreativeState extends State<LoginPageManualCreative>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  // State untuk toggle visibilitas password
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      // Simulasi delay login
      Future.delayed(const Duration(seconds: 1), () {
        if (email == 'user@example.com' && password == 'password123') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Berhasil! Redirecting...')),
          );
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Email atau Password salah.',
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.redAccent),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      body: Container(
        // Background Gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF42A5F5), // Biru terang
              Color(0xFF673AB7), // Ungu
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                // Logo yang lebih besar dan terpusat
                Image.asset(
                  'assets/logo.png', // Pastikan path ini benar
                  height: screenHeight * 0.2,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.04),
                // Card untuk Formulir Login
                Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.04),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: screenWidth > 600 ? 450 : screenWidth * 0.9,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // Agar column tidak memakan seluruh tinggi Card
                          children: [
                            Text(
                              'Selamat Datang Kembali!',
                              style: TextStyle(
                                fontSize: screenWidth * 0.065,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF673AB7), // Ungu tua
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              'Silakan masuk untuk melanjutkan',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'nama@example.com',
                                labelStyle:
                                    const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.blueGrey[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide.none, // Hilangkan border default
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 2),
                                ),
                                prefixIcon: const Icon(Icons.email,
                                    color: Color(0xFF42A5F5)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Format email tidak valid';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible, // Menggunakan state
                              style: const TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Min. 6 Karakter',
                                labelStyle:
                                    const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.blueGrey[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 2),
                                ),
                                prefixIcon: const Icon(Icons.lock,
                                    color: Color(0xFF673AB7)),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                if (value.length < 6) {
                                  return 'Password minimal 6 karakter';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            ScaleTransition(
                              scale: _scaleAnimation,
                              child: GestureDetector(
                                onTapDown: (_) => _animationController.forward(),
                                onTapUp: (_) {
                                  _animationController.reverse();
                                  _login();
                                },
                                onTapCancel: () => _animationController.reverse(),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF42A5F5), // Biru terang
                                        Color(0xFF673AB7), // Ungu
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0), // Tombol kapsul
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF673AB7)
                                            .withOpacity(0.4),
                                        blurRadius: 15,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    'LOGIN',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.048,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            TextButton(
                              onPressed: () {
                                // TODO: Implement forgot password logic
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Lupa password? Fitur belum tersedia.'),
                                      backgroundColor: Colors.orange),
                                );
                              },
                              child: Text(
                                'Lupa Password?',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}