import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/providers/auth_view_model_provider.dart';
import '../items/providers/items_view_model_provider.dart';
import '../items/providers/write_item_view_model_provider.dart';
import '../items/widgets/item_card.dart';
import '../items/write_item_page.dart';


class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = itemsViewModelProvider;
    final model = ref.watch(provider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Items"),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, WriteItemPage.route);
          ref.read(writeItemViewModelProvider).clear();
        },
        child: const Icon(Icons.add),
      ),
      body: model.items.isEmpty && model.busy
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (!model.busy &&
                    notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent) {
                  model.loadMore();
                }
                return true;
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.refresh(provider);
                },
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(8),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          model.items
                              .map(
                                (e) => ItemCard(item: e), // utilisez ItemCard(item: e) pour passer l'objet `Item`
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: model.loading && model.items.length >= 8
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}