import 'dart:io';

void main() {
  // Muestra el menú de opciones
  while (true) {
    print('Menú\n');
    print('1. Registrar temperaturas\n');
    print('2. Listar temperaturas positivas\n');
    print('3. Listar temperaturas negativas\n');
    print('4. listar ceros\n');
    print('5. Salir\n');

    // Lee la opción del usuario
    stdout.write('Digite una opción: ');
    String? option = stdin.readLineSync()?.trim();
    switch (option) {
      case '1':
        registrarTemperaturas(); // Llama a la función para registrar temperaturas
        break;
      case '2':
        listarTemperaturas('positivas.txt');
        break;
      case '3':
        listarTemperaturas('negativos.txt');
        break;
      case '4':
        listarTemperaturas('ceros.txt');
        break;
      case '5':
        print('Saliendo del programa...');
        return;
      default:
        print('Opción no válida. Intente de nuevo.');
    }
  }
}

void registrarTemperaturas() {
  while (true) {
    stdout.write('Ingrese una temperatura (-99 para salir): ');
    String? entrada = stdin
        .readLineSync()
        ?.trim(); //Esto previene que el usuario solo presione Enter y cause un error.
    if (entrada == null) continue;

    // Covierte la entrada en un número decimal
    double? temperatura = double.tryParse(entrada);
    if (temperatura == null) {
      print('Valor no válido. Intente de nuevo.');
      continue;
    }

    // Si el usuario ingresa -99, se sale del bucle
    if (temperatura == -99) break;

    // Clasifica la temperatura y la guarda en el archivo correspondiente
    if (temperatura > 0) {
      guardarEnArchivo('positivas.txt', temperatura);
    } else if (temperatura < 0) {
      guardarEnArchivo('negativos.txt', temperatura);
    } else {
      guardarEnArchivo('ceros.txt', temperatura);
    }
  }
}

void guardarEnArchivo(String nombreArchivo, double temperatura) {
  File archivo = File(nombreArchivo);
  archivo.writeAsStringSync('$temperatura\n', mode: FileMode.append); // Escribe la temperatura en el archivo con salto de línea
}

// Función para listar temperaturas desde un archivo
void listarTemperaturas(String nombreArchivo) {
  File archivo = File(nombreArchivo);

  // Verifica si el archivo existe
  if (!archivo.existsSync()) {
    print('No hay datos en $nombreArchivo\n.');
    return;
  }

  // Lee y muestra el contenido del archivo
  print('\nTemperaturas en $nombreArchivo:');
  print(archivo.readAsStringSync());
}
