class Vertex {
  private int vertexNo; //vertex number, starting from 0
  private boolean visited;
  private Object data = null; //can store any data associate with this vertes
  private float x,y,z;

  //public Vertex(int vertexNo, Object data) {
    public Vertex(int vertexNo, float x, float y, float z) {
    this.vertexNo = vertexNo;
    this.visited = false;
    this.data = data;
    
    this.x = x;
    this.y = y;
    this.z = z;
  }
//  public Vertex(int vertexNo) {
//    this(vertexNo, null);
//  }

  public void visit() {
    this.visited = true;
  }
  public boolean isVisited() {
    return this.visited;
  }
  public int getVertexNo() {
    return this.vertexNo;
  }
  public Object getData() {
    return this.data;
  }
  
  public float getX() {
    return this.x;
  }
  
  public float getY() {
    return this.y;
  }
  
  public float getZ() {
    return this.z;
  }

  
}

