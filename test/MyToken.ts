import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("MyToken", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployToken() {
    
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();

    const MyToken = await ethers.getContractFactory("MyToken");
    const myToken = await MyToken.deploy("TobiasPerel", "TP");
    return {myToken, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("create token", async function () {
      const { myToken } = await loadFixture(deployToken);
      expect(await myToken.totalSupply()).to.equal(0);
    });
    it("mint token", async function () {
      const { myToken, owner } = await loadFixture(deployToken);
      await myToken.mint(owner.address, 100);
      expect(await myToken.totalSupply()).to.equal(100);
    });
    it("transfer token", async function () {
      const { myToken, owner, otherAccount } = await loadFixture(deployToken);
      await myToken.mint(owner.address, 100);
      await myToken.transfer(otherAccount.address, 20);
      expect(await myToken.balanceOf(otherAccount.address)).to.equal(20);
      expect(await myToken.balanceOf(owner.address)).to.equal(80);
      expect(await myToken.totalSupply()).to.equal(100);
    });
    it("sell token", async function () {
      const { myToken, owner, otherAccount } = await loadFixture(deployToken);
      await myToken.mint(owner.address, 100);
      await myToken.transfer(otherAccount.address, 20);
      await myToken.sell(otherAccount.address, 20);
      expect(await myToken.balanceOf(otherAccount.address)).to.equal(0);
      expect(await myToken.balanceOf(owner.address)).to.equal(100);
      expect(await myToken.totalSupply()).to.equal(100);
    }
    
    
  });

});
