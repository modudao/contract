const { ethers, upgrades } = require("hardhat");

const NFT_ADDRESS = "0x8aDfAA9C3ACaE1E519661C15aA1c05727b0387D2";

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