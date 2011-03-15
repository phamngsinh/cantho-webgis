package dijkstra;

public class Canh {

	private final String id;//10 ky tu
	private final Nut source;// 80 byte
	private final Nut target;// 80 byte
	private final double weight;//8 byte
	private final String the_geom;//40 ky tu
	private final String name;//30 ky tu
	private final int direct;//4 byte
	// size = 252 byte
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
}
