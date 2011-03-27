package dijkstra;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class Dijkstra {
	//Danh sach cac dinh cua do thi
	private final List<Nut> ds_nut;
	//danh sach cac cung cua do thi
	private final List<Canh> ds_canh;	
	private Set<Nut> settledNodes;
	private Set<Nut> unSettledNodes;
	private Map<Nut, Nut> predecessors;
	private Map<Nut, Double> distance;
	
	public Dijkstra(DoThi g) {
		//Lay danh sach nut va canh de bat giai thuat
		this.ds_nut = new ArrayList<Nut>(g.getDanhSachSNut());
		this.ds_canh = new ArrayList<Canh>(g.getDanhSachCanh());
	}
	public void executeDijkstra(Nut start, Nut end) {
		settledNodes = new HashSet<Nut>();
		unSettledNodes = new HashSet<Nut>();
		distance = new HashMap<Nut, Double>();
		predecessors = new HashMap<Nut, Nut>();
		//Gan chi phi cho nut start = 0.0
		distance.put(start, 0.0);
		//them nut start vao tap hop chua duoc xet de xet cac nut tiep theo
		unSettledNodes.add(start);
		while (unSettledNodes.size() > 0) {	
			//lay ra nut co chi phi thap nhat trong tap hop cac nut chua duoc xet
			Nut nut = getMinNode(unSettledNodes);
			//chuyen nut nay vao tap hop cac nut da duoc xet
			settledNodes.add(nut);
			//xoa nut nay ra khoi tap hop cac nut chua duoc xet
			unSettledNodes.remove(nut);
			//Neu nut nay trung voi nut dich thi dung tai day			
			if (nut.equals(end)){
				System.out.println("Break tai nut: "+nut.getName());
				break;				
			}			
			//xet nut nay va cap nhat chi phi va nut cha cho cac nut ke voi nut nay
			findMinDistances(nut);//O(n^2)		
		}
	}
	//Lay ra nut co chi phi thap nhat trong tap hop cac nut chua duoc xet
	private Nut getMinNode(Set<Nut> vertexes) {
		Nut min = null;
		for (Nut nut : vertexes) {
			if (min == null) {
				min = nut;
			} else {
				if (getShortestDistance(nut) < getShortestDistance(min)) {
					min = nut;
				}
			}
		}
		return min;
	}
	//Cap nhat chi phi cho cac nut ke voi node
	private void findMinDistances(Nut nut) {
		List<Nut> ds_nut_ke = getNeighbors(nut);
		for (Nut ke : ds_nut_ke) {
			if (getShortestDistance(ke) > getShortestDistance(nut) + getDistance(nut, ke)) {
				//Gan chi phi moi cho nut ke
				distance.put(ke, getShortestDistance(nut) + getDistance(nut, ke));
				//Cap nhat lai nut cha cho nut ke
				predecessors.put(ke, nut);
				//Them vao tap hop cac nut chua duoc xet
				unSettledNodes.add(ke);
			}
		}
	}	
	
	private double getDistance(Nut node, Nut target) {
		for (Canh edge : ds_canh) {
			if (edge.getSource().equals(node)&& edge.getDestination().equals(target)) {
				return edge.getWeight();
			}
		}
		throw new RuntimeException("Khong ton tai!!!");
	}
	//Lay ra chi phi thap nhat cua mot nut, neu khong co thi duoc gan la MAX_VALUE
	private double getShortestDistance(Nut destination) {
		Double d = distance.get(destination);
		if (d == null) {
			return Integer.MAX_VALUE;//2^31-1 = 2.147.483.647 
		} else {
			return d;
		}
	}	
	//Lay ra cac nut ke voi mot nut nao do
	private List<Nut> getNeighbors(Nut nut) {
		List<Nut> ds_nut_ke = new ArrayList<Nut>();
		for (Canh edge : ds_canh) {
			if (edge.getSource().equals(nut) && !isSettled(edge.getDestination())) {
				ds_nut_ke.add(edge.getDestination());
			}
		}
		return ds_nut_ke;
	}
	//Xet xem mot nut nao do co trong tap hop da duoc xet chua
	private boolean isSettled(Nut vertex) {
		return settledNodes.contains(vertex);
	}
	//Tra ve NULL neu nhu khong ton tai duong di ngan nhat
	public LinkedList<Nut> getPath(Nut nut) {
		LinkedList<Nut> path = new LinkedList<Nut>();
		Nut step = nut;
		// Neu duong di ton tai
		if (predecessors.get(step) == null) {
			return null;
		}
		path.add(step);
		while (predecessors.get(step) != null) {
			step = predecessors.get(step);
			path.add(step);			
		}
		//Dat duong di theo thu tu nguoc lai theo dung thu tu dung : nguon --> dich
		Collections.reverse(path);
		return path;
	}
	//lay ra chi phi cua mot dinh
	public double getCost(Nut nut){
		return distance.get(nut);
	}
}
