const { ethers } = require("hardhat");

const FAUCET_ADDRESS = "0xc85fcd35DCc28e2283354Cf4ED5D1f3299A90D18";

async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("account address:", deployer.address);

    const faucet = await ethers.getContractAt("Faucet", FAUCET_ADDRESS);
    tx = await faucet.distributeToUsers([
        { nickname: "MG12", addr: "0x236dAea11e6E18867981c6c0e549a9e2b7a63f31" },
    ]);
    await tx.wait();
    console.log("tx hash:", tx.hash);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });


