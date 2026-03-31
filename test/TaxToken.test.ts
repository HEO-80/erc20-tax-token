import { expect } from "chai";
import { network } from "hardhat";

describe("TaxToken", function () {
  let token, owner, treasury, addr1, addr2;

  beforeEach(async function () {
    const { ethers } = await network.connect();
    [owner, treasury, addr1, addr2] = await ethers.getSigners();
    const Token = await ethers.getContractFactory("TaxToken");
    token = await Token.deploy(
      "Tax Token",
      "TAX",
      ethers.parseEther("1000000"),
      5,
      treasury.address
    );
  });

  it("Should assign initial supply to owner", async function () {
    const { ethers } = await network.connect();
    expect(await token.balanceOf(owner.address)).to.equal(ethers.parseEther("1000000"));
  });

  it("Should charge tax on transfers", async function () {
    const { ethers } = await network.connect();
    await token.transfer(addr1.address, ethers.parseEther("1000"));
    const balance = await token.balanceOf(addr1.address);
    expect(balance).to.equal(ethers.parseEther("950"));
    const treasuryBalance = await token.balanceOf(treasury.address);
    expect(treasuryBalance).to.equal(ethers.parseEther("50"));
  });

  it("Owner can change tax percent", async function () {
    await token.setTax(10);
    expect(await token.taxPercent()).to.equal(10);
  });

  it("Cannot exceed MAX_TAX", async function () {
    await expect(token.setTax(26)).to.be.revertedWith("Tax too high");
  });

  it("Owner can change treasury wallet", async function () {
    await token.setTreasury(addr2.address);
    expect(await token.treasury()).to.equal(addr2.address);
  });

  it("Non-owner cannot change tax", async function () {
    const tokenAsAddr1 = token.connect(addr1);
    await expect(tokenAsAddr1.setTax(10))
      .to.be.revertedWithCustomError(token, "OwnableUnauthorizedAccount");
  });

  it("Should not charge tax on mint", async function () {
    const { ethers } = await network.connect();
    expect(await token.balanceOf(owner.address)).to.equal(ethers.parseEther("1000000"));
  });
});