open System

let f_builtin x = log(2.0 + x)

let taylor_naive (x: float) (eps: float) =
    let mutable sum = 0.0
    let mutable k = 1
    let mutable term = 1.0
    let mutable count = 0

    while abs term > eps do
        let sign = if (k + 1) % 2 = 0 then 1.0 else -1.0
        term <- sign * (pown x k) / (float k * pown 2.0 k)

        if abs term > eps then
            sum <- sum + term
            k <- k + 1
            count <- count + 1
        else
            term <- 0.0

    let result = sum + log 2.0
    (result, count)

let taylor_smart (x: float) (eps: float) =
    let mutable k = 1
    let mutable term = x / 2.0
    let mutable sum = term
    let mutable count = 1

    while abs term > eps do
        k <- k + 1
        let nextTerm = term * (-(x / 2.0)) * (float (k - 1) / float k)
        if abs nextTerm > eps then
            sum <- sum + nextTerm
            term <- nextTerm
            count <- count + 1
        else
            term <- 0.0

    let result = sum + log 2.0
    (result, count)

let print_table (a: float) (b: float) (eps: float) (n: int) =
    printfn "%-10s %-15s %-15s %-10s %-15s %-10s" 
            "x" "Builtin" "Smart Taylor" "#terms" "Dumb Taylor" "#terms"

    for i in 0 .. n do
        let x = a + (float i)/(float n) * (b - a)
        let builtin_result = f_builtin x
        let (naive_result, naive_terms) = taylor_naive x eps
        let (smart_result, smart_terms) = taylor_smart x eps

        printfn "%-10.2f %-15.8f %-15.8f %-10d %-15.8f %-10d" 
                x 
                builtin_result 
                smart_result 
                smart_terms 
                naive_result 
                naive_terms

let main _ =
    let a = -1.0
    let b =  1.0
    let eps = 1e-8
    let n = 10

    print_table a b eps n

    0

main [||]