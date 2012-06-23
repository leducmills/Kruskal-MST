//edge class is needed for Kruskal's algorithm
class Edge {
  private Vertex fromVertex=null, toVertex=null;
  private float weight;
  
  
  public Edge(Vertex from, Vertex to, float weight) {
    this.fromVertex = from;
    this.toVertex = to;
    //this.weight = weight;
    this.weight = dist(fromVertex.x,fromVertex.y,fromVertex.z,toVertex.x,toVertex.y,toVertex.z);
  }

  public Vertex getFrom() {
    return this.fromVertex;
  }
  public Vertex getTo() {
    return this.toVertex;
  }
  public float getWeight() {
    return this.weight;
  }
  
 
  
}

