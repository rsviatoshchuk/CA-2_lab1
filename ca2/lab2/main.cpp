#include <iostream>
#include "calculator.h"

using namespace std;

int  main(){
    Calculator calc;

    double a, b, c, d;

    a = calc.Add(3.453, 6.656);
    b = calc.Sub(4, 5.6);
    c = calc.Mul(6.5, 0.6);
    d = calc.Div(5.0, 3.5);
    cout << to_string(a) << endl;
    cout << to_string(b) << endl;
    cout << to_string(c) << endl;
    cout << to_string(d) << endl;
    
    return 0;
}
