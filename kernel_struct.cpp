#include <boost/format.hpp>
#include <iostream>
#include <vector>
#include "kernel_struct.hpp"
using namespace std;


ostream &operator<<(ostream &o, const point &p) {
    o << boost::format("point.a: %f, point.b: %f") % p.a % p.b;
    return o;
}


int main(void) {
    vector<int> cpu_int_array = test_int(16);
    cout << "testKernel results: " << cpu_int_array.size() << endl;
    for(int i = 0; i < cpu_int_array.size(); ++i) {
        cout << boost::format("value[%d]: %s")
             % i % cpu_int_array[i] << endl;
    }

    vector<point> cpu_point_array = test_point(16);
    cout << "testKernel results: " << cpu_point_array.size() << endl;
    for(int i = 0; i < cpu_point_array.size(); ++i) {
        cout << boost::format("value[%d]: %s")
             % i % cpu_point_array[i] << endl;
    }
    return 0;
}
