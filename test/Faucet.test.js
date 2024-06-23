const { ethers, upgrades } = require("hardhat");
const { expect } = require("chai");

describe("Faucet", function () {
    let faucet;
    let owner, addr1, addr2, addr3;

    before(async function () {
        [owner, addr1, addr2, addr3] = await ethers.getSigners();
        const Faucet = await ethers.getContractFactory("Faucet");
        faucet = await upgrades.deployProxy(Faucet, [], { initializer: "initialize" });
        await faucet.waitForDeployment();
        console.log("Faucet contract deployed to:", await faucet.getAddress());
    });

    describe("distributeToUsers", function () {
        it("should distribute ether to multiple users", async function () {
            const users = [
                { nickname: "User1", addr: addr1.address },
                { nickname: "User2", addr: addr2.address },
                { nickname: "User3", addr: addr3.address }
            ];

            // Deposit ether into the contract
            await owner.sendTransaction({
                to: await faucet.getAddress(),
                value: ethers.parseEther("50")
            });

            await faucet.distributeToUsers(users);

            for (const user of users) {
                expect(await faucet.isClaimed(user.addr)).to.be.true;
                expect(await faucet.getNickname(user.addr)).to.equal(user.nickname);
                expect(await ethers.provider.getBalance(user.addr)).to.equal(
                    ethers.parseEther("10011") // Initial 10000 ether + 11 ether claim
                );
            }

            const storedUsers = await faucet.getUsers();
            expect(storedUsers.length).to.equal(users.length);
            for (let i = 0; i < users.length; i++) {
                expect(storedUsers[i].nickname).to.equal(users[i].nickname);
                expect(storedUsers[i].addr).to.equal(users[i].addr);
            }
        });

        it("should revert if a user has already claimed", async function () {
            const user = { nickname: "User1", addr: addr1.address };

            await faucet.distributeToUser(user);

            expect(await ethers.provider.getBalance(user.addr)).to.equal(
                ethers.parseEther("10011") // Initial 10000 ether + 11 ether claim
            );
        });
    });

    describe("reset", function () {
        it("should reset all users and claimed states", async function () {
            const users = [
                { nickname: "User1", addr: addr1.address },
                { nickname: "User2", addr: addr2.address },
                { nickname: "User3", addr: addr3.address }
            ];

            await faucet.reset();

            for (const user of users) {
                expect(await faucet.isClaimed(user.addr)).to.be.false;
                expect(await faucet.getNickname(user.addr)).to.equal("");
            }

            const storedUsers = await faucet.getUsers();
            expect(storedUsers.length).to.equal(0);
        });
    });
});
