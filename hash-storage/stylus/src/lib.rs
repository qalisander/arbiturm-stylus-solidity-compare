#![cfg_attr(not(feature = "export-abi"), no_main)]
extern crate alloc;

use stylus_sdk::{crypto::keccak, prelude::*, storage::StorageFixedBytes};

sol_storage! {
    #[entrypoint]
    pub struct HashStorage {
        StorageFixedBytes<32> h;
    }
}

#[public]
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
