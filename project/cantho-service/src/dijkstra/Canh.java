package dijkstra;

public class Canh {

	private final String id; 
	private final Nut source;
	private final Nut target;
	private final double weight;
	private final String the_geom;
	private final String name;
	private final int direct;
	
	public Canh(String id, Nut source, Nut target, double weight, String the_geom,String name,int direct) {
		this.id = id;
		this.source = source;
		this.target = target;
		this.weight = weight;
		this.the_geom=the_geom;
		this.name=name;	
		this.direct=direct;
	}
	
	public String getId() {
		return id;
	}
	public Nut getDestination() {
		return target;
	}

	public Nut getSource() {
		return source;
	}
	public double getWeight() {
		return weight;
	}
	public String getTheGeom(){
		return the_geom;
	}
	public String getName(){
		return name;
	}
	public int getDirect(){
		return direct;
	}
	@Override
	public String toString() {
		return source + " " + target;
	}	
}
