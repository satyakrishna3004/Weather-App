import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/home_view_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: ListView.builder(
        itemCount: vm.favorites.length,
        itemBuilder: (context, i) {
          final c = vm.favorites[i];
          return Dismissible(
            key: ValueKey('${c.name}-${c.country}'),
            background: Container(color: Colors.red),
            onDismissed: (_) => vm.removeFavorite(c),
            child: ListTile(
              title: Text('${c.name}, ${c.country}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () =>
                  Navigator.pushNamed(context, '/detail', arguments: c.name),
            ),
          );
        },
      ),
    );
  }
}
