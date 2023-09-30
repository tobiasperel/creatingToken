import { ethers } from "hardhat";
async function main() {
  const contractAddress = "0xB3194eb729708450599eE4DA7287d654ffb3cc88 "; // Sustituye por la dirección de tu contrato en la cadena
  const [deployer] = await ethers.getSigners();
  const usuario2 = "0xcb0fF44D7818640F558Ec699d1cfCB8e3ff41489";

  // Conecta al contrato utilizando la dirección y la ABI
  const Contract = await ethers.getContractFactory("MyToken"); // Reemplaza 'MatchingPennies' con el nombre de tu contrato
  const contract = await Contract.attach(contractAddress);
  // Llama a una función de lectura del contrato (ejemplo)
  console.log("llamando desde la cuenta:", deployer.address);

  const nameToken = await contract.getName();
  console.log("name of token:", nameToken);
  const symbolToken = await contract.getSymbol();
  console.log("symbol of token:", symbolToken);
  const totalSupplyToken = await contract.totalSupply();
  console.log("totalSupply of token:", totalSupplyToken.toString());

// const ownerMint = await contract.mint(usuario2, 4065865860);
// console.log("ownerMint of token:", ownerMint.toString());

  const balanceToken1 = await contract.balanceOf(deployer.address);
  console.log("balance of token owner:", balanceToken1.toString());
  const balanceToken2 = await contract.balanceOf(usuario2);
  console.log("balance of token user2:", balanceToken2.toString());

//   const transferToken = await contract.transferToken(usuario2, 10555000000);
//     console.log("transferToken of token:", transferToken.toString());
//  const selltoken = await contract.sell(4006540000);
//     console.log("selltoken of token:", selltoken.toString());
    // const close = await contract.close();
    // console.log("close of token:", close.toString());
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
