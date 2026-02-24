// Problem: Trie Implementation And Operations
// Topic: Tries
// Platform: TUF+ (takeUforward)
// Link: https://takeuforward.org/plus/dsa/problems/trie-implementation-and-operations?category=tries&subcategory=triessubc

#include <bits/stdc++.h>
using namespace std;

struct TrieNode {
    TrieNode* children[26];
    bool isEnd;
    TrieNode() {
        isEnd = false;
        for (int i = 0; i < 26; i++) children[i] = nullptr;
    }
};

class Trie {
    TrieNode* root;
public:
    Trie() { root = new TrieNode(); }
    void insert(string word) {
        TrieNode* node = root;
        for (char c : word) {
            if (!node->children[c-'a']) node->children[c-'a'] = new TrieNode();
            node = node->children[c-'a'];
        }
        node->isEnd = true;
    }
    bool search(string word) {
        TrieNode* node = root;
        for (char c : word) {
            if (!node->children[c-'a']) return false;
            node = node->children[c-'a'];
        }
        return node->isEnd;
    }
    bool startsWith(string prefix) {
        TrieNode* node = root;
        for (char c : prefix) {
            if (!node->children[c-'a']) return false;
            node = node->children[c-'a'];
        }
        return true;
    }
};

