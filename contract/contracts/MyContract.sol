// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// https://medium.com/haloblock/deploy-your-own-smart-contract-with-truffle-and-ganache-cli-beginner-tutorial-c46bce0bd01e

contract MyContract {
  
  constructor() public {
  }

  struct ExampleParam {
    string field1;
    string field2;
  }

  struct ExampleOracleRequest {
    string field1;
    string field2;
  }

  struct ExampleOracleResponse {
    string field1;
    string field2;
  }

  struct ExampleAllDone {
    string field1;
    string field2;
  }

  event MyDataRequestEvent(ExampleOracleRequest req);

  event AllDoneEvent(ExampleAllDone results);

  function process(ExampleParam memory data) public {
    // ...
    emit MyDataRequestEvent(ExampleOracleRequest({ field1: data.field1, field2: data.field2 }));
  }

  function results(ExampleOracleResponse memory response) public {
    // ...
    emit AllDoneEvent(ExampleAllDone({ field1: response.field1, field2: response.field2 }));
  }
}
