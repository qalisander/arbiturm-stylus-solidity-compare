#![cfg_attr(not(feature = "export-abi"), no_main)]
extern crate alloc;

use stylus_sdk::{crypto::keccak, prelude::*, storage::StorageFixedBytes};

#[global_allocator]
static ALLOC: mini_alloc::MiniAlloc = mini_alloc::MiniAlloc::INIT;

sol_storage! {
    #[entrypoint]
    pub struct HashStorage {
        StorageFixedBytes<32> h;
    }
}

#[external]
impl HashStorage {
    pub fn store_hash(&mut self, input: String) {
        let hash = keccak(input.as_bytes());
        self.h.set(hash.into());
    }

    pub fn get_hash(&self) -> String {
        let h = self.h.get();
        hex::encode(h)
    }
}
