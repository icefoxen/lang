use std::rc::Rc;

fn main() {
   let mut x = box 5i;
   {
	let y = &x;
   	println!("X is {}", x);
   	println!("Y is {}", y);
   }

   x = box 6i;
   println!("X is {}", x);
   // Doesn't work, y is out of scope
   //println!("Y is {}", y);

   println!("Now doing Rc stuff");
   let z = rc_test();
   println!("Returned value allocated in other func");
   println!("Z is {}", z);
}

fn rc_test() -> Rc<int> {
   let x = Rc::new(5i);
   let y = x.clone();

   println!("X is {}", x);
   println!("Y is {}", y);
   y
}