// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract AssistanceContract {

  event Assist(string eventName, string userNickname, string date);

  function saveAssistance(string memory eventName, string memory userNickname, string memory date) public {
    emit Assist(eventName, userNickname, date);
  }
}
