// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract ContratoAsistencias {
  event Asistencia(string correo, string fecha);

  function registrarAsistencia(string memory correo, string memory fecha) public {
    emit Asistencia(correo, fecha);
  }

}
