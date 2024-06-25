const { ethers } = require("hardhat");

const NFT_ADDRESS = "0x8aDfAA9C3ACaE1E519661C15aA1c05727b0387D2";

async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("account address:", deployer.address);

    const modudaoNFT = await ethers.getContractAt("MODUDAONFT", NFT_ADDRESS);

    tx = await modudaoNFT.reset();
    await tx.wait();
    console.log("tx hash:", tx.hash);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });


