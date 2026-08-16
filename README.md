# Containers-Treap

A **Treap** (Cartesian Tree) for Pharo that fuses a Binary Search Tree with a Max-Heap. It provides dictionary lookups, dynamic order statistics, and structural split/merge operations with expected $O(\log N)$ time complexity.

![Pharo 14+](https://img.shields.io/badge/Pharo-14%2B-informational) ![License MIT](https://img.shields.io/badge/License-MIT-success)

---

## What is a Treap?

In standard data structures, balancing a Binary Search Tree requires complex, deterministic rotations (like Red-Black or AVL trees). However, when performing massive structural changes like splitting a tree in half or purging bulk records, these deterministic trees trigger heavy rebalancing cascades.

A **Treap** solves this by assigning a randomized Max-Heap priority to every node alongside its search key. This dual-structure ensures the tree remains probabilistically balanced with a shallow depth. This spatial indexing and randomized priority allow the algorithm to instantly sever or fuse entire subtrees in $O(\log N)$ time, making it ideal for high-throughput time-series databases, dynamic rank queries, and IoT telemetry purges without the overhead of deleting records one-by-one in $O(N)$ time.

---

## Loading

To install `Containers-Treap`, open the Playground (`Ctrl + O + W`) in your Pharo image and execute the following Metacello script:

```smalltalk
Metacello new
  baseline: 'ContainersTreap';
  repository: 'github://pharo-containers/Containers-Treap/src';
  load.
```

### Dependency Definition

Add the following snippet to your own Metacello baseline:

```smalltalk
spec
  baseline: 'ContainersTreap'
  with: [ spec repository: 'github://pharo-containers/Containers-Treap/src' ].
```

---

## Basic Usage

```smalltalk
"Initialize a standard Treap"
treap := CTTreap new.

"Add key-value pairs in O(log N)"
treap at: 100 put: 'Sensor A'.
treap at: 250 put: 'Sensor B'.
treap at: 50 put: 'Sensor C'.

"Lookup values safely in O(log N)"
treap at: 250 ifAbsent: [ 'Not Found' ]. "=> 'Sensor B'"

"Check if a key exists in O(log N)"
treap includesKey: 50. "=> true"

"Delete entries in O(log N)"
treap removeKey: 250.

"Find the K-th smallest element dynamically in O(log N)"
node := treap atRank: 2.
node key.   "=> 100"
node value. "=> 'Sensor A'"

"Check tree status"
treap size.       "=> 2"
treap isNotEmpty. "=> true"
```

### Splitting & Merging (Cartesian Operations)
You can split a treap into two disjoint node hierarchies at a given threshold key, or merge two valid trees back together:

```smalltalk
"Split the node hierarchy at key 150 into two disjoint trees"
splits := treap root split: 150.
leftTree := splits first.   "Keys < 150"
rightTree := splits second. "Keys >= 150"

"Merge two disjoint node hierarchies back into a single tree"
mergedRoot := leftTree mergeWith: rightTree.
```

---

## Time & Space Complexity

| Operation | Expected Time | Worst-Case Time | Space Complexity |
| :--- | :--- | :--- | :--- |
| `at:put:` | $O(\log N)$ | $O(N)$ | $O(1)$ per node |
| `at:ifAbsent:` | $O(\log N)$ | $O(N)$ | $O(1)$ |
| `removeKey:` | $O(\log N)$ | $O(N)$ | $O(1)$ |
| `atRank:` | $O(\log N)$ | $O(N)$ | $O(1)$ |
| `split:` / `mergeWith:`| $O(\log N)$ | $O(N)$ | $O(1)$ |

**Performance Note:** The expected $O(\log N)$ complexity is guaranteed probabilistically. Because priorities are assigned as independent random draws, every possible sequential insertion order has an equally minimal probability of producing an unbalanced tree. The theoretical $O(N)$ worst-case is virtually non-existent under standard Pharo random number generation.

---

## Benchmarks 

Benchmarks measure the core tree construction and dictionary query operations in isolation. 

| Workload | Dataset Size | Execution Time (ms) | Total GC Time (ms) |
| :--- | :--- | :--- | :--- |
| **100,000 Sequential Insertions** | 100,000 records | 247.00 ms | 23.00 ms |
| **50,000 Rolling Medians** *(Rank Queries)* | 50,000 queries | 207.00 ms | 13.00 ms |
| **10,000 Split & Merge Operations** | 10,000 operations | 20.23 ms | 0.00 ms |
| **50,000 Chaotic Deletions** | 50,000 records | 41.57 ms | 2.00 ms |
| **Bulk Purge (100k Records)** | 100,000 records | 406.33 ms | 36.00 ms |

---

## Contributing

This library is part of the [Pharo Containers](https://github.com/pharo-containers) project. Contributions are welcome, whether implementing additional functional combinators, improving test coverage, or enhancing documentation. Please open an issue or pull request on GitHub.