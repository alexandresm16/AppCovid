import 'package:aula/model/Check_sintomas.dart';

class DefinirCasoSuspeito {

  String casoSuspeitoCovidOrientacao(CheckSintomasModel csm){

    if(casoSuspeito(csm) && csm.qtdDiasSintomas >=10){
      return 'URGENTE: PACIENTE DEVE SER INTERNADO';
    } else if(casoSuspeito(csm) && csm.qtdDiasSintomas >=8){
      return 'ATENÇÃO: ENCAMINHAR IMEDIATAMENTE PARA AVALIAÇÃO MÉDICA';
    } else if(casoSuspeito(csm) && csm.qtdDiasSintomas >=6){
      return 'CASO SUSPEITO: PACIENTE DEVE SER ENCAMINHADO PARA EXAMES';
    } else {
      return 'ESTÁ TUDO BEM';
    }
  }


  bool casoSuspeito(CheckSintomasModel csm){
    if(_calculaPonto(csm) >=4){
      return true;
    }
    return false;
  }
  
  int _calculaPonto(CheckSintomasModel csm) {
    int pontos = 0;

    if (csm.qtdDiasSintomas > 6) {
      if (_sarg(csm)) {
        pontos = pontos + 4;
      }
      if (csm.temp > 37.8) {
        pontos = pontos + 2;
      }
      if (csm.isTosse) {
        pontos = pontos + 1;
      }
      if (csm.isRouquidao) {
        pontos = pontos + 1;
      }
      if (csm.isDorGarganta) {
        pontos = pontos + 1;
      }
      if (csm.isNarizEntupido) {
        pontos = pontos + 1;
      }
    }
    return pontos;
  }


  bool _sarg(CheckSintomasModel csm) {
    if (csm.qtdDiasSintomas > 6) {
      if (csm.temp > 37.8 && (csm.isTosse || csm.isCatarro))
        return true;
    }
    return false;
  }
}
