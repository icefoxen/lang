enum OptionalInt {
  Value(int),
  Missing
}

fn main() {
  let x = Value(5);
  let y = Missing;

  match x {
    Value(n) => println!("Value is {:d}", n),
    Missing  => println!("Value is missing"),
  }
  
  match y {
    Value(n) => println!("Value is {:d}", n),
    Missing  => println!("Value is missing"),
  }
}
