const { ethers, upgrades } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const Faucet = await ethers.getContractFactory("Faucet", []);
  const faucet = await upgrades.deployProxy(Faucet, [], { initializer: "initialize" });
  await faucet.waitForDeployment();
  console.log("Faucet contract deployed to:", await faucet.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
