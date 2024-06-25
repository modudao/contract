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

const FAUCET_ADDRESS = "0xc85fcd35DCc28e2283354Cf4ED5D1f3299A90D18";

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

        if (dbData.length == 0) { await sleep(10000); continue; }

        console.log("dbData:", dbData);
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


