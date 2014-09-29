struct Point {
  x: int,
  y: int,
}

fn main() {
  let origin = Point{x: 0i, y: 0i};
  println!("The origin is at ({}, {})", origin.x, origin.y)

  let mut point = Point{x: 0i, y: 0i};
  point.x = 6;
  println!("The point is at ({}, {})", point.x, point.y);
}
