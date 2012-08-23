import toxi.math.conversion.*;
import toxi.geom.*;
import toxi.math.*;
import toxi.geom.mesh2d.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh.*;
import toxi.math.waves.*;
import toxi.util.*;
import toxi.math.noise.*;
import toxi.processing.*;


int maximumVertices;
Graph g;
ArrayList<Vec3D> vertices;
List<Edge> mst;
Nav3D nav; // camera controller


float x, y, z;

void setup() {
   
  nav=new Nav3D();
  size(800, 800, P3D);

  maximumVertices = int(random(500));
  g = new Graph(maximumVertices);
  vertices = new ArrayList();

  for (int i=0; i<maximumVertices; i++) {
    x = random(width);
    y = random(height);
    z = random(50); 

    g.addVertex(i, x, y, z);
    vertices.add(new Vec3D(x, y, z));
  }


    for(int j = 0; j < maximumVertices; j++) {
     for(int k = 0; k < maximumVertices; k++) {
      if(k != j) { 
      g.addEdge(j,k);
      }
      println(j + " " + k);
     } 
    }

  Kruskal k = new Kruskal(g);
  mst = k.getMSTEdges();

  System.out.println ("Minimum Spanning Tree Edges are:");
  java.util.ListIterator it = mst.listIterator();
  while (it.hasNext ()) {
    Edge e = (Edge)it.next();
    System.out.println ("v" + e.getFrom().getVertexNo() + " --- v" + e.getTo().getVertexNo());
  }
}

void draw() {
  pushMatrix();
  lights();
  smooth();
  nav.transform(); // do transformations using Nav3D controller
  
  background(255);
  stroke(0);
  strokeWeight(4);
  

  for (int i = 0; i < vertices.size(); i++) {

    point(vertices.get(i).x, vertices.get(i).y, vertices.get(i).z);
  }

  strokeWeight(1);

  java.util.ListIterator it = mst.listIterator();
  while (it.hasNext ()) {
    Edge e = (Edge)it.next();
    //System.out.println ("v" + e.getFrom().getVertexNo() + " --- v" + e.getTo().getVertexNo());
    line(e.getFrom().getX(), e.getFrom().getY(), e.getFrom().getZ(), e.getTo().getX(), e.getTo().getY(), e.getTo().getZ());
  }

   popMatrix();
  //noLoop();
}

void mouseDragged() {
  // ignore mouse event if cursor is over controlP5 GUI elements
  //if(controlP5.window(this).isMouseOver()) return;

  nav.mouseDragged();
}

void mouseReleased() {
  nav.mouseReleased();
}

void keyPressed() {
  nav.keyPressed();
}


public void newKruskal() {
  
  println("n");
  
  maximumVertices = int(random(500));
  g = new Graph(maximumVertices);
  vertices = new ArrayList();

  for (int i=0; i<maximumVertices; i++) {
    x = random(width);
    y = random(height);
    z = random(100); 

    g.addVertex(i, x, y, z);
    vertices.add(new Vec3D(x, y, z));
  }


    for(int j = 0; j < maximumVertices; j++) {
     for(int k = 0; k < maximumVertices; k++) {
      if(k != j) { 
      g.addEdge(j,k);
      }
      //println(j + " " + k);
     } 
    }

  Kruskal k = new Kruskal(g);
  mst = k.getMSTEdges();

  System.out.println ("Minimum Spanning Tree Edges are:");
  java.util.ListIterator it = mst.listIterator();
  while (it.hasNext ()) {
    Edge e = (Edge)it.next();
    System.out.println ("v" + e.getFrom().getVertexNo() + " --- v" + e.getTo().getVertexNo());
  }
}



