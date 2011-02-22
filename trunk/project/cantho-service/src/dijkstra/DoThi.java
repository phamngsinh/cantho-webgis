package dijkstra;
import java.util.List;

public class DoThi {
		
	private final List<Nut> ds_nut;
	private final List<Canh> ds_canh;

	public DoThi(List<Nut> ds_nut, List<Canh> ds_canh) {
		this.ds_nut = ds_nut;
		this.ds_canh = ds_canh;
	}

	public List<Nut> getDanhSachSNut() {
		return ds_nut;
	}

	public List<Canh> getDanhSachCanh() {
		return ds_canh;
	}		
	public Canh getCanh(Nut source,Nut target){
		
		for (Canh edge: ds_canh){
			if (edge.getSource().equals(source) && edge.getDestination().equals(target)){
				return edge;
			}
		}
		return null;
		//throw new RuntimeException("error getCanh() !!");
	}
}
