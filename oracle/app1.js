const { Web3 } = require("web3");
const fs = require('fs');

// update when deploying contract
const CONTRACT_ADDRESS = "0x9CB0E5268f445f5E2a3115A66ed802D3f8B6Ccf7";

// ("ws" protocol needed for event subscriptions)
const web3 = new Web3("ws://127.0.0.1:7545"); // copy port from ganache ui / cli output
// contract's ABI stub
const abi = JSON.parse(fs.readFileSync("./_Users_wvw_git_n3_blockiot-cds_example_oracle_contract_contracts_MyContract_sol_MyContract.abi"));
const contract = new web3.eth.Contract(abi, CONTRACT_ADDRESS);

async function run() {
    // const accounts = await web3.eth.getAccounts();
    // const account = accounts[0];

    let options = {
        filter: {
            value: [],
        },
        fromBlock: 0
    };
    const evt = contract.events.MyEvent(options);
    evt.on("connected", function (subscriptionId) { console.log("subscriptionId:", subscriptionId); });
    evt.on('data', function (event) { console.log("event:", event); })
}
run();