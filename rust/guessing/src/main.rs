use std::io;

fn main() {
    println!("Guess a number!");
    let mut guess = String::new();
    io::stdin().read_line(&mut guess)
    	.ok()
    	.expect("Failed to read line?");
    println!("You typed: {}", guess);
}
