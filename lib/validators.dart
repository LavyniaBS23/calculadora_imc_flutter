double? parseDouble(String? value) {
  if (value == null || value.isEmpty) {
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

String? validateNome(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, digite seu nome.';
  }
  return null; // Retorna null quando a validação passa
}

String? validatePeso(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, digite um valor para o peso.(Ex: 60.7 ou 60,7)';
  }
  double? peso = parseDouble(value);
  if (peso == null) {
    return 'O valor digitado para o peso não é um número válido.';
  }
  if (peso <= 0) {
    return 'O peso deve ser maior que zero.';
  }
  return null; // Retorna null quando a validação passa
}

String? validateAltura(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, digite um valor para a altura.(Ex: 1.60 ou 1,60)';
  }
  double? altura = parseDouble(value);
  if (altura == null) {
    return 'O valor digitado para a altura não é um número válido.';
  }
  if (altura <= 0) {
    return 'A altura deve ser maior que zero.';
  }
  return null; // Retorna null quando a validação passa
}
