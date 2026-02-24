// Problem: Largest Element
// Topic: Arrays
Fundamentals
// Platform: TUF+ (takeUforward)
// Link: https://takeuforward.org/plus/dsa/problems/largest-element?category=arrays&subcategory=fundamentals

#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int largestElement(vector<int>& arr) {
        int maxi = arr[0];
        for (int i = 1; i < arr.size(); i++) {
            if (arr[i] > maxi) {
                maxi = arr[i];
            }
        }
        return maxi;
    }
};

