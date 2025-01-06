# Max Flow Algorithm with Edmonds-Karp in SageMath

## Description

This project implements the **Edmonds-Karp algorithm** for calculating the maximum flow in a directed graph using **SageMath**. The algorithm is based on the **Ford-Fulkerson method** and employs **Breadth-First Search (BFS)** to find augmenting paths in the graph.

## Features

- **Breadth-First Search (BFS)** to find reachable vertices.
- **Residual Graph** to track remaining capacities after flow updates.
- **Flow Initialization** to set initial edge flows.
- **Edmonds-Karp Algorithm** for maximum flow calculation.

## Requirements

- **SageMath**: You need SageMath to run the code.
- **DiGraph class**: Used for directed graph representations and operations in SageMath.

## How It Works

1. **Graph Representation**: The graph is represented as an adjacency matrix.
2. **Breadth-First Search (BFS)**: Finds augmenting paths in the graph.
3. **Residual Graph**: Tracks remaining capacities on the edges.
4. **Edmonds-Karp Algorithm**: Iteratively finds augmenting paths and updates the flow until no more augmenting paths can be found.

## Example

You can run the algorithm on any directed graph. Below is an example graph and how to use the algorithm:

```python
tp = {0: {1: 1, 2: 7, 3: 2, 4: 5, 5: 10},
      1: {6: 1, 7: 2},
      2: {7: 3, 8: 5},
      3: {8: 42, 9: 17},
      4: {9: 21, 10: 2},
      5: {10: 27, 6: 1},
      6: {11: 2},
      7: {11: 1},
      8: {12: 2},
      9: {13: 1},
      10: {13: 2},
      11: {14: 4},
      12: {11: 21, 14: 2},
      13: {12: 21, 14: 1}}

graph = DiGraph(tp)
graph.show(edge_labels=True)
edmonds_karp(graph)
