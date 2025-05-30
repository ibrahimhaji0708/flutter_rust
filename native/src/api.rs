// use std::sync::atomic::{AtomicUsize, Ordering};
// use once_cell::sync::Lazy;

// static COUNTER: Lazy<AtomicUsize> = Lazy::new(|| AtomicUsize::new(0));

// pub fn increment_counter() -> usize {
//     COUNTER.fetch_add(1, Ordering::SeqCst)
// }

// pub fn decrement_counter() -> usize {
//     COUNTER.fetch_update(Ordering::SeqCst, Ordering::SeqCst, |x| {
//         if x == 0 {
//             None
//         } else {
//             Some(x - 1)
//         }
//     }).unwrap_or_else(|x| x)
// }


static mut COUNTER: i32 = 0;

pub fn increment_counter() -> i32 {
    unsafe {
        COUNTER += 1;
        COUNTER
    }
}

pub fn decrement_counter() -> i32 {
    unsafe {
        COUNTER -= 1;
        COUNTER
    }
}
