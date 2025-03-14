open System

let eps = 1e-7 

let dichotomy (f: float -> float) (a0: float) (b0: float) (eps: float) =
    let mutable a = a0
    let mutable b = b0
    
    if f(a) * f(b) > 0.0 then
        failwith "Дихотомия: f(a) и f(b) должны иметь разные знаки!"
    while (b - a) > eps do
        let mid = (a + b) / 2.0
        if f(a) * f(mid) <= 0.0 then
            b <- mid
        else
            a <- mid
    (a + b) / 2.0

let iterations (phi: float -> float) (x0: float) (eps: float) =
    let mutable x = x0
    let mutable xNext = phi x
    while abs(xNext - x) > eps do
        x <- xNext
        xNext <- phi x
    xNext

let newton (f: float -> float) (f': float -> float) (x0: float) (eps: float) =
    let mutable x = x0
    let mutable xNext = x - f(x) / f'(x)
    while abs(xNext - x) > eps do
        x <- xNext
        xNext <- x - f(x) / f'(x)
    xNext


let f1 x = 3.0*x - 14.0 + exp x - exp(-x)
let f1' x = 3.0 + exp x + exp(-x)
let alpha1 = 0.1
let phi1 x = x - alpha1 * f1 x
let a1, b1 = 1.0, 3.0
let x0_1 = 2.0


let f2 x = sqrt(1.0 - x) - tan x
let f2' x =
    -1.0/(2.0 * sqrt(1.0 - x)) 
    - 1.0/(cos x * cos x)
let alpha2 = -0.1
let phi2 x = x - alpha2 * f2 x
let a2, b2 = 0.0, 1.0
let x0_2 = 0.5


let f3 x = x + cos(x**0.52 + 2.0)
let f3' x =
    1.0 - 0.52 * x**(0.52 - 1.0) * sin(x**0.52 + 2.0)
let alpha3 = 0.1
let phi3 x = x - alpha3 * f3 x
let a3, b3 = 0.5, 1.0
let x0_3 = 0.75


let main() =
    printfn "%-28s %-9s  %-9s  %-9s" 
            "Function f(x)" "Dichotomy" "Iteration" "Newton"

    let root1_dich = dichotomy f1 a1 b1 eps
    let root1_iter = iterations phi1 x0_1 eps
    let root1_newt = newton f1 f1' x0_1 eps
    printfn "%-28s %-9.6f  %-9.6f  %-9.6f"
            "3x - 14 + e^x - e^-x" root1_dich root1_iter root1_newt

    let root2_dich = dichotomy f2 a2 b2 eps
    let root2_iter = iterations phi2 x0_2 eps
    let root2_newt = newton f2 f2' x0_2 eps
    printfn "%-28s %-9.6f  %-9.6f  %-9.6f"
            "sqrt(1-x) - tan x" root2_dich root2_iter root2_newt

    let root3_dich = dichotomy f3 a3 b3 eps
    let root3_iter = iterations phi3 x0_3 eps
    let root3_newt = newton f3 f3' x0_3 eps
    printfn "%-28s %-9.6f  %-9.6f  %-9.6f"
            "x + cos(x^0.52 + 2)" root3_dich root3_iter root3_newt

main()
