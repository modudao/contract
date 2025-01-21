const { ethers } = require("hardhat");
const mysql = require('mysql2/promise');
require('dotenv').config();

// config
const config = {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PW,
    port: process.env.DB_PORT,
    database: process.env.DB_NAME,
};

// seson2
// const FAUCET_ADDRESS = "0xc85fcd35DCc28e2283354Cf4ED5D1f3299A90D18";
// seson3
// const FAUCET_ADDRESS = "0x382F00221de389998D09b79255728B72aFe97469";
// seson4
const FAUCET_ADDRESS = "0x642662544F99E28E69FaD5ec175687aD168D34C0";

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function main() {
    const connection = await mysql.createConnection(config);
    // const [deployer] = await ethers.getSigners();

    while (true) {
        console.log("start");
        let [dbData,] = await connection.execute(`SELECT name AS nickname, address AS addr FROM users;`, []);

        const faucet = await ethers.getContractAt("Faucet", FAUCET_ADDRESS);
        const faucetData = await faucet.getUsers();

        const faucetAddrs = new Set(faucetData.map(item => item[1]));

        dbData = dbData.filter(item => !faucetAddrs.has(item.addr));
        console.log("dbData", dbData);

        if (dbData.length == 0) { await sleep(10000); continue; }
        
        tx = await faucet.distributeToUsers(dbData);
        await tx.wait();
        console.log("tx hash:", tx.hash);

        await sleep(20000);
    }
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });

// npx hardhat run scripts/bot.js --network klay