# Instructions

### Run ganache (UI or CLI)
- UI allows checking issued events (not supported by ganache-cli)  
(first time in UI: link truffle contract project (contracts > "add project"))
- Note port number & update `contract/truffle-config.js`, `oracle/app[n].js`


### Compile & deploy contract
- Compile new ABI (~ "stub") to be referred by web3js:  
(if new, copy filename to `oracle/app[n].js`)
```
oracle % solcjs ../contract/contracts/MyContract.sol --abi
```

- Re-compile contract & deploy ("migrate") to ganache
```
contract % sudo truffle compile
contract % sudo truffle migrate
```

- Note new contract address & update `oracle/app[n].js`


# Run oracles
```
oracle % node app1.js
oracle % node app2.js
```