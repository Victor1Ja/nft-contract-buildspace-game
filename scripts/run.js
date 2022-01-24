const main = async () => {
    const gameContractFactory = await hre.ethers.getContractFactory('MyEpicGame');
    const gameContract = await gameContractFactory.deploy(
        ["Watson", "Smoky", "Alienator"],       // Names
        ["https://weird-whales.com/_next/image?url=https%3A%2F%2Fgithub.com%2Fbenyaminahmed%2Fweird-whales-images%2Fraw%2Fmain%2Foptimized-images%2F600x600%2F3087.png%3Fraw%3Dtrue&w=384&q=75", // Images
        "https://weird-whales.com/_next/image?url=https%3A%2F%2Fgithub.com%2Fbenyaminahmed%2Fweird-whales-images%2Fraw%2Fmain%2Foptimized-images%2F600x600%2F3059.png%3Fraw%3Dtrue&w=384&q=75", 
        "https://weird-whales.com/_next/image?url=https%3A%2F%2Fgithub.com%2Fbenyaminahmed%2Fweird-whales-images%2Fraw%2Fmain%2Foptimized-images%2F600x600%2F115.png%3Fraw%3Dtrue&w=384&q=75"],
        [350, 150, 300],                    // HP values
        [23, 80, 25]                       // Attack damage values
    );
    await gameContract.deployed();
    console.log("Contract deployed to:", gameContract.address);
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();