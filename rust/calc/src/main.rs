use std::io;

fn read_something() -> String {
    let mut buffer = String::new();
    io::stdin().read_line(&mut buffer)
    	.unwrap();
    // trim() returns a &str, but that's just a reference.
    // So if we just return a &str then the String we allocated
    // goes poof and it's invalid.  I think.
    // to_owned() turns a &str into a String.
    // Possibly by copying.
    buffer.trim().to_owned()
}

fn main() {
	let mut buffer : Vec<String> = Vec::new();
    loop {
	    println!("Type something!");
		let res = read_something();
		if res != "" {
			buffer.push(res);
		}
		println!("You typed: {:?}", buffer);
	}
}
