class Graph {
  private final int DEFAULT_EDGE_COST = 1;
  private Vertex[] vertices = null; //list of all vertices in the graph
  private int totalVertices = 0; //keeps count of vertices
  private int[][] adjMatrix = null; //keeps the edges of the graph using adjacency matrix
  private int[] adjacentVertCount = null; //keeps count of adjacent vertices for each vertex

  public Graph(int maxVertices) {
    this.vertices = new Vertex[maxVertices]; //initialize vertices array
    this.adjMatrix = new int[maxVertices][maxVertices]; //initialize adjacency matrix
    this.adjacentVertCount = new int[maxVertices]; //initialize adjacent vertices count
    for (int i=0; i<maxVertices; i++) {
      this.adjacentVertCount[i] = 0; //set adjacent vertex count to 0 initially
      for (int j=0; j<maxVertices; j++) {
        this.adjMatrix[i][j] = -1; //set adjacency list to -1 initially
      }
    }
  }

  public Graph() {
    //default Max amount of vertices: 100 [0-99]
    this(100);
  }

//  //add a new vertex with vertexNo and data
//  public void addVertex(int vertexNo, Object data) {
//    this.vertices[vertexNo] = new Vertex(vertexNo, data);
//    this.totalVertices++;
//  }

//  //add a new vertex with vertexNo only
//  public void addVertex(int vertexNo) {
//    this.addVertex(vertexNo, null);
//  }
  
  //MINE
  public void addVertex(int vertexNo, float x, float y, float z) {
   this.vertices[vertexNo] = new Vertex(vertexNo,x,y,z);
   this.totalVertices++; 
  }

  //add a uni-directional edge with cost
  public void addEdge(int fromVertexNo, int toVertexNo, int cost) {
    this.adjMatrix[fromVertexNo][toVertexNo] = cost;
    this.adjacentVertCount[fromVertexNo]++;
  }

  //add a uni-directional edge with cost
  public void addEdge(Vertex fromVertex, Vertex toVertex, int cost) {
    this.addEdge(fromVertex.getVertexNo(), toVertex.getVertexNo(), cost);
  }

  //add a uni-directional edge
  public void addEdge(int fromVertexNo, int toVertexNo) {
    this.addEdge(fromVertexNo, toVertexNo, this.DEFAULT_EDGE_COST);
  }

  //add a uni-directional edge
  public void addEdge(Vertex fromVertex, Vertex toVertex) {
    this.addEdge(fromVertex.getVertexNo(), toVertex.getVertexNo());
  }

  //add a bi-directional edge with cost
  public void addBidirectionalEdge(int vertex1, int vertex2, int cost) {
    this.addEdge(vertex1, vertex2, cost);
    this.addEdge(vertex2, vertex1, cost);
  }

  //add a bi-directional edge with cost
  public void addBidirectionalEdge(Vertex v1, Vertex v2, int cost) {
    this.addBidirectionalEdge(v1.getVertexNo(), v2.getVertexNo(), cost);
  }

  //add a bi-directional edge
  public void addBidirectionalEdge(int vertex1, int vertex2) {
    this.addBidirectionalEdge(vertex1, vertex2, this.DEFAULT_EDGE_COST);
  }

  //add a bi-directional edge
  public void addBidirectionalEdge(Vertex v1, Vertex v2) {
    this.addBidirectionalEdge(v1.getVertexNo(), v2.getVertexNo());
  }

  //get the total vertices count in the graph
  public int getTotalNumberOfVertices() {
    return this.totalVertices;
  }

  ///mark a vertex as visited
  public void visitVertex(int vertexNo) {
    this.vertices[vertexNo].visit();
  }

  //gets if a vertex is visited
  public boolean isVisited(int vertexNo) {
    return this.vertices[vertexNo].isVisited();
  }

  //get a vertex from a vertexNo
  public Vertex getVertex(int vertexNo) {
    return this.vertices[vertexNo];
  }

  //gets a vertex data from vertexNo
  public Object getVertexData(int vertexNo) {
    return this.vertices[vertexNo].getData();
  }

  //get adjacent vertex numbers for a given vertexNo
  public int[] getAdjacentVertexNumbers(int vertexNo) {
    int[] ret = new int[this.adjacentVertCount[vertexNo]];
    int index = 0;

    for (int i=0; i<this.adjMatrix[vertexNo].length; i++) {
      if (this.adjMatrix[vertexNo][i] >= 0) {
        ret[index++] = i;
      }
    }

    return ret;
  }

  //get adjacent vertex numbers for a given vertex
  public int[] getAdjacentVertexNumbers(Vertex vert) {
    return this.getAdjacentVertexNumbers(vert.getVertexNo());
  }

  //get adjacent vertices for a given vertexNo
  public Vertex[] getAdjacentVertices(int vertexNo) {
    Vertex[] ret = new Vertex[this.adjacentVertCount[vertexNo]];
    int index = 0;

    for (int i=0; i<this.adjMatrix[vertexNo].length; i++) {
      if (this.adjMatrix[vertexNo][i] >= 0) {
        ret[index++] = this.vertices[i];
      }
    }

    return ret;
  }

  //get adjacent vertices for a given vertex
  public Vertex[] getAdjacentVertices(Vertex vert) {
    return this.getAdjacentVertices(vert.getVertexNo());
  }

  //gets the edge/path cost from adjacency list for two given vertexNo
  public int getEdgeCost(int fromVertNo, int toVertNo) {
    return this.adjMatrix[fromVertNo][toVertNo];
  }

  //gets the edge/path cost from adjacency list for two given vertices
  public int getEdgeCost(Vertex fromVert, Vertex toVert) {
    return this.getEdgeCost(fromVert.getVertexNo(), toVert.getVertexNo());
  }

  //gets all vertices
  public Vertex[] getVertices() {
    return this.vertices;
  }

  //returns all the edges of the graph
  //needed for edge traversing algorithms
  public Edge[] getAllEdges() {
    int totalEdges = 0;
    for (int i=0; i<this.adjacentVertCount.length; i++) {
      totalEdges += this.adjacentVertCount[i];
      
    }

    Edge[] edges = new Edge[totalEdges];
    int index = 0;
    for (int i=0; i<this.vertices.length; i++) {
      for (int j=0; j<this.vertices.length; j++) {
        if (this.adjMatrix[i][j] >= 0) {
          edges[index++] = new Edge(this.vertices[i], this.vertices[j], this.adjMatrix[i][j]);
          
        }
      }
    }

    return edges;
  }

  public Edge[] getAllBidirectionalEdges() {
    int totalEdges = 0;
    for (int i=0; i<this.adjacentVertCount.length; i++) {
      totalEdges += this.adjacentVertCount[i];
    }
    totalEdges /= 2;

    Edge[] edges = new Edge[totalEdges];
    int index = 0;
    for (int i=0; i<this.vertices.length; i++) {
      for (int j=i+1; j<this.vertices.length; j++) {
        if (this.adjMatrix[i][j] >= 0) {
          edges[index++] = new Edge(this.vertices[i], this.vertices[j], this.adjMatrix[i][j]);
        }
      }
    }

    return edges;
  }
}

