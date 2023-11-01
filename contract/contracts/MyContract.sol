// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// https://medium.com/haloblock/deploy-your-own-smart-contract-with-truffle-and-ganache-cli-beginner-tutorial-c46bce0bd01e

contract MyContract {
  
  constructor() public {
  }

  event MyEvent(uint nr);

  function hi() public {
    emit MyEvent(123);
    // return ("Hello World");
  }
}
