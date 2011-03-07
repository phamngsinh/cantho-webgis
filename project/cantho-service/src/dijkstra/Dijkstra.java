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
	private final List<Nut> ds_nut;
	private final List<Canh> ds_canh;
	private Set<Nut> settledNodes;
	private Set<Nut> unSettledNodes;
	private Map<Nut, Nut> predecessors;
	private Map<Nut, Double> distance;
	private double chiphi=0.0;
	
	public Dijkstra(DoThi graph) {
		//Lay danh sach nut va canh de bat giai thuat
		this.ds_nut = new ArrayList<Nut>(graph.getDanhSachSNut());
		this.ds_canh = new ArrayList<Canh>(graph.getDanhSachCanh());
	}

	public void execute(Nut source) {
		settledNodes = new HashSet<Nut>();
		unSettledNodes = new HashSet<Nut>();
		distance = new HashMap<Nut, Double>();
		predecessors = new HashMap<Nut, Nut>();
		distance.put(source, 0.0);
		unSettledNodes.add(source);
		while (unSettledNodes.size() > 0) {
			Nut node = getMinimum(unSettledNodes);
			settledNodes.add(node);
			unSettledNodes.remove(node);
			findMinimalDistances(node);
		}
	}

	private void findMinimalDistances(Nut node) {
		List<Nut> adjacentNodes = getNeighbors(node);
		for (Nut target : adjacentNodes) {
			if (getShortestDistance(target) > getShortestDistance(node) + getDistance(node, target)) {
				distance.put(target, getShortestDistance(node) + getDistance(node, target));
				predecessors.put(target, node);
				unSettledNodes.add(target);
			}
		}
	}
	
	private Nut getMinimum(Set<Nut> vertexes) {
		Nut minimum = null;
		for (Nut vertex : vertexes) {
			if (minimum == null) {
				minimum = vertex;
			} else {
				if (getShortestDistance(vertex) < getShortestDistance(minimum)) {
					minimum = vertex;
				}
			}
		}
		return minimum;
	}
	
	private double getDistance(Nut node, Nut target) {
		for (Canh edge : ds_canh) {
			if (edge.getSource().equals(node)&& edge.getDestination().equals(target)) {
				return edge.getWeight();
			}
		}
		throw new RuntimeException("Should not happen");
	}
	private double getShortestDistance(Nut destination) {
		Double d = distance.get(destination);
		if (d == null) {
			return Integer.MAX_VALUE;
		} else {
			return d;
		}
	}
	private List<Nut> getNeighbors(Nut node) {
		List<Nut> neighbors = new ArrayList<Nut>();
		for (Canh edge : ds_canh) {
			if (edge.getSource().equals(node) && !isSettled(edge.getDestination())) {
				neighbors.add(edge.getDestination());
			}
		}
		return neighbors;
	}
	private boolean isSettled(Nut vertex) {
		return settledNodes.contains(vertex);
	}
	/*
	 * Phuong thuc tra ve duong di tu nguon den dich
	 * Tra ve NULL neu khong ton tai duong di
	 */
	public LinkedList<Nut> getPath(Nut target) {
		LinkedList<Nut> path = new LinkedList<Nut>();
		Nut step = target;
		// Neu duong di ton tai
		if (predecessors.get(step) == null) {
			return null;
		}
		path.add(step);
		while (predecessors.get(step) != null) {
			step = predecessors.get(step);
			path.add(step);			
		}
		//Dat duong di theo thu tu nguoc lai
		Collections.reverse(path);
		return path;
	}
	public double getCost(Nut target){
		return distance.get(target);
	}
}
