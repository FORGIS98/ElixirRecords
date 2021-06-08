// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract ContratoAsistencias {
  event Asistencia(string correo, string fecha);

  string [] public correos;
  mapping(string => string) public listaAsistencias;

  function registrarAsistencia(string memory correo, string memory fecha) public {

    correos.push(correo);
    listaAsistencias[correo] = fecha;

    emit Asistencia(correo, fecha);
  }

  function getCorreos() public view returns (string [] memory) {
    return correos;
  }

  function getFecha(string memory correo) public view returns (string memory){
    return listaAsistencias[correo];
  }
}
