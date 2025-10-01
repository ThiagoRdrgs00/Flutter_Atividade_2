import 'package:aula_2309/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key});

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  final supabase = Supabase.instance.client; // aqui pode usar tranquilo
  List<Map<String, dynamic>> produtos = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchProdutos();
  }

  Future<void> _fetchProdutos() async {
    try {
      final response = await supabase.from('produto').select('*');
      setState(() {
        produtos = List<Map<String, dynamic>>.from(response);
        loading = false;
      });
    } catch (e) {
      print('Erro ao buscar produtos: $e');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Produtos"),
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
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                final p = produtos[index];
                return ListTile(
                  title: Text(p['nome']),
                  subtitle: Text(p['descricao'] ?? ''),
                  trailing: Text("R\$ ${p['preco']}"),
                );
              },
            ),
    );
  }
}
