---
title: Why is IBC Needed?
slug: why-is-ibc-needed
order: 3
---
Since the launch of the Bitcoin blockchain in 2009, hundreds of blockchains have been deployed. However, without a proper messaging protocol, these blockchains are condemned to remain isolated from each other. Early interoperability solutions have tried to address some very specific use cases, like Atomic Swaps, but they remain limited and hard to generalize to various types of blockchain networks.

Over time, the need for a standardized interoperability solution for blockchains has emerged. Not a solution tailored for a specific interoperability use case, or for a specific set of blockchains, but a generic solution applicable to a myriad of use cases and blockchain frameworks. This is exactly what IBC aims to achieve.

As an analogy, just like TCP/IP is a messaging protocol to connect servers and computers with different hardware implementations, geographical locations and operating systems, IBC intends to connect blockchains with different consensus algorithms and state-machines. Likewise, TCP/IP is payload-agnostic, meaning different applications can be built on top (HTTP, FTP, …), and so is IBC. Indeed, any cross-chain application can be built on top of IBC, such as cross-chain token transfers, multichain smart contract applications, or decentralized oracles. The role of IBC is to take care of the messaging part (including data transport, authentication and ordering), in order for developers to focus on building applications.
