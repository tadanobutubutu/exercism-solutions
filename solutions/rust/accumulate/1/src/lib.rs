pub fn map<Input, Output, Function>(input: Vec<Input>, mut function: Function) -> Vec<Output>
where
    Function: FnMut(Input) -> Output,
{
    let mut output = Vec::with_capacity(input.len());
    for item in input {
        output.push(function(item));
    }
    output
}
