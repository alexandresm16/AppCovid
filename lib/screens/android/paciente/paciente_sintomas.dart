import 'package:flutter/material.dart';
import 'package:aula/model/Check_sintomas.dart';

class PacienteSintomas extends StatelessWidget {
  final List<CheckSintomasModel> sintomas;

  const PacienteSintomas({super.key, required this.sintomas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sintomas do Paciente"),
      ),
      body: sintomas.isEmpty
          ? const Center(child: Text("Nenhum sintoma registrado."))
          : ListView.builder(
        itemCount: sintomas.length,
        itemBuilder: (context, index) {
          final sintoma = sintomas[index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data: ${sintoma.dataAvaliacao.day}/${sintoma.dataAvaliacao.month}/${sintoma.dataAvaliacao.year}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Temperatura: ${sintoma.temp}°C'),
                  Text('Dias com sintomas: ${sintoma.qtdDiasSintomas}'),
                  const Divider(),
                  _sintomaTexto("Tosse", sintoma.isTosse),
                  _sintomaTexto("Dor de garganta", sintoma.isDorGarganta),
                  _sintomaTexto("Catarro", sintoma.isCatarro),
                  _sintomaTexto("Nariz entupido", sintoma.isNarizEntupido),
                  _sintomaTexto("Rouquidão", sintoma.isRouquidao),
                  const Divider(),
                  Row(
                    children: [
                      Text('Caso suspeito: '),
                      Icon(
                        sintoma.isCasoSuspeito
                            ? Icons.warning_amber_rounded
                            : Icons.check_circle_outline,
                        color: sintoma.isCasoSuspeito ? Colors.red : Colors.green,
                      ),
                      Text( '${sintoma.isCasoSuspeito ? " SIM " : " NÃO "}'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sintomaTexto(String label, bool valor) {
    return Row(
      children: [
        Icon(
          valor ? Icons.check : Icons.close,
          color: valor ? Colors.green : Colors.grey,
          size: 20,
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
