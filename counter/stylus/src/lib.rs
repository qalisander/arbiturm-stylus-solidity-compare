#![cfg_attr(not(feature = "export-abi"), no_main)]
extern crate alloc;

#[global_allocator]
static ALLOC: mini_alloc::MiniAlloc = mini_alloc::MiniAlloc::INIT;

use stylus_sdk::{alloy_primitives::U256, prelude::*};

sol_storage! {
    #[entrypoint]
    pub struct Counter {
        uint256 number;
    }
} 

#[external]
impl Counter {
    pub fn increment(&mut self) {
        let number = self.number.get();
        self.number.set(number + U256::from(1));
    }

    pub fn set_count(&mut self, new_number: U256) {
        self.number.set(new_number);
    }

    pub fn number(&self) -> U256 {
        self.number.get()
    }
}
