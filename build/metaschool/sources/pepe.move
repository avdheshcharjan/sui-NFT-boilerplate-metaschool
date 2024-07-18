module metaschool::pepe{
    use std::option;
    use sui::coin;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::url::{Self, Url};

    // Name matches the module name but in UPPERCASE
    public struct PEPE has drop {}

    // Module initializer is called once on module publish.
    // A treasury cap is sent to the publisher, who then controls minting and burning.
    fun init(witness: PEPE, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(witness, 9, b"PE", b"PEPE", b"", option::some(url::new_unsafe_from_bytes(b"https://bafybeihpnhd5tazx2eanltsujuy5uxod3vxtvw2mbhibot66hqqz6rtkke.ipfs.w3s.link/image%20(1).png")), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx))
    }

    public entry fun mint(
        treasury: &mut coin::TreasuryCap<PEPE>, amount: u64, recipient: address, ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury, amount, recipient, ctx)
    }
}
