// Problem: Second Largest Element
// Topic: Arrays
// Platform: TUF+ (takeUforward)
// Link: https://takeuforward.org/plus/dsa/problems/second-largest-element?category=arrays&subcategory=fundamentals

#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int secondLargest(vector<int>& arr) {
        int first = INT_MIN, second = INT_MIN;
        for (int x : arr) {
            if (x > first) {
                second = first;
                first = x;
            } else if (x > second && x != first) {
                second = x;
            }
        }
        return (second == INT_MIN) ? -1 : second;
    }
};

