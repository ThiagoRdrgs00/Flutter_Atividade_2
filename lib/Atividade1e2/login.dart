import 'package:aula_2309/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cadastro.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void fazerLogin() async {
    final email = emailController.text;
    final senha = senhaController.text;

    final prefs = await SharedPreferences.getInstance();
    final emailSalvo = prefs.getString('email');
    final senhaSalva = prefs.getString('senha');
    final usuarioSalvo = prefs.getString('usuario');

    if (email == emailSalvo && senha == senhaSalva) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Login realizado'),
          content: Text('Bem-vindo $usuarioSalvo!'),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('Erro'),
          content: Text('E-mail ou senha incorretos.'),
        ),
      );
    }
    senhaController.text = '';
    setState(() {});
  }

  void irParaCadastro() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CadastroPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Login'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: fazerLogin,
                  child: const Text('Entrar'),
                ),
                ElevatedButton(
                  onPressed: irParaCadastro,
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
