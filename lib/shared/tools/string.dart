String convertirAFormatoNombrePropio(String input) {
  if (input.isEmpty) {
    return input; // Manejar el caso de una cadena vacía si es necesario
  }
  // Convierte la primera letra a mayúscula y las demás a minúsculas
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}

String obtenerPrimeraPalabra(String texto) {
  // Divide el texto en palabras utilizando un espacio como separador
  List<String> palabras = texto.split(' ');

  // Verifica si hay al menos una palabra
  if (palabras.isNotEmpty) {
    // Devuelve la primera palabra (índice 0)
    return palabras[0];
  } else {
    // En caso de que el texto esté vacío, devuelve una cadena vacía
    return '';
  }
}
