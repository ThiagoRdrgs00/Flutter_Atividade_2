import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final supabase = Supabase.instance.client;
  List<dynamic> produtos = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  Future<void> carregarProdutos() async {
    setState(() => loading = true);

    try {
      final response = await supabase
          .from('produto')
          .select()
          .order('id', ascending: true);
      
      print(response);
      print("teste");

      setState(() {
        produtos = response;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      print("Erro ao carregar: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Produtos'),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: carregarProdutos,
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: produtos.length,
                itemBuilder: (context, index) {
                  final item = produtos[index];

                  return Card(
                    child: ListTile(
                      title: Text(item['nome']),
                      subtitle: Text("Valor: R\$ ${item['valor']}"),
                      leading: CircleAvatar(
                        child: Text(item['id'].toString()),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}