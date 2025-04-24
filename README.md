## 发行一个自己的代币 CC

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script ./script/CC.s.sol:CCScript --rpc-url 127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast
```

### 查看代币发行的总量
```shell
cast call --rpc-url 127.0.0.1:8545 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 "totalSupply()(uint256)"
```

### 执行 mint
```shell
cast send --rpc-url 127.0.0.1:8545  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 "mint(address,uint256)" 0xee2E207D30383430a815390431298EBa3c1C8c2d 100000000
```

### 查看地址里面该代币数量
```shell
cast call --rpc-url 127.0.0.1:8545 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 "balanceOf(address)(uint256)" 0xee2E207D30383430a815390431298EBa3c1C8c2d
```

### 转账
```shell
cast send --rpc-url 127.0.0.1:8545  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 "transfer(address,uint256)" 0xee2E207D30383430a815390431298EBa3c1C8c2d 100000000```
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
