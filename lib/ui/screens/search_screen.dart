import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/city.dart';
import '../../viewmodels/search_view_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ctrl = TextEditingController();

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SearchViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Search City')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: ctrl,
              onChanged: vm.onQueryChanged,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Type a city name',
              ),
            ),
            const SizedBox(height: 12),
            if (vm.loading) const LinearProgressIndicator(),
            if (vm.error != null)
              Text(vm.error!, style: const TextStyle(color: Colors.red)),
            Expanded(
              child: ListView.separated(
                itemCount: vm.results.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final City c = vm.results[i];
                  return ListTile(
                    title: Text('${c.name}, ${c.country}'),
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: c.name,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
