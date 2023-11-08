const { Web3 } = require("web3");
const fs = require('fs');

// update when deploying contract
const CONTRACT_ADDRESS = "0xaf08BEc38278ce089804b61779ECe1a7a2ae1d8a";

// ("ws" protocol needed for event subscriptions)
const web3 = new Web3("ws://127.0.0.1:7545"); // copy port from ganache ui / cli output
// contract's ABI stub
const abi = JSON.parse(fs.readFileSync("./_Users_wvw_git_n3_blockiot-cds_example_oracle_contract_contracts_MyContract_sol_MyContract.abi"));
const contract = new web3.eth.Contract(abi, CONTRACT_ADDRESS);

async function run() {
    const accounts = await web3.eth.getAccounts();
    const account = accounts[0];

    // receive result events
    // (fromBlock: update to avoid getting older events)
    const evt = contract.events.AllDoneEvent({ filter: { value: [] }, fromBlock: 25 });
    evt.on("connected", function (subscriptionId) { console.log("subscriptionId:", subscriptionId); });
    evt.on('data', async function (event) { console.log("got result event:", event); });

    // call contract to process claim
    await contract.methods.process({ field1: "abc", field2: "def" }).send({ from: account });
}
run();