import 'package:aula_2309/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cadastro.dart';
import 'database_helper.dart';

class LoginPage3 extends StatefulWidget {
  const LoginPage3({super.key});

  @override
  State<LoginPage3> createState() => _LoginPage3State();
}

class _LoginPage3State extends State<LoginPage3> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  void fazerLogin() async {
    final email = emailController.text.trim();
    final senha = senhaController.text;

    final dbHelper = DatabaseHelper.instance;
    final user = await dbHelper.getUserByEmailAndSenha(email, senha);

    if (user != null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Login realizado'),
          content: Text('Bem-vindo ${user['nome']}!'),
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
      MaterialPageRoute(builder: (_) => const CadastroPage3()),
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
