import 'dart:math';

class UniqueIdGenerator {
  static generateUniqueId(lista) {
    Set<int> usedIds = {};
    final Random random = Random(DateTime.now().millisecondsSinceEpoch);
    // Extrai os IDs da lista e adiciona aos IDs usados
    for (final item in lista) {
      usedIds.add(item.id);
    }

    int uniqueId;
    do {
      uniqueId =
          random.nextInt(999999999); // Ajuste o limite conforme necessário
    } while (usedIds.contains(uniqueId));

    return uniqueId;
  }
}
/** COMO UTILIZAR */

/*
class Pessoa {
  final int id;

  Pessoa(this.id);
}

void main() async {
  final generator = UniqueIdGenerator();

  // Suponha que listOfFutures seja uma lista de Future<List<Pessoa>>
  final listOfFutures = [
    Future.value([Pessoa(1), Pessoa(2)]),
    Future.value([Pessoa(3)])
  ];
  final uniqueId = await generator.generateUniqueId(listOfFutures);

  print("ID único gerado: $uniqueId");
}
*/