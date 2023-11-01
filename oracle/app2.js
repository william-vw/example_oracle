const { Web3 } = require("web3");
const fs = require('fs');

// update when deploying contract
const CONTRACT_ADDRESS = "0x04371e14e203487EdcF0bFfdA24342aFF96B919A";

// ("ws" protocol needed for event subscriptions)
const web3 = new Web3("ws://127.0.0.1:7545"); // copy port from ganache ui / cli output
// contract's ABI stub
const abi = JSON.parse(fs.readFileSync("./_Users_wvw_git_n3_blockiot-cds_SmartContractDemo_contract_contracts_Contract_sol_Contract.abi"));
const contract = new web3.eth.Contract(abi, CONTRACT_ADDRESS);

async function run() {
    const accounts = await web3.eth.getAccounts();
    const account = accounts[0];

    const ret = await contract.methods.hi().send({ from: account });
    console.log("ret:", ret)
}
run();