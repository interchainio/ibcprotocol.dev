---
title: What is a relayer ?
slug: what-is-a-relayer
order: 8
---
In the IBC architecture, blockchains are not directly sending messages to each other over networking infrastructure (they are push-based system), but rather are creating messages to be sent which are then physically relayed from one ledger to another by monitoring “relayer processes”. IBC assumes the existence of a set of relayer processes with access to an underlying network protocol stack (likely TCP/IP, UDP/IP, or QUIC/IP) and physical interconnect infrastructure. These relayer processes continuously scan the state of ledgers that implement the IBC protocol and relay packets when needed to request transaction execution on connected ledgers when outgoing packets have been committed. Running relayers is open to everyone, and may be rewarded with a small transaction fee depending on the implementation of each ledger.

Note that relayers cannot modify IBC packets, as each IBC packet is verified using light-clients by the receiving chain before being committed.

[Example implementation of a relayer ](https://github.com/cosmos/relayer)
