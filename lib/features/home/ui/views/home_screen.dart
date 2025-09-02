import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gap/gap.dart';
import 'package:salsa_challenge/app/app.dart';
import 'package:salsa_challenge/features/home/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final store = getIt<HomeStore>();

  @override
  void initState() {
    store.load();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, AppSpacing.xs),
          child: Observer(
            builder: (context) {
              if (store.isLoading) {
                return const LinearProgressIndicator();
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      body: Observer(
        builder: (context) {
          if (store.isLoading) {
            return ListView.separated(
              itemCount: 5,
              padding: const EdgeInsets.all(AppSpacing.md),
              itemBuilder: (context, index) {
                return const AppSkeleton(isLoading: true, child: SizedBox(height: 100, width: double.infinity));
              },
              separatorBuilder: (context, index) {
                return const Gap(AppSpacing.md);
              },
            );
          }

          if (!store.hasItems) {
            return const Center(child: Text('No items'));
          }

          return ListView.builder(
            itemCount: store.itemCount,
            itemBuilder: (context, index) {
              final item = store.items[index];
              return Text(item.toString());
            },
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton.filledTonal(onPressed: store.load, icon: const Icon(Icons.add), iconSize: 32),
          const Gap(AppSpacing.md),
          IconButton.filled(onPressed: () {}, icon: const Icon(Icons.remove), iconSize: 32),
        ],
      ),
    );
  }
}
