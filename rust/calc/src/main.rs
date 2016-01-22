
use std::io;
use std::collections::HashMap;

type Operation = fn(&mut Vec<f64>) -> ();
type OpMap = HashMap<String, Operation>;

fn add(stack: &mut Vec<f64>) {
	let n1 = stack.pop().unwrap();
	let n2 = stack.pop().unwrap();
	stack.push(n1 + n2);
}

fn sub(stack: &mut Vec<f64>) {
	let n1 = stack.pop().unwrap();
	let n2 = stack.pop().unwrap();
	stack.push(n2 - n1);
}

fn mul(stack: &mut Vec<f64>) {
	let n1 = stack.pop().unwrap();
	let n2 = stack.pop().unwrap();
	stack.push(n1 * n2);
}

fn div(stack: &mut Vec<f64>) {
	let n1 = stack.pop().unwrap();
	let n2 = stack.pop().unwrap();
	stack.push(n2 / n1);
}

fn make_operations() -> OpMap {
	let mut map : OpMap = HashMap::new();
	map.insert("+".to_owned(), add);
	map.insert("-".to_owned(), sub);
	map.insert("*".to_owned(), mul);
	map.insert("/".to_owned(), div);
	map
}

fn do_operation(ops : &OpMap, stack: &mut Vec<f64>, op: &str) {
	match ops.get(op) {
		Some(func) => func(stack),
		None => println!("Unknown operation: {}", op)

	}
}

fn read_line() -> String {
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
	let mut stack : Vec<f64> = Vec::new();
	let operations = make_operations();
    loop {
		println!("Stack is: {:?}", stack);
		let res = read_line();
			for item in res.split_whitespace() {
			if item != "" {
				match item.parse::<f64>() {
					Ok(num) => stack.push(num),
					Err(_) => do_operation(&operations, &mut stack, item)
				}
			}
		}
	}
}
