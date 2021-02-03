---
title: What is a relayer?
slug: what-is-a-relayer
order: 8
---
A relayer process is an off-chain process responsible for relaying IBC packet data & metadata between two or more machines by scanning their states & submitting transactions.

In practice, relayers are programs that listen for specific IBC events pushed on IBC-enabled chains and, if the event requires a certain action to be taken (such as relaying an IBC packet to another IBC-enabled chain), relayers take these required actions.

[Example implementation of a relayer ](https://github.com/cosmos/relayer)
