#![feature(old_io)]
use std::old_io;

fn main() {
    println!("Type something!");
    let input = old_io::stdin().read_line().ok().expect("Failed to read line?");
    println!("You typed: {}", input);
}
