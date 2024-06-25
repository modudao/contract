const { ethers } = require("hardhat");

const NFT_ADDRESS = "0xdE2a2B8a96Ba7FD38F73655384C3184C40440f9b";

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


