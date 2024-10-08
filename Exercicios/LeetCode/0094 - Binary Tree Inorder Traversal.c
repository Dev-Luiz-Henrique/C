/*
    Given the root of a binary tree, return the inorder traversal of its nodes' values.
*/

#include <stdlib.h>

// Definition for a binary tree node.
struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

void helper(struct TreeNode* root, int* result, int* size) {
    if (root == NULL) return;
    helper(root->left, result, size);
    result[(*size)++] = root->val;
    helper(root->right, result, size);
}

int* inorderTraversal(struct TreeNode* root, int* returnSize) {
    int* result = (int*) malloc (100 * sizeof(int));
    *returnSize = 0;
    helper(root, result, returnSize);
    return result;
}

int main(){
    return 0;
}