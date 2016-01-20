use std::thread;

#[test]
fn it_works() {
}

#[no_mangle]
pub fn process() {
	let handles: Vec<_> = (0..10).map(|_| {
		thread::spawn(|| {
			let mut x = 0;
			for _ in 0..500000000 {
				x += 1
			}
			x
		})
	}).collect();

	for h in handles {
		println!("Thread finished with count {}",
			h.join().map_err(|_| "Could not join a thread!").unwrap());
	}
}