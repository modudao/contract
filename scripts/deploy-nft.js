const { ethers, upgrades } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  // const MODUDAONFT = await ethers.getContractFactory("MODUDAONFT", []);
  const MODUDAONFT = await ethers.getContractFactory("MODUDAONFTSeason3", []);
  const modudaoNFT = await upgrades.deployProxy(MODUDAONFT, ["다오랩 맴버십", "다오랩"], { initializer: "initialize" });
  await modudaoNFT.waitForDeployment();
  console.log("MODUDAONFT contract deployed to:", await modudaoNFT.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
