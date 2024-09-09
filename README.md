# Gas comparison of rust stylus and solidity contracts

This repo illustrates comparison of gas consumption between rust Arbitrum Stylus and solidity contracts.

Benchmark idea based on [WELLDONE STUDIO benchmarks](https://docs.welldonestudio.io/tutorials/arbitrum-stylus-benchmark/), and extended with tests of rust native hash [tiny keccak](https://docs.rs/tiny-keccak/latest/tiny_keccak/) and cached contracts benchmarks.

There are two types of contracts for benchmarking:

- Hash Storage contract that computes keccak hash once and stores it.
- Hash Storage 1000 contract that computes hash for 1000 iterations and stores it.

## Set up

### Environment

Add to `.env` file valid account private key and corresponding address according to `.env.tmpl` file.
Rpc url for local nitro node should be indicated at `.env` file like that:

```shell
RPC_URL=http://localhost:8547
```

### Run nitro test node

Note: Make sure no other instances of nitro test node run at the same time.

```shell
./scripts/nitro-testnode.sh -i -d
```

### Fund account

Fund account indicated at `.env` file with `10000` ether.

```shell
./scripts/fund-account.sh
``` 

## Running gas comparison benchmarks

For instance, deploying stylus hash-storage contract with compiled keccak:

```shell
./scripts/stylus-compiled-keccak/hs-deploy.sh # copy deployed address
```

Caching contract for optimized gas consumption:

p.s. copy the deployment address and pass it as env variable to `estimate-gas.sh` script.

```shell
export DEPLOYMENT_ADDRESS=<deployed contract address> # paste address of contract deployed
./scripts/cache-contract.sh
```

Checking gas estimate for `storeHash(string)` transaction:

```shell
export DEPLOYMENT_ADDRESS=<deployed contract address> # paste address of the contract deployed
./scripts/estimate-gas.sh
```

p.s. directory `./scripts/solidity` contains deployment scripts for Hash Storage and Hash Storage 1000 contracts.
Folders `./scripts/stylus-compiled-keccak` and `./scripts/stylus-tiny-keccak` have deployment scripts for the same
contracts (but on rust) with default compiled keccak and tiny keccak hashes respectively.

## Results

### Gas estimates

| Contract                                      | Default  | Cached   |
|-----------------------------------------------|----------|----------|
| Stylus Hash Storage with compiled keccak      | `59180`  | `45989`  |
| Stylus Hash Storage with tiny keccak          | `60024`  | `46560`  |
| Stylus Hash Storage 1000 with compiled keccak | `74741`  | `61067`  |
| Stylus Hash Storage 1000 tiny keccak          | `306585` | `291905` |
| Solidity Hash Storage                         | `44785`  | -        |
| Solidity Hash Storage 1000                    | `235122` | -        |

### Summary
Compiled keccak definitely can beat solidity when called multiple times. For short computations, solidity performs slightly better. The Cached rust contract has shown nearly the same gas usage as its solidity counterpart.

Caching showed gas optimization from 22% to 5%. The most computationally intensive contract (Hash Storage 1000) had the worst optimization (5%).

Cached tiny keccak hash storage contract that computes hash 1000 times performed 20% worse than its solidity counterpart. But this comparison is a bit unfair since keccak at solidity should be precompiled. Tiny keccak has pure rust implementation.