double? parseDouble(String value) {
  if (value.isEmpty) {
    return null;
  }
  // Substitui "," por "." para permitir ambos os formatos
  value = value.replaceAll(',', '.');

  try {
    return double.parse(value);
  } catch (e) {
    return null; // Retorna null se a análise falhar
  }
}

String duasCasasDecimais(double valor) {
  return valor.toStringAsFixed(2); // "22.46"
  /*(double valorFormatado = (valor * math.pow(10, 2)).round() / math.pow(10, 2))*/
}
