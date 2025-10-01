import 'package:aula_2309/Atividade_3/database_helper.dart';
import 'package:aula_2309/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'listarUsuarios.dart'; // Adicione este import

class CadastroPage3 extends StatefulWidget {
  const CadastroPage3({super.key});

  @override
  State<CadastroPage3> createState() => _CadastroPage3State();
}

class _CadastroPage3State extends State<CadastroPage3> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  Future<void> cadastrar() async {
    final nome = nomeController.text.trim();
    final email = emailController.text.trim();
    final senha = senhaController.text;

    if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('Erro'),
          content: Text('Por favor, preencha todos os campos.'),
        ),
      );
      return;
    }

    // Salva email, senha e nome no SQLite
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.insertUser({
      'nome': nome,
      'email': email,
      'senha': senha,
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cadastro realizado'),
        content: Text('Usuário $nome cadastrado com sucesso!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // fecha diálogo
              Navigator.pop(context); // volta para a tela anterior
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void irParaListagem() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ListarUsuariosPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Cadastro'),
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
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
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
            ElevatedButton(
              onPressed: cadastrar,
              child: const Text('Cadastrar'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: irParaListagem,
              child: const Text('Listar Usuários'),
            ),
          ],
        ),
      ),
    );
  }
}