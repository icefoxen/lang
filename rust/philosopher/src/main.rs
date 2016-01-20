use std::thread;
use std::sync::{Mutex, Arc};

struct Table {
	forks: Vec<Mutex<()>>,
}

impl Table {
	fn new(count: usize) -> Table {
		Table {
			forks: vec![],
		}
	}
}

struct Philosopher {
	name: String,
	left: usize,
	right: usize,
}

impl Philosopher {
	fn new(name: &str, left: usize, right: usize) -> Philosopher {
		Philosopher {
			name: name.to_string(),
			left: left,
			right: right,
		}
	}

	fn eat(&self, table: &Table) {
		let _left = table.forks[self.left].lock().unwrap();
		thread::sleep_ms(150);
		let _right = table.forks[self.right].lock().unwrap();

		println!("{} is eating.", self.name);
		thread::sleep_ms(1000);
		println!("{} is done eating.", self.name);
		// Locks get released when _left and _right go out of scope, huzzah.
	}
}

fn main() {
	let table = Arc::new(Table { forks: vec![
		Mutex::new(()),
		Mutex::new(()),
		Mutex::new(()),
		Mutex::new(()),
		Mutex::new(()),
	]});

	let philosophers = vec! [
		Philosopher::new("Judith Butler", 0, 1),
		Philosopher::new("Gilles Deleuze", 1, 2),
		Philosopher::new("Karl Marx", 2, 3),
		Philosopher::new("Emma Goldman", 3, 4),
		// Mr. Foucault is left handed; this prevents deadlock.
		Philosopher::new("Michel Foucault", 0, 4),
	];

	let handles : Vec<_> = philosophers.into_iter().map(|p| {
		// clone() doesn't actually copy it, but bumps up the reference count
		let table = table.clone();
		thread::spawn(move || {
			p.eat(&table);
		})
	}).collect();

	for h in handles {
		h.join().unwrap();
	}
}