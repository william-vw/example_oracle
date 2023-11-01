# Instructions

### Run ganache (UI or CLI)
- UI allows checking issued events (not supported by ganache-cli)  
(first time in UI: link truffle contract project (contracts > "add project"; select project's "truffle-config.js"))
- Note port number & update `contract/truffle-config.js`, `web3/*.js`


### Compile & deploy contract
- Compile new ABI (~ "stub") to be referred by web3js:  
(if changed, copy filename to `web3/*.js`)
```
web3 % solcjs ../contract/contracts/MyContract.sol --abi
```

- Re-compile contract & deploy ("migrate") to ganache
```
contract % sudo truffle compile
contract % sudo truffle migrate
```

- Note new contract address & update `web3/*.js`


# Run client & oracle
```
web3 % node oracle.js
web3 % node client.js
```