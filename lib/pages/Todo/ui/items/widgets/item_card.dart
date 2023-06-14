import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

import '../../../core/models/item.dart';
import '../../../core/repositories/item_repository_provider.dart';
import '../providers/write_item_view_model_provider.dart';
import '../write_item_page.dart';

// Créer une méthode pour formater le temps au format "yyyy-MM-dd HH:mm:ss.SSS"
String formatDateTime(String time) {
  final now = DateTime.now();
  final date = DateTime(now.year, now.month, now.day);
  final parsedTime = TimeOfDay(
    hour: int.parse(time.split(':')[0]), // obtenir l'heure
    minute: int.parse(time.split(':')[1]), // obtenir les minutes
  );
  final convertedTime = DateTime(
    date.year,
    date.month,
    date.day,
    parsedTime.hour,
    parsedTime.minute,
  );
  final formatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  return formatter.format(convertedTime);
}

// Créer une méthode pour récupérer le pourcentage d'avancement
double getProgressPercentage(String start, String end, String current) {
  final startTime = DateTime.parse(start);
  final endTime = DateTime.parse(end);
  final currentTime = DateTime.parse(current);
  
  final duration = endTime.difference(startTime);
  final elapsed = currentTime.difference(startTime);
  
  return elapsed.inSeconds / duration.inSeconds;
}

class ItemCard extends ConsumerWidget {
  const ItemCard({Key? key, required this.item}) : super(key: key);
  final Item item;

  Color getProgressColor(double progress) {
    if (progress >= 1.0) return Colors.red; // couleur rouge lorsque l'objectif est atteint
    return Colors.green; // couleur verte lorsqu'il n'est pas atteint
  }

  double calculateProgress() {
    final progress = getProgressPercentage(
      formatDateTime(item.starttime), // convertir vers le format complet pour la date
      formatDateTime(item.endtime), // convertir vers le format complet pour la date
      DateTime.now().toString(),
    );
    return math.min(math.max(progress, 0.0), 1.0); // limiter les valeurs entre 0 et 1
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;

    final progress = calculateProgress();
    final progressColor = getProgressColor(progress);

    return GestureDetector(
      onTap: () async {
        final writer = ref.read(writeItemViewModelProvider);
        writer.initial = item;
        await Navigator.pushNamed(context, WriteItemPage.route);
        writer.clear();
      },

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Dismissible(
          key: ValueKey(item.id),
          direction: DismissDirection.startToEnd,
          onDismissed: (v) {
            ref.read(itemRepositoryProvider).delete(item.id);
          },
          background: Material(
            borderRadius: BorderRadius.circular(12),
            color: Colors.redAccent,
            child: AspectRatio(
              aspectRatio: 3,
              child: Row(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Center(
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          confirmDismiss: (v) async {
            return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Are you sure you want to delete this item?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("NO"),
                  ),
                  MaterialButton(
                    color: theme.colorScheme.error,
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text("YES"),
                  ),
                ],
              ),
            );
          },
          child: Card(
            margin: EdgeInsets.zero,
            child: AspectRatio(
              aspectRatio: 3,
              child: Row(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      children: [
                        Image.network(
                          item.image,
                          fit: BoxFit.cover,
                        ),
                        LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            progressColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child:                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title: ${item.title}\n",
                        style: style.titleSmall!.copyWith(
                          color: Colors.black,
                        ),
                        maxLines: 2,
                      ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             "Start time: ${formatDateTime(item.starttime)}\n", // convertir vers le format complet pour la date
                      //             style: style.titleSmall!.copyWith(
                      //               color: Colors.black,
                      //             ),
                      //             maxLines: 2,
                      //           ),
                      //           Text(
                      //             "End time: ${formatDateTime(item.endtime)}\n", // convertir vers le format complet pour la date
                      //             style: style.titleSmall!.copyWith(
                      //               color: progressColor,
                      //             ),
                      //             maxLines: 2,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Text(
                        "Category: ${item.categories}\n",
                        style: style.titleSmall!.copyWith(
                          color: Colors.black,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);} }