# NFTs

In this section of the course we'll be investigate Non-fungible Tokens (NFTs), we'll learn what an NFT is, why they're so cool and how to create our very own NFTs, one basic and one advanced.

## Two Flavors

As mentioned, we'll be learning two approaches to simple NFT development in this course. This first will be a basic implementation using these cute puppies!

<img src="./images/nfts1.png" alt="nfts1" />

In this first basic implementation our images are going to be stored in **[IPFS](https://ipfs.tech/)**.

With our second NFT, the art is going to be stored _on-chain_ and dynamic, changing based on a criteria we set, setting our mood from happy to sad or vice versa!

<img src="./images/nfts2.png" alt="nfts2" />

And, perhaps most excitingly, by the end of this section you'll have you're very own NFTs imported into your own wallet/metamask. You can also view them on service like OpenSea which will allow you to sell, trade, view and collect all sorts of NFTs!

## What is a NFT?

Non-fungible Tokens (NFTs) are a product of the **[ERC721 Token Standard](https://eips.ethereum.org/EIPS/eip-721)**, created on Ethereum.

NFTs are:

-   Non-fungible: This means they are explicitly unique from one another and one NFT cannot be interchanged with another

Fungible tokens, like ERC20s are similar to a dollar. Any single dollar can be swapped with any other and no value is lost. NFTs by contrast are unique in themselves with different properties from token to token.

> ❗ **PROTIP**
> Think of NFTs like Pokemon! No two Pikachus are exactly the same and there are many different types within the same class or collection. Other comparisons include: trading cards, unique pieces of art

### What's an NFT do?

Because of their unique nature, NFTs have been widely adopted as a medium for art and a means to trade and collect digital art. Sometimes this gets a bad rap, but NFTs are only a standard on which a tonne of use case functionality can be built. Some protocol turn them into representations of game assets, or into tradeble metaverse items, sometimes they're used as means to keep record, or grant access to services or events.

The use cases of NFTs grow each day, but the easiest way to think of them currently is as unique digital assets, or unique digital art.

At their core, NFTs are tokens which exist on a smart contract platform, they can be viewed, bought and sold on marketplaces such as **[OpenSea](https://opensea.io/)** and **[Rarible](https://rarible.com/)**. The marketplaces aren't required of course, but the UI/UX is generally better than a command line.

Initial reactions to NFTs are often _**"What's the point of digital pictures?"**_, but it goes beyond that. Art has value and classically it's difficult for artists to be adequately compensated, or to assure proper attribution when their work is shared. In a world where copy and paste erodes digital ownership, NFTs claw back that value and afford artists greater control of and compensation from the work they do.

### ERC721 Standard (NFTs)

NFTs, and the ERC721 Token Standard, differ from ERC20s in a few fundamental ways.

**Ownership**

ERC20s handle ownership via a simple mapping of a uint256 token balance to an address.

ERC721s, by contrast, each have a unique tokenId, these tokenIds are mapped to a user's address. In addition to a tokenId, ERC721s include a tokenUri, we'll go into more detail later, but essentially a tokenUri details the unique properties of that token, stats, images etc.

**Fungibility**

NFTs are _non-fungible_. This means each token is unique and cannot be interchanged with another. ERC20s, on the other hand, are _fungible_. Any LINK token is identical in property and value to any other LINK token.

_**What makes an NFT unique?**_

The uniqueness of an NFT token is demonstrated by it's unique tokenId as well as it's metadata/tokenUri. This is a property of an NFT which details the attributes of that token. You can imagine a character in a game, the tokenUri would be their stats page and all the details that make them an individual.

Now, when we talk about NFT representing _Art_ that comes with some implications in the blockchain space that can be pretty impactful. In Ethereum, there's a little thing called **gas**. Gas costs on ethereum make the storage of large amounts of data (like images), on-chain, prohibitively expensive in most cases.

The solution to this was the inclusion of the tokenUri within the ERC721 Standard. This serves as a property of a token which details what the asset looks like as well as any attributes associated with it. A basic tokenUri looks something like:

```js
{
    "name": "Name",
    "description": "Description",
    "image": "ImageURI",
    "attributes": []
}
```

Even this can serve to be pretty expensive, so there's a constant discuss about on-chain vs off-chain metadata. Off-chain solutions obviously come with all the pitfalls of centralization that we would expect (including losing record of what your NFT is), but the easy and savings associated with avoiding deploying this extra data are pretty appealing.

Often a protocol will use a service like **[IPFS](https://ipfs.tech/)** to hedge their bets a little bit in a more decentralized method of storage, but it too comes with its own pros and cons.

To take this consideration even further, oftentimes marketplaces won't have a means to recognize on-chain metadata since they're _so_ used to looking for a tokenUri.

In General:

-   Upload NFT Image to IPFS
-   Create metadata point to that image
-   Set the NFTs tokenUri to point to that metadata

## Foundry Setup

Now that we know what an NFT is, let's investigate how we can build our own.

To start, let's initialize our workspace. Create a new directory in your course folder.

```bash
mkdir foundry-nft
```

We can then switch to this directory and open it in VSCode.

```bash
cd foundry-nft
code .
```

Finally, we can initialize our foundry project.

```bash
forge init
```

Once initialized, be sure to remove the example contracts `src/Counter.sol`, `test/Counter.t.sol` and `script/Counter.s.sol`. Finally, assure that your `.gitignore` contains `.env` and `broadcast/`

### NFT Contracts

Now, as mentioned previously, NFTs are just another type of **[Token Standard](https://eips.ethereum.org/EIPS/eip-721)**, similar to ERC20s. As such, we could simply write our contract and begin implementing all the necessary methods to comply with this standard. However, like ERC20s, we can also just import a library (like OpenZeppelin) which does all this heavy lifting for us.

Begin by creating `src/BasicNft.sol` and setting up our usual boilerplate.

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract BasicNft{}
```

We can install the OpenZeppelin Contracts library with:

```bash
forge install OpenZeppelin/openzeppelin-contracts --no-commit
```

To make things a little easier on ourselves, we can add this as a remapping to our `foundry.toml`. This remapping allows us to use some short-hand when importing from this directory.

```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
remappings = ["@openzeppelin/contracts=lib/openzeppelin-contracts/contracts"]
```

Now we can import and inherit the ERC721 contract into `BasicNft.sol`

```solidity
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

pragma solidity ^0.8.18;

contract BasicNft is ERC721 {}
```

Your IDE will likely indicate an error until we've passed the necessary arguments to the ERC721 constructor. You can ctrl + left-click (cmd + left-click) on the imported ERC721.sol to navigate to this contract and confirm what the constructor requires.

```solidity
constructor(string memory name_, string memory symbol_) {
    _name = name_;
    _symbol = symbol_;
}
```

Just like the ERC20, we need to give our token a name and a symbol, that makes sense. Feel free to choose your own, but I'm going to go with the name `Doggie` and the symbol `DOG`.

```solidity
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

pragma solidity ^0.8.18;

contract BasicNft is ERC721 {

    constructor() ERC721("Doggie", "DOG"){}
}
```

Great! While this contract may have the basic functionality of an NFT protocol, there's a lot to be done yet. Because each token is unique and possesses a unique tokenId, we absolutely need a token counter to track this in storage. We'll increment this each time a token is minted.

```solidity
uint256 private s_tokenCounter;

constructor() ERC721("Doggie", "DOG"){
    s_tokenCounter = 0;
}
```

### TokenURI

It's hard to believe, but once upon a time the tokenUri was once considered an optional parameter, despite being integral to how NFTs are used and consumed today.

TokenURI stands for Token Uniform Resource Identifier. At its core it serves as an endpoint that returns the metadata for a given NFT.

**Example TokenURI Metadata Schema:**

```Solidity
{
    "title": "Asset Metadata",
    "type": "object",
    "properties": {
        "name": {
            "type": "string",
            "description": "Identifies the asset to which this NFT represents"
        },
        "description": {
            "type": "string",
            "description": "Describes the asset to which this NFT represents"
        },
        "image": {
            "type": "string",
            "description": "A URI pointing to a resource with mime type image/* representing the asset to which this NFT represents. Consider making any images at a width between 320 and 1080 pixels and aspect ratio between 1.91:1 and 4:5 inclusive."
        }
    }
}
```

It's this metadata that defines what the properties of the NFT are, including what it looks like! In fact, if you go to **[OpenSea](https://opensea.io/)** and look at any NFT there, all the the data and images you're being served come from calls to the tokenURI function.

What this means to us is - any time someone mints a Doggie NFT, we need to assign a TokenURI to the minted TokenID which contains all the important information about the Doggie. Let's consider what this function would look like.

> ❗ **NOTE**
> The OpenZeppelin implementation of ERC721, which we've imported, has it's own virtual tokenURI function which we'll be overriding.

By navigating to any NFT on OpenSea, you can find a link to the collection's contract on Etherscan. Click on `Read Contract` and find the tokenURI function (here's a link to **[Pudgy Penguins](https://etherscan.io/address/0xbd3531da5cf5857e7cfaa92426877b022e612cf8#readContract)** if you need it).

Entering any valid tokenId should return the TokenURI of that NFT!

<img src="./images/foundry-setup1.png" alt="foundry-setup1" />

By opening this URI in your browser, the details of that token's metadata should be made available:

<img src="./images/foundry-setup2.png" alt="foundry-setup2" />

Note the imageURI property. This is what defines what the NFT actually looks like, you can copy this into your browser as well to view the NFT's image.

<img src="./images/foundry-setup3.png" alt="foundry-setup3" />

Both the tokenUri and imageUri for this example are hosted on IPFS (Inter-planetary file system), a service offering decentralized storage that we'll go into in greater detail, in the next lesson.

So what's this tokenURI function going to look like for us? Well, our BasicNFT is going to also use IPFS, so similarly to our example above, we'll need to set up our function to return this string, pointing to the correct location in IPFS.

```solidity
function tokenURI(uint256 tokenId) public view override returns (string memory) {}
```

Now, I've prepared some images you can choose from to use in your project

<img src="./images/foundry-setup4.png" alt="foundry-setup4" />

Create a new folder in your workspace names `images` (image) and add the image of your choice to this directory.

## IPFS

Let's dive into the Interplanetary File System (IPFS), how it works and what it means for decentralization of data. You can find additional information in the **[IPFS documentation](https://docs.ipfs.io/)**

So, how does IPFS work?

It all starts with the data we want hosted. This can be more or less anything, code, images, some other file, it doesn't matter. As we know, any data can be hashed and this is essentially what IPFS Node's do initially. We provide our data to the IPFS network via a Node and the output is a unique hash that points to the location and details of that data.

Each IPFS Node is once part of a much larger network and each of them constantly communicates to distribute data throughout the network. Any given node can choose to pin particular pieces of data to host/persist on the network.

> ❗ **NOTE**
> IPFS isn't able to execute logic or perform computation, it only serves as a means of decentralized storage

What we would do then is upload our data to IPFS and then pin it in our node, assuring that the IPFS Hash of the data is available to anyone calling the network.

<img src="./images/ipfs/ipfs1.png" alt="ipfs1" />

Importantly, unlike a blockchain, where every node has a copy of the entire register, IPFS nodes can choose what they want to pin.

### Using IPFS

There are a few ways to actually use IPFS including a CLI installation, a browser companion and even a dedicated desktop application.

Let's go ahead and **[install the IPFS Desktop application](https://docs.ipfs.tech/install/ipfs-desktop/)**. Once installed you should be able to open the application and navigate to a files section that looks like this:

<img src="./images/ipfs/ipfs2.png" alt="ipfs2" />

Pay no mind to all my pictures of cats. If you have no data to view, navigate to import in the top right and select any small file you don't mind being public.

> ❗ **IMPORTANT**
> Any data uploaded to this service will be _**public**_ by nature.

<img src="./images/ipfs/ipfs3.png" alt="ipfs3" />

Once a file is uploaded, you can click on that file and view that data.

<img src="./images/ipfs/ipfs4.png" alt="ipfs4" />

What makes this _really_ cool, is we can then copy the data's CID (content ID), as seen above and view our data within our browser by entering it into our address bar.

```Solidity
ipfs://<CID>
```

> ❗ **NOTE**
> If you're on firefox, this may not display properly as the address bar converts URLs to lowercase by default, ruining our CID. Test on Brave or Chrome.

Alternatively, if you're having trouble viewing your data directly from the IPFS network you can use the IPFS Gateway. When using a gateway, you're not directly requesting the data from the IPFS Network, you're requesting through another server which makes the request on your behalf, so it brings to question centrality and things again, but I digress. You can view the data via the Gateway with this syntax:

```Solidity
https://ipfs.io/ipfs/<CID>
```

<img src="./images/ipfs/ipfs5.png" alt="ipfs5" />

## Upload and use IPFS data (token URI)

In a previous lesson we discussed tokenUris and I walked you through an example of viewing the TokenURI of a token on OpenSea.

```js
{
  "attributes": [
    {
      "trait_type": "Background",
      "value": "Mint"
    },
    {
      "trait_type": "Skin",
      "value": "Dark Gray"
    },
    {
      "trait_type": "Body",
      "value": "Turtleneck Pink"
    },
    {
      "trait_type": "Face",
      "value": "Blushing"
    },
    {
      "trait_type": "Head",
      "value": "Headband"
    }
  ],
  "description": "A collection 8888 Cute Chubby Pudgy Penquins sliding around on the freezing ETH blockchain.",
  "image": "ipfs://QmNf1UsmdGaMbpatQ6toXSkzDpizaGmC9zfunCyoz1enD5/penguin/420.png",
  "name": "Pudgy Penguin #420"
}
```

> ❗ **NOTE** <br />
> Notice how the `image` property has _its own_ IPFS hash! This is storing what the NFT looks like!

The Pudgy Penguins collection had been using IPFS's Gateway to access their images within the TokenURI

```js
'https://ipfs.io/ipfs/QmNf1UsmdGaMbpatQ6toXSkzDpizaGmC9zfunCyoz1enD5/penguin/420.png';
```

This works, and is often leveraged due to browser compatibily with IPFS, but it's worth noting that this is pointing to a centralized server. If that server goes down, the image data will be unretrievable via the tokenURI call!

A more decentralized way to retrieve the image data is by pointing to the IPFS netwok itself.

```js
'ipfs://QmNf1UsmdGaMbpatQ6toXSkzDpizaGmC9zfunCyoz1enD5/penguin/420.png';
```

### Doggies

With a better understanding of IPFS and decentralized storage in hand, let get back to our BasicNFT contract. If you want, you can upload your image to IPFS to acquire your own hash. Alternatively, if you want to make things easy on yourself:

```js
'ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json';
```

If you view this in your browser or through the IPFS Desktop App, you should see the tokenURI of our Doggie NFT, it's even got an image assigned already.

> ❗ **PROTIP** <br />
> If you do decide to upload your own data to IPFS, you'll need to upload your image first to acquire an imageURI/hash. You'll then upload a tokenURI json containing this pointer to your image.

```js
{
    "name": "PUG",
    "description": "An adorable PUG pup!",
    "image": "https://ipfs.io/ipfs/QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8?filename=pug.png",
    "attributes": [
        {
            "trait_type": "cuteness",
            "value": 100
        }
    ]
}
```

Now, we could just paste the about tokenURI as a return value of our tokenUri function, but this would mint every Doggie identical to eachother. Let's spice things up a little bit and allow the user to choose what their NFT looks like. We'll do this by allowing the user to pass a tokenUri to the mint function and mapping this URI to their minted tokenId.

```js
contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    constructor() ERC721("BasicNFT", "BFT") {
        s_tokenCounter = 0;
    }

    function mintNFT(string memory tokenUri) public returns (uint256) {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }
}
```

Great! All that's missing is to mint the NFT and increment our token counter. We can mint the token by calling the inherited \_safeMint function.

```js
contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    constructor() ERC721("BasicNFT", "BFT") {
        s_tokenCounter = 0;
    }

    function mintNFT(string memory tokenUri) public returns (uint256) {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }
}
```

## Deploy Script

The muscle memory should be kicking in for some of these deploy scripts by now. Let's not waste any time setting this one up! Create a new file `script/DeployBasicNft.s.sol`.

```js
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract DeployBasicNft is Script {
    function run() external returns (BasicNft){
        vm.startBroadcast();
        BasicNft basicNft = new BasicNft();
        vm.stopBroadcast();
        return basicNft;
    }
}
```

That's literally all there is to it. Run a quick `forge compile` as a sanity check to assure things build.

## Test the NFTs smart contract

Once the setup is complete, it's time to jump into tests. Writing an array of tests serves to validate the functionality of our contract, we'll start with something simple and verify that our NFT name is set correctly.

Start with the usual boilerplate for our test contract. Create the file `test/BasicNftTest.t.sol`. Our test contract will need to import BasicNft, and our deploy script as well as import and inherit Foundry's `Test.sol`.

```js
//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {DeployBasicNft} from "../script/DeployBasicNFT.s.sol";

contract BasicNFTTest is Test {
  DeployBasicNft public deployer;
  BasicNFT public basicNft;

  function setUp() public {
      deployer = new DeployBasicNft();
      basicNft = deployer.run();
  }
}
```

To confirm that the Name of your NFT is correct, declare a function `testNameIsCorrect` and specify it as public view.

```js
function testNameIsCorrect() public view {
  string memory expected = "Doggie";
  string memory actual = basicNft.name();
  assert(expected == actual);
}
```

Now, you may believe that we can simply do something like the above. We know the ERC721 standard allows us to call the `name` function to verify what what set, so that should be it, right?

We actually run into an issue here.

<img src='./images/basic-nft-tests1.png' alt='basic-nft-tests1' />

### Comparing Strings

If you recall from previous lessons, strings are actually a special data type. Under the hood, strings exist as an array of bytes, arrays can't be compared to arrays in this way, this is limited to primitive data types. Primitive data types include things like int, bool, bytes32, address etc.

So, how do we compare these strings? Since it's an array, we could loop through the elements of the array and compare each of them. This is entirely doable, but it's computationally expensive and going take a long time if the strings were very large!

A more elegant approach would be to encode each of our string objects into a hash and compare the hashes.

This is a point where I may use Foundry's tool, chisel, to sanity check myself as I go.

```bash
chisel
```

Use chisel to create a couple simple strings

```bash
string memory cat = "cat";
string memory dog = "dog";
```

Now if you type `cat`, you should get a kinda crazy output that's representing the hex of that string.

<img src='./images/basic-nft-tests2.png' alt='basic-nft-tests2' />

We'll leverage abi.encodePacked to convert this to bytes, then finally we can use keccak256 to hash the value into bytes32, which we can can use in our value comparison.

<img src='./images/basic-nft-tests3.png' alt='basic-nft-tests3' />

> ❗ **NOTE**
> I know we haven't covered encoding or abi.encodePacked in great detail yet, but don't worry - we will.

If we apply this encoding and hashing methodology to our BasicNft test, we should come out with something that looks like this:

```js
function testNameIsCorrect() public view {
  string memory expectedName = "Doggie";
  string memory actualName = basicNft.name();

  assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
}
```

In the above, we're encoding and hashing both of our strings before comparing them in our assertion. Now, if we run our test with `forge test --mt testNameIsCorrect`...

<img src='./images/basic-nft-tests4.png' alt='basic-nft-tests4' />

Great work! Let's write a couple more tests together.

### Testing Mint and Balance

The next test we write will assure a user can mint the NFT and then change the user's balance. We'll need to create a user to prank in our test. Additionally, we'll need to provide our mint function a tokenUri, I've provided one below for convenience. If you've one prepared from the previous lesson, feel free to use it!

```js
contract BasicNftTest is Test {
  ...
  address public USER = makeAddr("user");
  string public constant PUG =
      "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
  ...
  function testCanMintAndHaveABalance() public {
    vm.prank(USER);
    basicNft.mintNft(PUG);

    assert(basicNft.balanceOf(USER) == 1);
    assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
  }
}
```

With this, we again should just be able to run `forge test` and see how things resolve.

<img src='./images/basic-nft-tests5.png' alt='basic-nft-tests5' />

## Basic NFT Interactions

Alright, with our tests passing we're going to want a way to interact with our contract programmatically. We could use `cast` commands, but let's write an interactions script instead. Create the file `script/Interactions.s.sol`. You know the drill for our boilerplate by now.

```js
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";

contract MintBasicNft is Script{
    function run() external {}
}
```

We know we'll always want to be interacting with the latest deployment, so let's install the `foundry-devops` library to help with this.

```bash
forge install Cyfrin/foundry-devops --no-commit
```

Now, we can import `DevOpsTools` and use this to acquire our most recent deployment. We'll use this address as a parameter for the `mint` function we'll call.

> ❗ **NOTE**
> I've copied over my `PUG tokenUri` for use in our `mint` function, remember to copy your own over too!

```js
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script{

    string public constant TOKENURI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);

        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(TOKENURI);
        vm.stopBroadcast();
    }
}
```

> ❗ **PROTIP**
> Remember, if you don't recall which parameters are required for a function like `get_most_recent_deployment` you can `ctrl + left-click` (`cmd + click`) to be brought to the function definition.

## Basic NFT Testnet Demo

Seeing our NFT minting in our tests is cool and all, but to really appreciate them, we want to see them in our wallet. We want to see the art _in_ Metamask, _on_ OpenSea, we gotta make it real.

So let's do that.

Before we get started, I'll mention you don't _have_ to do this yourself. This process will cost testnet funds, so it's fine to just follow along if needed. An alternative way to view your NFT would be to import your Anvil chain into Metamask and continue to use your local blockchain. If that works for you, great! Otherwise, let's continue with deploying this on an actual testnet.

We'll be leveraging a Makefile for this again, I'll just be copying mine from the GitHub repo associated with this course, I've also provided it below for your convenience.

Makefile:

```make
-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

help:
	@echo "Usage:"
	@echo "  make deploy [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""
	@echo ""
	@echo "  make fund [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install Cyfrin/foundry-devops@0.0.11 --no-commit && forge install foundry-rs/forge-std@v1.5.3 --no-commit && forge install openzeppelin/openzeppelin-contracts@v4.8.3 --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deploy:
	@forge script script/DeployBasicNft.s.sol:DeployBasicNft $(NETWORK_ARGS)

Mint:
    @forge script script/Interactions.s.sol:MintNFT ${NETWORK_ARGS}

deployMood:
	@forge script script/DeployMoodNft.s.sol:DeployMoodNft $(NETWORK_ARGS)

mintMoodNft:
	@forge script script/Interactions.s.sol:MintMoodNft $(NETWORK_ARGS)

flipMoodNft:
	@forge script script/Interactions.s.sol:FlipMoodNft $(NETWORK_ARGS)
```

Assuming our `.env` is ready to go, we should be able to run the following...

> ❗ **PROTIP**
> Remember to add the required environment variables if necessary. You should need a `sepolia RPC-URL`, an `account private key` and an `etherscan api key`.

```bash
make deploy ARGS="--network sepolia"
```

<img src='./images/testnet-demo/testnet-demo1.png' alt='testnet-demo1' />

With a contract deployed, this transaction data, including the contract address is added to our `broadcast` folder within run-latest.json. This is how our `DevOpsTool` acquires the most recent contract deployment. We should now be able to use our `Interactions.s.sol` script to mint ourselves an NFT.

> ❗ **IMPORTANT**
> Add `fs_permissions = [{ access = "read", path = "./broadcast" }]` to your `foundry.toml` or DevOpsTools won't have the permissions necessary to function correctly! This is more safe than `FFI=true`.

```bash
make mint ARGS="--network sepolia"
```

While this is minting, we can navigate to our Metamask wallet and import our NFT Token. Grab the address of the contract we deployed from Etherscan (or `broadcast/DeployBasicNft.s.sol/11155111/run-latest.json`).

<img src='./images/testnet-demo/testnet-demo2.png' alt='testnet-demo2' />

Enter the contract address and a tokenId of `0` when prompted. Then, after a brief wait...

<img src='./images/testnet-demo/testnet-demo3.png' alt='testnet-demo3' />

We can see our NFT in our wallet!!!

### Wrap Up

Amazing work! We've deployed an NFT protocol to a testnet, we've minted ourselves an NFT programmatically, and we've imported that Token right into our wallet. Our adorable Pup is our to do with as we please!

We've learnt so much already and you should be very proud, but it's not time to stop yet. In the next lesson we'll discuss the pros and cons of data storage and the services and methodologies available to us.

<img src='./images/testnet-demo/testnet-demo4.png' alt='testnet-demo4' />

While testing is a vital part of NFT creation, deploying it in a real use case can bring more clarity to your understanding. Luckily, there are several ways to deploy your NFT. You could consider using Anvil, your own Anvil server, or a testnet. If you're not keen on waiting for the testnet or spending the gas, I'd recommend deploying it to Anvil.

The processes detailed below are optional, but feel free to follow along if you'd like.

### Using a Makefile for Quick Deployment

Rather than typing out long scripts, we'll use a makefile here. The associated Git repo contains the makefile we're using, allowing you to simply copy and paste rather than rewriting everything.

In the makefile, we've captured most of the topics we've discussed so far, including our deploy script, which we'll use to deploy our basic NFT.

Here is what the deploy script looks like:

```makefile
deploy:
	@forge script script/DeployBasicNft.s.sol:DeployBasicNft $(NETWORK_ARGS)
```

It's important here to ensure you have included your environmental variables.

It's noteworthy that you should write some tests before deploying on a testnet, although for the sake of showing you what the NFT looks like, we'll skip this step in this instance.

## Deploying Our Basic NFT

We're now going to deploy our basic NFT to the contract address. After successful deployment, there will be a short wait for its verification.

### Extracting Contract Info and Minting

With our NFT deployed, we'll now move to extract our contract data. In the broadcast folder, the latest run contains the created basic NFT information. We'll execute the following command to initiate the Mint function:

```makefile
mint:
    @forge script script/Interactions.s.sol:Interactions $(NETWORK_ARGS)
```

The DevOps tool works by grabbing the most recent contract from this folder, thus automating the process.

## Importing NFT into MetaMask

While the NFT is being minted, let's transition to MetaMask:

1. Copy the contract address under which the NFT was deployed.
2. From MetaMask, go to NFTs and switch to Sepolia.
3. Click on Import NFTs and paste the copied address.
4. Since we're the first to create this NFT, the token ID will be zero. Input this and hit 'Add'.

After a short wait, your NFT will be viewable right from your MetaMask wallet. It's intelligent enough to extract the token URI, allowing you to view the image, contract address, or send it elsewhere.

Congratulations! You've successfully deployed and imported an NFT into MetaMask. You can now interact with it just as you would in a marketplace like OpenSea. Through this process, you've learned how to make an NFT come to life, from being just a script to being part of the real-world, bridging the gap between test environments and real applications.

Stay tuned for our next post on advanced NFT creation steps, such as a complete DeFi app development and more.

## IPFS and Pinata vs HTTP vs on chain SVGs

### The issue with IPFS vs HTTPS

In this lesson we'll discuss two ways we can reference our data in `IPFS` and ways we can strengthen the hosting of it to ensure it's always made available.

First things first: Let's discuss the **InterPlanetary File System (IPFS)** and the pros and cons associated with it.

### IPFS

We learnt previously that there are two ways to reference the location of data hosted by `IPFS`. We can point directly to the `IPFS` network with the syntax `ipfs://<CID>` _or_ we can use the `IPFS Gateway` and point to an IPFS server via `https://ipfs.io/ipfs/<CID>`.

There are some important considerations to keep in mind here. If we decide to use the `IPFS Gateway`, this is essentially pointing to a website hosted on a server by `IPFS`. If this website or server goes down for any reason the data we're pointing to will be unretrievable!

Imagine losing the art of your NFT forever!

A safer methodology is pointing to the `IPFS` network directly, but this comes with caveats. While the URI is pointing to a decentralized network, assuring the data is accessible so long as a node is still hosting it, most browsers and services don't natively support interfacing with the `IPFS` network. This can make viewing and interacting with your NFT cumbersome.

In addition to the above, the `IPFS` network doesn't automatically distribute all data amongst all nodes on the network (like a blockchain would). Instead it relies on nodes pinning the data they find valuable to assure it's available to the rest of the network. If I'm the only person pinning my data on `IPFS`, I'm not any more decentralized than using the `IPFS Gateway`.

_**So, how do we solve this?**_

### Pinning Services

Fortunately, there are services available which developers can use to pin their data for them, decentralizing access to it. One such service is **[Pinata.cloud](https://www.pinata.cloud/)**.

<img src='./images/ipfs-https/ipfs-https1.png' alt='ipfs-https1' />

Once an account is created and you've logged in, the UI functions much like an `IPFS` node and you can simply upload any files you want the service to pin on your behalf.

<img src='./images/ipfs-https/ipfs-https2.png' alt='ipfs-https2' />

Once uploaded, `Pinata` will provide a `CID`, just like `IPFS` itself will.

<img src='./images/ipfs-https/ipfs-https3.png' alt='ipfs-https3' />

> ❗ **PROTIP**
> Whenever I work on a project, I will upload my images/data both to my local `IPFS` node as well as `Pinata` to assure the data is always pinned _somewhere_.

<img src='./images/ipfs-https/ipfs-https4.png' alt='ipfs-https4' />
