import 'package:flutter/material.dart';
import 'database_helper.dart';

class ListarUsuariosPage extends StatefulWidget {
  const ListarUsuariosPage({super.key});

  @override
  State<ListarUsuariosPage> createState() => _ListarUsuariosPageState();
}

class _ListarUsuariosPageState extends State<ListarUsuariosPage> {
  List<Map<String, dynamic>> usuarios = [];

  @override
  void initState() {
    super.initState();
    carregarUsuarios();
  }

  Future<void> carregarUsuarios() async {
    final dbHelper = DatabaseHelper.instance;
    final lista = await dbHelper.getAllUsers();
    setState(() {
      usuarios = lista;
    });
  }

  Future<void> deletarUsuario(int id) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.deleteUser(id);
    await carregarUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuários cadastrados')),
      body: usuarios.isEmpty
          ? const Center(child: Text('Nenhum usuário cadastrado.'))
          : ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                final usuario = usuarios[index];
                return ListTile(
                  title: Text(usuario['nome']),
                  subtitle: Text(usuario['email']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deletarUsuario(usuario['id']),
                  ),
                );
              },
            ),
    );
  }
}