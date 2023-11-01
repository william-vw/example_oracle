// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// https://medium.com/haloblock/deploy-your-own-smart-contract-with-truffle-and-ganache-cli-beginner-tutorial-c46bce0bd01e

contract MyContract {
  
  constructor() public {
  }

  event MyDataRequestEvent(string req);

  event AllDoneEvent(string results);

  function process(string memory data) public {
    // ...
    emit MyDataRequestEvent(string.concat("get me data to process '", data, "'"));
  }

  function results(string memory someOtherData) public {
    emit AllDoneEvent(string.concat("based on '", someOtherData, "', we're finally done"));
  }
}
