import 'package:flutter/material.dart';

import '../../../database/check_sintomasDAO.dart';
import '../../../model/Check_sintomas.dart';

// resultados.dart
class Resultados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resultados dos Sintomas')),
      body: FutureBuilder<List<CheckSintomasModel>>(
        future: CheckSintomasDAO().getTodosCasosSuspeitos(), // nova função
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Erro: ${snapshot.error}'));
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text('Nenhum caso suspeito encontrado'));

          final casos = snapshot.data!;
          return ListView.builder(
            itemCount: casos.length,
            itemBuilder: (context, index) {
              final s = casos[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Paciente: ${s.paciente.nome}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Idade: ${s.paciente.idade} Anos' ),
                      Text('Temperatura: ${s.temp}°C'),
                      Text('Dias com sintomas: ${s.qtdDiasSintomas} Dias'),
                      Text('Data: ${s.dataAvaliacao.day}/${s.dataAvaliacao.month}/${s.dataAvaliacao.year}'),
                      RichText(
                        text: TextSpan(
                          text: 'Caso suspeito: ',
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: s.isCasoSuspeito ? 'SIM' : 'NÃO',
                              style: TextStyle(
                                color: s.isCasoSuspeito ? Colors.red : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    s.isCasoSuspeito ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                    color: s.isCasoSuspeito ? Colors.red : Colors.green,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
