proc vec_add(a : [] real, b : [] real){
    return a + b;
}

proc main(){
    const a, b : [1..10] real = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    writeln(vec_add(a,b));
}



