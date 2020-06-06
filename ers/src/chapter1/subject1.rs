
use rpds::Stack;

#[derive(Debug)]
struct MyStack {
    stack_data: Stack<i32>,
    stack_min: Stack<i32>,
}


impl MyStack{

    fn new () -> Self {
        return MyStack{stack_data: Stack::<i32>::new(), stack_min: Stack::<i32>::new()};
    }

    fn push(&mut self, num:i32) {
        self.stack_data = self.stack_data.push(num);
    }

    fn peek(&mut self) -> Option<&i32> {
        return self.stack_data.peek();

    }


}

pub fn test() {
    let mut s = MyStack::new();
    s.push(1);
    let _r = s.peek();


}
//
//fn test() {
//    let stack = Stack::new().push("stack");
//
//    assert_eq!(stack.peek(), Some(&"stack"));
//
//    let a_stack = stack.push("a");
//
//    assert_eq!(a_stack.peek(), Some(&"a"));
//
//    let stack_popped = a_stack.pop().unwrap();
//
//    assert_eq!(stack_popped, stack);
//}