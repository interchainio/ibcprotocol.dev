---
title: How does IBC Work?
slug: how-does-ibc-work
order: 4
---
IBC is modeled after TCP/IP and includes a number of similar steps. Initially a handshake takes place between two separate blockchains (and/or solo machines). This handshake consists of a series of transactions submitted to each blockchain, where each transaction contains information and proofs about the state of the other chain. The handshake serves to allow both chains to authenticate each other, ensure that they are using the correct identifiers, and prepare to send and receive packets safely.

Once this handshake occurs, subsequent data packets can be relayed between the chains via transactions Packets contain arbitrary serialized data (for example, a packet could contain information about a token transfer or a smart contract function to be executed) as well as further metadata information that can be used to verify that the packet came from the origin chain. This verification step involves the use of efficient light clients for the consensus mechanisms of each chain. 

IBC guarantees that the relayed packet can be trusted as having been sent by the source chain, but the protocol is agnostic as to the semantics of the data transported. This transported data is processed by the application layer, where it is deserialized, interpreted, and executed like a normal transaction. 

There are a variety of options for routing IBC packets that include timeout requirements and ordering guarantees so that if a series of packets need to come together within a certain time and in a certain order, they can do so or acknowledge the failure to do so. Many IBC connections can exist between two chains, and within those connections many namespaced routes allow different types of IBC packets to access different parts of the underlying state machine.

