const { ethers, upgrades } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const RWANFTSeason4 = await ethers.getContractFactory("RWANFTSeason4", []);
  const rwaNFTSeason4 = await upgrades.deployProxy(RWANFTSeason4, ["패딩 머플러", "머플러"], { initializer: "initialize" });
  await rwaNFTSeason4.waitForDeployment();
  console.log("RWANFTSeason4 contract deployed to:", await rwaNFTSeason4.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
