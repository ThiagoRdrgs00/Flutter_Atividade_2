import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themeprovider.dart';

class ComparacaoPage extends StatelessWidget {
  const ComparacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comparação de Tecnologias"),
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
        scrollDirection: Axis.horizontal, // permite rolagem horizontal
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical, // permite rolagem vertical
          child: DataTable(
            border: TableBorder.all(color: Colors.grey),
            columns: const [
              DataColumn(label: Text("Tecnologia", style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text("Criptografado", style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text("Offline", style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text("Nuvem", style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text("Complexidade", style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text("Indicado para", style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text("SharedPreferences")),
                DataCell(Text("❌")),
                DataCell(Text("✅")),
                DataCell(Text("❌")),
                DataCell(Text("Baixa")),
                DataCell(Text("Configurações simples")),
              ]),
              DataRow(cells: [
                DataCell(Text("Secure Storage")),
                DataCell(Text("✅")),
                DataCell(Text("✅")),
                DataCell(Text("❌")),
                DataCell(Text("Média")),
                DataCell(Text("Tokens, senhas")),
              ]),
              DataRow(cells: [
                DataCell(Text("SQLite")),
                DataCell(Text("❌")),
                DataCell(Text("✅")),
                DataCell(Text("❌")),
                DataCell(Text("Alta")),
                DataCell(Text("Dados estruturados, relacionamentos")),
              ]),
              DataRow(cells: [
                DataCell(Text("Firebase Firestore")),
                DataCell(Text("❌ (padrão)")),
                DataCell(Text("❌*")),
                DataCell(Text("✅")),
                DataCell(Text("Baixa")),
                DataCell(Text("Sincronização em tempo real")),
              ]),
              DataRow(cells: [
                DataCell(Text("Supabase")),
                DataCell(Text("❌ (padrão)")),
                DataCell(Text("❌*")),
                DataCell(Text("✅")),
                DataCell(Text("Média/Alta")),
                DataCell(Text("Apps com dados relacionais e API REST")),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}