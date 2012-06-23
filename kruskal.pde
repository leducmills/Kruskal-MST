public class Kruskal {

  private Graph graph;
  private int[] sets; //represent set for vertices

    public Kruskal(Graph g) {
    this.graph = g;
    this.sets = new int[g.getTotalNumberOfVertices()];
  }

  private void makeSet(Vertex v) {
    this.sets[v.getVertexNo()] = v.getVertexNo(); //simply set the set name to each vertex no
  }

  private int findSet(Vertex v) {
    return this.sets[v.getVertexNo()]; //gets the set name/number of a vertex
  }

  private void union(Vertex u, Vertex v) {
    int findWhat, replaceWith;

    if (u.getVertexNo() < v.getVertexNo()) {
      findWhat = this.sets[v.getVertexNo()];
      replaceWith = this.sets[u.getVertexNo()];
    }
    else {
      findWhat = this.sets[u.getVertexNo()];
      replaceWith = this.sets[v.getVertexNo()];
    }

    //make both sets same
    for (int i=0; i<this.sets.length; i++) {
      if (this.sets[i] == findWhat) {
        this.sets[i] = replaceWith;
      }
    }
  }

  private void sortEdges(Edge[] edges) {
    for (int i=0; i<edges.length-1; i++) {
      for (int j=i+1; j<edges.length; j++) {
        if (edges[i].getWeight() > edges[j].getWeight()) {
          Edge tmp = edges[i];
          edges[i] = edges[j];
          edges[j] = tmp;
        }
      }
    }
  }

  //runs the main kruskal algorithm
  public List<Edge> getMSTEdges() {
    //holds the MST edges
    List<Edge> mstEdges = new ArrayList<Edge>();

    Vertex[] vertices = this.graph.getVertices();
    for (int i=0; i<vertices.length; i++) {
      this.makeSet(vertices[i]);
    }

    //get all bi-directional edges
    Edge[] edges = this.graph.getAllBidirectionalEdges();
    //sort the edges w.r.t their weights in non-decreasing order
    this.sortEdges(edges);

    for (int i=0; i<edges.length; i++) {
      //for each each, in sorted order
      Edge e = edges[i];    		
      if (this.findSet(e.getFrom()) != this.findSet(e.getTo())) {
        //if the vertices it connects are not in the same set
        //this edge is an MST edge
        mstEdges.add(e);
        //now, both vertices should have same set
        this.union(e.getFrom(), e.getTo());
      }
    }

    return mstEdges;
  }
}

