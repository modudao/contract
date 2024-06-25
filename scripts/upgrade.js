const { ethers, upgrades } = require("hardhat");

const NFT_ADDRESS = "0xF0209111c0af1eB142757CE1399876CDcE06E9F5";

async function main() {
    let [deployer] = await ethers.getSigners();
    // deployer = await ethers.getImpersonatedSigner("0xbDd5dC5254e752aB45Fb2B3654bd66CeC83a8B22");
    console.log("account address:", deployer.address);
    
    console.log("upgrade modudaoNFT");
    const MODUDAONFT = await ethers.getContractFactory("MODUDAONFT", deployer);
    // await upgrades.upgradeProxy(NFT_ADDRESS, MODUDAONFT);
    await upgrades.upgradeProxy(NFT_ADDRESS, MODUDAONFT, { unsafeSkipStorageCheck: true });
    
    // const modudaoNFT = await ethers.getContractAt("MODUDAONFT", NFT_ADDRESS);
}

main();