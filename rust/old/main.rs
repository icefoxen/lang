fn main() {
  print_sum(5, 6);
}

fn print_sum(x: int, y: int) {
  println!("Sum is: {}", x+y);
}

fn add_one(x: int) -> int {
  x + 1
}
