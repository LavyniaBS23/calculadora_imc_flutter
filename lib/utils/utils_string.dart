String primeiraLetraMaiuscula(String palavra) {
  if (palavra.isEmpty) return palavra; // Trata caso a palavra esteja vazia.
  return palavra[0].toUpperCase() + palavra.substring(1);
}

String primeiraLetraMaiusculaDasPalavras(String texto) {
  List<String> palavras = texto.split(" ");
  List<String> capitalizedWords = [];

  for (String palavra in palavras) {
    if (palavra.isNotEmpty) {
      String capitalizedWord =
          palavra[0].toUpperCase() + palavra.substring(1).toLowerCase();
      capitalizedWords.add(capitalizedWord);
    }
  }

  return capitalizedWords.join(" ");
}