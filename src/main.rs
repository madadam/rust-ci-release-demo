// extern crate sodiumoxide;

fn main() {
    println!("{}", hello_world());
    // println!("{:?}", sodiumoxide::randombytes::randombytes(10));
}

fn hello_world() -> &'static str {
    "Hello world"
}
