fn main() {
    println!("{}", hello_world());
}

fn hello_world() -> &'static str {
    "Hello world"
}

fn dummy() {}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(hello_world(), "Hello world");
    }
}
