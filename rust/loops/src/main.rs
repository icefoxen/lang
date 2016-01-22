fn main() {
	// Playing with iterators
	for i in (1..).take(5) {
		println!("{}", i);
	}

	for i in (1..100).filter(|&x| x % 9 == 0) {
		println!("{}", i);
	}
}
