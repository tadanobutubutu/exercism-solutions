#include "binary_search_tree.h"

#include <stdlib.h>

static node_t *insert(node_t *root, int value)
{
   if (!root) {
      node_t *node = calloc(1, sizeof(*node));
      if (node)
         node->data = value;
      return node;
   }
   if (value <= root->data) {
      node_t *child = insert(root->left, value);
      if (child)
         root->left = child;
   } else {
      node_t *child = insert(root->right, value);
      if (child)
         root->right = child;
   }
   return root;
}

node_t *build_tree(int *tree_data, size_t tree_data_len)
{
   if (!tree_data || tree_data_len == 0)
      return NULL;
   node_t *root = NULL;
   for (size_t i = 0; i < tree_data_len; ++i) {
      if (!root) {
         root = insert(NULL, tree_data[i]);
         if (!root)
            return NULL;
      } else {
         insert(root, tree_data[i]);
      }
   }
   return root;
}

void free_tree(node_t *tree)
{
   if (!tree)
      return;
   free_tree(tree->left);
   free_tree(tree->right);
   free(tree);
}

static size_t node_count(const node_t *tree)
{
   return tree ? 1 + node_count(tree->left) + node_count(tree->right) : 0;
}

static void copy_in_order(const node_t *tree, int *values, size_t *index)
{
   if (!tree)
      return;
   copy_in_order(tree->left, values, index);
   values[(*index)++] = tree->data;
   copy_in_order(tree->right, values, index);
}

int *sorted_data(node_t *tree)
{
   size_t count = node_count(tree);
   if (count == 0)
      return NULL;
   int *values = malloc(count * sizeof(*values));
   if (!values)
      return NULL;
   size_t index = 0;
   copy_in_order(tree, values, &index);
   return values;
}
