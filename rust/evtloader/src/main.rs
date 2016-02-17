extern crate core;
use core::str::FromStr;
use std::cmp::Ordering;
use std::collections::HashMap;
use std::fmt;
use std::fs::File;
use std::io::Read;

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

	#[allow(dead_code)]
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
		write!(f, "Channel({})\n", self.name).and(
			write!(f,"Values: {:?}\n", self.values)
		)
    }
}

struct Dataset {
	channels : HashMap<String, Channel>
}

impl Dataset {
	fn from_file(filename : &str) -> Dataset {
		let mut dataset = Dataset {
			channels : HashMap::new(),
		};
		let mut f = File::open(filename).unwrap();
		// We read the whole file into memory
		// and then deal with it as a String,
		// which might not be faster than reading
		// it line at a time but that's not possible
		// right now it seems.
		let mut s = String::new();
		f.read_to_string(&mut s).unwrap();
		for line in s.lines() {
			let mut chunk = line.split_whitespace();
			let time = chunk.next().unwrap();
			let channel = chunk.next().unwrap();
			let value = chunk.next().unwrap();
			dataset.add_item(
				String::from(channel), 
				f32::from_str(time).unwrap(), 
				String::from(value))
		}
		dataset
	}

	fn add_item(&mut self, name : String, time : f32, value : String) {
		// XXX: FIX THIS... somehow.
		let mut argl = String::new();
		argl.push_str(&name);
		let entry = self.channels.entry(name).or_insert_with(
			|| Channel::new(argl));
		entry.add_value(time, value)
	}

	fn channel_names(&self) -> String {
		//let mut s = String::new();
		let names = self.channels.keys();
		// XXX: There SHOULD be a better way to do this
		// but str.join() is wacko
		let mut accm = String::new();
		for item in names {
			accm.push_str(item);
			accm.push_str(", ");
		}
		accm
	}

	fn channel_values(&self) -> String {
		// XXX: There SHOULD be a better way to do this
		// but str.join() is wacko
		let mut accm = String::new();
		for channel in self.channels.values() {
			accm.push_str(&format!("Channel: {}\n", channel.name));

			//channel.values.iter().fold(accm,
			//	|acc, &(t,vl)| format!("{}\n{}: {}", acc, t, vl));
			//let ref vls = channel.values;
			for row in &channel.values {
				//let &(t, vl) = row;
			 	//accm.push_str(&format!("{}: {}\n", t, vl));
			 	let (t,ref vl) : (f32, String) = *row;
			 	accm.push_str(&format!("{}: {}\n", t, vl));

			}
		}
		accm
	}
}


impl fmt::Display for Dataset {
	fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
		write!(f, "Dataset:\nChannels: {}\n\n{}", 
			self.channel_names(),
			self.channel_values())
	}
}

fn main() {
	let d = Dataset::from_file("testdata/homedataset.sce");
	println!("{}\n", d);
}
