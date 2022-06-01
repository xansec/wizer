#![no_main]

use libfuzzer_sys::fuzz_target;
use wizer::Wizer;


fuzz_target!(| data | {
    let _ = Wizer::new()
        .run(&data);
    });
