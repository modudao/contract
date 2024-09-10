const { ethers, upgrades } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    const faucet = await ethers.getContractAt("Faucet", "0xc85fcd35dcc28e2283354cf4ed5d1f3299a90d18");

    const tx = await faucet.reset();
    await tx.wait();
    console.log("reset hash:", await tx.hash);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
