use std::cmp::Ordering;
use std::fmt;

struct Channel {
	name : String,
	values : Vec<(f32, String)>,
}

impl Channel {
	fn new(name : String) -> Channel {
		Channel {
			name : name,
			values : Vec::new()
		}
	}

	fn add_value(&mut self, time : f32, val : String) {
		self.values.push((time, val))
	}

	fn get_values(&mut self) -> &Vec<(f32,String)> {
		// Sorting Vec<f32> is harder than it looks.
		// But sorting tuples, it appears, is trivial!
		// I guess you win some and lose some.
		self.values.sort_by(|a,b| a.partial_cmp(b).unwrap_or(Ordering::Less));
		&self.values
	}
}

impl fmt::Display for Channel {
	fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
		write!(f, "Channel({})", self.name);
        for (ky,vl) in self.values {
        	write!(f, "{}: {}", ky, vl)
        }
    }
}

fn main() {
    println!("Hello, world!");
}
