import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class FluxoPage extends StatelessWidget {
  const FluxoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diagrama de Fluxo de Dados"),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            border: TableBorder.all(color: Colors.grey),
            columns: const [
              DataColumn( 
                label: Text(
                  "Entidade Externa",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  "Processo",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  "Armazenamento de Dados",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  "Fluxo de Dados",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text("Usuário")),
                DataCell(Text("Tela de Cadastro/Login")),
                DataCell(Text("Credenciais temporárias")),
                DataCell(Text("Nome, E-mail, Senha")),
              ]),
              DataRow(cells: [
                DataCell(Text("Usuário")),
                DataCell(Text("Tela de Configurações")),
                DataCell(Text("SharedPreferences / Secure Storage")),
                DataCell(Text("Preferências, Tokens")),
              ]),
              DataRow(cells: [
                DataCell(Text("Usuário")),
                DataCell(Text("Gerenciamento de Dados")),
                DataCell(Text("SQLite ou Firestore")),
                DataCell(Text("Dados estruturados, registros")),
              ]),
              DataRow(cells: [
                DataCell(Text("Firebase")),
                DataCell(Text("Sincronização em tempo real")),
                DataCell(Text("Nuvem (Firestore)")),
                DataCell(Text("Envio/Recebimento de dados")),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
