require("@nomicfoundation/hardhat-toolbox");
require("@openzeppelin/hardhat-upgrades");
require("dotenv").config();

const KLAYTN_URL = "https://public-en.node.kaia.io";
// const KLAYTN_URL = "https://1rpc.io/klay";

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    compilers: [{
      version: "0.8.24",
      settings: {
        optimizer: {
          enabled: true,
          runs: 2 ** 32 - 1,
        }
      }
    },],
  },
  defaultNetwork: 'hardhat',
  networks: {
    hardhat: {
      forking: {
        enabled: true,
        url: KLAYTN_URL,
      },
    },
    localhost: {
      url: "http://127.0.0.1:8545",
    },
    klay: {
      url: KLAYTN_URL,
      accounts: [process.env.PK],
    },
  },
};
