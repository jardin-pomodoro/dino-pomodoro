import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final sentencesStreamProvider = StreamProvider<String>((ref) {
  final sentenses = [
    "La vie est trop courte pour boire du mauvais café.",
    "La vérité est comme un ballon de football, plus on l'attrape, plus elle s'échappe.",
    "La sagesse est comme une bouteille de vin, plus vieille, plus chère et plus forte.",
    "La liberté est comme un chat, elle ne se laisse jamais attraper.",
    "Le bonheur est comme un papillon, il vient quand on cesse de le poursuivre.",
    "La vie est comme un livre, certains chapitres sont tristes, d'autres sont heureux, mais tous sont nécessaires pour en comprendre l'histoire.",
    "La vie est comme une boîte de chocolats, on ne sait jamais sur quoi on va tomber.",
    "L'amour est comme un puzzle, il faut tout mettre en place pour que ça fonctionne.",
    "La vie est comme une roue de la fortune, on ne sait jamais quand on va monter ou descendre.",
    "La réalité est comme une illusion, elle dépend de la façon dont on la regarde.",
    "Avec Flutter, vous pouvez construire des applications pour toutes les plateformes avec un seul code.",
    "Flutter rend le développement d'application mobile plus rapide qu'une flèche.",
    "Avec Flutter, vous pouvez donner vie à vos idées en un rien de temps.",
    "Flutter vous permet de créer des designs élégants et fluides pour vos applications."
  ];

  return Stream.periodic(const Duration(seconds: 10), (_) {
    return sentenses[Random().nextInt(sentenses.length)];
  });
});

final sentenceProvider = Provider<String>((ref) {
  return ref.watch(sentencesStreamProvider).value ?? "";
});
