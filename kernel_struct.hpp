#ifndef ___KERNEL_STRUCT__HPP___
#define ___KERNEL_STRUCT__HPP___

#include <vector>
#include "kernel_struct.hpp"
using namespace std;

class point {
public:
    float a, b;
    void some_method() {}
};

vector<int> test_int(int num_points);
vector<point> test_point(int num_points);

#endif
