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

* Non-fungible: This means they are explicitly unique from one another and one NFT cannot be interchanged with another

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

* Upload NFT Image to IPFS
* Create metadata point to that image
* Set the NFTs tokenUri to point to that metadata

```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
