package services;

/*thu loi*/
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import org.postgis.*;
import org.postgresql.*;
import dijkstra.Canh;
import dijkstra.Nut;
import dijkstra.DoThi;
import dijkstra.Dijkstra;

public class CanThoMap {

	Connection conn;
	Statement s;
	ResultSet rs, rs_nut, rs_canh, rs_1, rs_2, rs_nut_moi;

	public ArrayList getDuongDi(double x1, double y1, double x2, double y2)
			throws ClassNotFoundException {
		try {
			this.openConnection();
			/***** Danh sach canh va nut *****/
			List<Canh> edges = new ArrayList<Canh>();
			List<Nut> nodes = new ArrayList<Nut>();
			// lay ra danh sach cac dinh
			String sql_nut = "SELECT id, ST_AsText(the_geom) As the_geom FROM dinh Order By id";
			rs_nut = s.executeQuery(sql_nut);
			while (rs_nut.next()) {
				Nut node = new Nut(rs_nut.getString("id"),
						rs_nut.getString("id") + "_"
								+ rs_nut.getString("the_geom"));
				nodes.add(node);
			}
			// System.out.print(nodes.get(1));
			/*
			 * Lay ket qua giao giua diem chon voi duong Ket qua:
			 * 
			 * @Neu diem chon trung voi mot dinh cua duong thi ket qua co dang:
			 * _$<id_dinh>$<id_canh_giao>$<id_dinh_moi>
			 * 
			 * @Neu diem chon khong trung voi dinh nao, thi ket qua co dang:
			 * <multilinestring1
			 * >$<len1>$<multilinestring2>$<len2>$<id_canh_giao>$id_dinh_moi
			 */
			/** Duyet qua tung canh trong danh sach de them vao do thi ****/
			/*** Lay ds canh tu du lieu ***/
			String sql3 = "SELECT gid As id, ma_duong, ten_duong, mot_chieu, nut_nguon, nut_dich, chieu_dai,"
					+ " ST_AsText(the_geom) as the_geom "
					+ " FROM giaothong"
					+ " Order By id";
			rs_canh = s.executeQuery(sql3);
			/** Duyet qua tung mau tin de them canh vao danh sach canh **/
			while (rs_canh.next()) {
				String current_id = rs_canh.getString("id");
				int source = rs_canh.getInt("nut_nguon") - 1;
				int target = rs_canh.getInt("nut_dich") - 1;
				String ten_duong = rs_canh.getString("ten_duong");
				if (ten_duong == null) {
					ten_duong = "Duong Khong Ten";
				}
				int mot_chieu = rs_canh.getInt("mot_chieu");
				String the_geom = rs_canh.getString("the_geom");
				Double chieu_dai = rs_canh.getDouble("chieu_dai");

				Canh edge = new Canh(current_id, nodes.get(source),
						nodes.get(target), chieu_dai, the_geom, ten_duong,
						mot_chieu);
				edges.add(edge);
				// neu duong hai chieu add them chieu nguoc lai
				if (mot_chieu == 0) {
					Canh edge_r = new Canh(current_id, nodes.get(target),
							nodes.get(source), chieu_dai, the_geom, ten_duong,
							mot_chieu);
					edges.add(edge_r);
				}
			}
			/** Ket thuc Duyet qua tung mau tin de them canh vao danh sach canh **/

			/**** Lay du lieu giao cua Diem 1 ***********/
			String sql1 = "SELECT split_multi_from_any_point('" + x1 + "','"
					+ y1 + "') AS result";
			rs_1 = s.executeQuery(sql1);
			String[] temp1;
			String result1 = "";
			while (rs_1.next()) {
				result1 = rs_1.getString("result");
				break;
			}
			temp1 = result1.split("\\$");
			for (int i = 0; i < temp1.length; i++) {
				// System.out.println(temp1[i]);
			}
			/**** Ket thuc lay du lieu giao cua Diem 1 ***********/
			/**** Lay du lieu giao cua Diem 2 ***********/
			String sql2 = "SELECT split_multi_from_any_point('" + x2 + "','"
					+ y2 + "') AS result";
			rs_2 = s.executeQuery(sql2);
			String[] temp2;
			String result2 = "";
			while (rs_2.next()) {
				result2 = rs_2.getString("result");
				break;
			}
			temp2 = result2.split("\\$");
			for (int i = 0; i < temp2.length; i++) {
				// System.out.println(temp2[i]);
			}
			/**** Ket thuc lay du lieu giao cua Diem 2 ***********/
			/****/
			int start_point = 0;// nut bat dau trong thuat toan Dijkstra
			int end_point = 0;// nut ket thuc trong thuat toan Dijkstra
			/****/

			/**
			 * Neu hai diem gan nhat cung nam tren mot canh function:
			 * split_multi_from_two_point( x1 float, y1 float, x2 float, y2
			 * float) Ket qua: 0 - Neu hai diem khong cung tren mot canh, nguoc
			 * lai ket qua tach canh co dang nhu:
			 * <multilinestring_1>$<do_dai_1>$
			 * <id_nut_moi>$<multilinestring_2>$<do_dai_2
			 * >$<id_nut_moi>$<multilinestring_3>$<do_dai_3>
			 * **/
			rs = s.executeQuery("SELECT split_multi_from_two_point('" + x1
					+ "' , '" + y1 + "' , '" + x2 + "' , '" + y2
					+ "' ) As result");

			/**
			 * Bat dau kiem tra tung diem giao de tach canh, neu diem giao khong
			 * trung voi cac dinh cua canh
			 **/
			String result = "";
			while (rs.next()) {
				result = rs.getString("result");
			}
			// Kiem tra xem hai diem co cung nam tren mot canh giao hay khong?
			if (!result.equals("0")) {
				/***** BAT DAU TRUONG HOP HAI DIEM NAM TREN CUNG MOT CANH ******/
				System.out.println("Ket qua: Trung - result= " + result);
				String[] temp;
				temp = result.split("\\$");
				for (int i = 0; i < temp.length; i++) {
					System.out.println("temp[" + i + "]=" + temp[i]);
				}
				String mult1 = temp[0];
				double len1 = Double.parseDouble(temp[1]);
				int id_nut_moi_1 = Integer.parseInt(temp[2]);
				String mult2 = temp[3];
				double len2 = Double.parseDouble(temp[4]);
				int id_nut_moi_2 = Integer.parseInt(temp[5]);
				String mult3 = temp[6];
				double len3 = Double.parseDouble(temp[7]);
				/** Them hai nut moi vao danh sach nut theo thu tu tang dan **/
				if (id_nut_moi_1 < id_nut_moi_2) {
					start_point = id_nut_moi_1;
					end_point = id_nut_moi_2;
				} else {
					start_point = id_nut_moi_2;
					end_point = id_nut_moi_1;
				}
				Nut node = new Nut(start_point + "", start_point
						+ "_POINT(Nut Moi Start Point)");
				nodes.add(node);
				node = new Nut(end_point + "", end_point
						+ "_POINT(Nut Moi End Point)");
				nodes.add(node);
				// lay ra id canh giao
				rs = s.executeQuery("SELECT find_id_nearest_edge( '" + x2
						+ "' , '" + y2 + "' ) As edges_id");
				String id_canh_giao = "";
				while (rs.next()) {
					id_canh_giao = rs.getString("edges_id");
				}
				// System.out.println("id_canh_giao: "+id_canh_giao);
				int chieu_hien_tai = 0;
				/** chieu cua canh gan nhat voi diem */
				int id_nguon = 0;
				/** id nguon cua canh gan nhat voi diem */
				int id_dich = 0;
				/** id dich cua canh gan nhat voi diem */
				String ten = "";
				/** ten cua canh gan nhat voi diem */
				int i = 0;
				int j = 0;
				/** xoa canh gan nhat voi diem 1 ra khoi danh sach edges */
				for (i = 0; i < edges.size(); i++) {
					// System.out.println("Kich thuoc hien tai: "+edges.size());
					if (edges.get(i).getId().equals(id_canh_giao)) {
						if (j == 0) {
							chieu_hien_tai = edges.get(i).getDirect();
							id_nguon = Integer.parseInt(edges.get(i)
									.getSource().getId());
							id_dich = Integer.parseInt(edges.get(i)
									.getDestination().getId());
							ten = edges.get(i).getName();
						}
						edges.remove(i);
						i--;// vi danh sach edges se giam di 1 sau khi xoa
						// System.out.println("Kich thuoc sau khi xoa: "+edges.size());
						j++;// tang len de khong gan lai du lieu thuoc tinh cua
							// chieu nguoc lai(sai nut nguon va dich) khi duong
							// la 2 chieu
					}
				}
				// System.out.println("id_nguon: "+id_nguon+" -id_dich: "+id_dich+" -ten: "+ten+" -chieu: "+chieu_hien_tai);
				/**** Them ba canh moi *****/
				Canh canh_moi = new Canh(id_canh_giao, nodes.get(id_nguon - 1),
						nodes.get(id_nut_moi_1 - 1), len1, mult1, ten,
						chieu_hien_tai);
				edges.add(canh_moi);
				canh_moi = new Canh(id_canh_giao, nodes.get(id_nut_moi_1 - 1),
						nodes.get(id_nut_moi_2 - 1), len2, mult2, ten,
						chieu_hien_tai);
				edges.add(canh_moi);
				canh_moi = new Canh(id_canh_giao, nodes.get(id_nut_moi_2 - 1),
						nodes.get(id_dich - 1), len3, mult3, ten,
						chieu_hien_tai);
				edges.add(canh_moi);
				// neu hai chieu thi them lan nua
				if (chieu_hien_tai == 0) {
					canh_moi = new Canh(id_canh_giao, nodes.get(id_dich - 1),
							nodes.get(id_nut_moi_2 - 1), len3, mult3, ten,
							chieu_hien_tai);
					edges.add(canh_moi);
					canh_moi = new Canh(id_canh_giao,
							nodes.get(id_nut_moi_2 - 1),
							nodes.get(id_nut_moi_1 - 1), len2, mult2, ten,
							chieu_hien_tai);
					edges.add(canh_moi);
					canh_moi = new Canh(id_canh_giao,
							nodes.get(id_nut_moi_1 - 1),
							nodes.get(id_nguon - 1), len1, mult1, ten,
							chieu_hien_tai);
					edges.add(canh_moi);
				}
				/*
				 * for (i=0 ; i<edges.size() ; i++){
				 * System.out.println("id:"+edges
				 * .get(i).getId()+" - nguon:"+edges
				 * .get(i).getSource().getId()+" -dich:"
				 * +edges.get(i).getDestination
				 * ().getId()+" -trong luong:"+edges.
				 * get(i).getWeight()+" -the_geom:"+edges.get(i).getTheGeom());
				 * }
				 */
				/***** KET THUC TRUONG HOP HAI DIEM NAM TREN CUNG MOT CANH ******/
			} else {
				// hai diem nam tren hai canh khac nhau
				// System.out.println("Ket qua: khong trung - result= "+result);
				/******** BAT DAU TRUONG HOP HAI NAM TREN HAI CANH KHAC NHAU *******/

				int id_nut_moi = 0;
				rs_nut_moi = s
						.executeQuery("SELECT MAX(id) As id_nut_max FROM dinh");
				while (rs_nut_moi.next()) {
					id_nut_moi = rs_nut_moi.getInt("id_nut_max");
				}

				/*** Xet diem thu 1 ***/
				/******
				 * xet diem gan nhat co trung voi nut (dinh) nao cua canh gan
				 * nhat khong?
				 */
				if (temp1[0].equals("_")) {
					start_point = Integer.parseInt(temp1[1]);
					/** Neu trung gan start_point la dinh trung **/
				} else {
					String mult1 = temp1[0];
					/** multilinestring 1 **/
					double len1 = Double.parseDouble(temp1[1]);
					/** do dai cua multilinestring 1 **/
					String mult2 = temp1[2];
					/** multilinestring 2 **/
					double len2 = Double.parseDouble(temp1[3]);
					/** do dai cua multilinestring 2 **/
					String id_canh_giao = temp1[4];
					// System.out.println("id_canh_giao: "+id_canh_giao);
					/** id cua canh gan nhat voi diem **/
					int chieu_hien_tai = 0;
					/** chieu cua canh gan nhat voi diem */
					int id_nguon = 0;
					/** id nguon cua canh gan nhat voi diem */
					int id_dich = 0;
					/** id dich cua canh gan nhat voi diem */
					String ten = "";
					/** ten cua canh gan nhat voi diem */
					int i = 0;
					int j = 0;
					/** xoa canh gan nhat voi diem 1 ra khoi danh sach edges */
					/*
					 * for (Canh canh : edges) { if
					 * (canh.getId().equals(id_canh_giao)) { // chi lay du lieu
					 * cua canh (chieu dung) dau tien if (j == 0) {
					 * chieu_hien_tai = canh.getDirect(); id_nguon =
					 * Integer.parseInt(canh.getSource().getId()); id_dich =
					 * Integer.parseInt(canh.getDestination().getId()); ten =
					 * canh.getName(); } edges.remove(i); j++; } i++; }
					 */
					for (i = 0; i < edges.size(); i++) {
						// System.out.println("Kich thuoc hien tai: "+edges.size());
						if (edges.get(i).getId().equals(id_canh_giao)) {
							if (j == 0) {
								chieu_hien_tai = edges.get(i).getDirect();
								id_nguon = Integer.parseInt(edges.get(i)
										.getSource().getId());
								id_dich = Integer.parseInt(edges.get(i)
										.getDestination().getId());
								ten = edges.get(i).getName();
							}
							edges.remove(i);
							i--;// vi danh sach edges se giam di 1 sau khi xoa
							// System.out.println("Kich thuoc sau khi xoa: "+edges.size());
							j++;// tang len de khong gan lai du lieu thuoc tinh
								// cua chieu nguoc lai(sai nut nguon va dich)
								// khi duong la 2 chieu
						}
					}
					/** Them nut moi **/
					id_nut_moi++;
					Nut nut_moi = new Nut(id_nut_moi + "", id_nut_moi
							+ "_POINT(Nut Moi Bat Dau)");
					nodes.add(nut_moi);
					// System.out.println("1-Sau khi them nut moi ban dau: id_nut_moi="+id_nut_moi+"-kich thuoc nodes= "+nodes.size());
					/**** Them hai canh moi *****/
					Canh canh_moi = new Canh(id_canh_giao,
							nodes.get(id_nguon - 1), nodes.get(id_nut_moi - 1),
							len1, mult1, ten, chieu_hien_tai);
					edges.add(canh_moi);
					canh_moi = new Canh(id_canh_giao,
							nodes.get(id_nut_moi - 1), nodes.get(id_dich - 1),
							len2, mult2, ten, chieu_hien_tai);
					edges.add(canh_moi);
					// neu hai chieu thi them lan nua
					if (chieu_hien_tai == 0) {
						canh_moi = new Canh(id_canh_giao,
								nodes.get(id_dich - 1),
								nodes.get(id_nut_moi - 1), len2, mult2, ten,
								chieu_hien_tai);
						edges.add(canh_moi);
						canh_moi = new Canh(id_canh_giao,
								nodes.get(id_nut_moi - 1),
								nodes.get(id_nguon - 1), len1, mult1, ten,
								chieu_hien_tai);
						edges.add(canh_moi);
					}
					start_point = id_nut_moi;
				}

				/**** Xet Diem 2 ****/
				/****** xem diem gan nhat co trung voi nut nao khong? */
				if (temp2[0].equals("_")) {
					end_point = Integer.parseInt(temp2[1]);
					/** Neu trung gan end_point la dinh trung **/
				} else {
					String mult1 = temp2[0];
					/** multilinestring 1 **/
					double len1 = Double.parseDouble(temp2[1]);
					/** do dai cua multilinestring 1 **/
					String mult2 = temp2[2];
					/** multilinestring 2 **/
					double len2 = Double.parseDouble(temp2[3]);
					/** do dai cua multilinestring 2 **/
					String id_canh_giao = temp2[4];
					/** id cua canh gan nhat voi diem **/
					int chieu_hien_tai = 0;
					/** chieu cua canh gan nhat voi diem */
					int id_nguon = 0;
					/** id nguon cua canh gan nhat voi diem */
					int id_dich = 0;
					/** id dich cua canh gan nhat voi diem */
					String ten = "";
					/** ten cua canh gan nhat voi diem */
					/** xoa canh gan nhat voi diem 2 ra khoi danh sach edges */
					int i = 0;
					int j = 0;
					/*
					 * for (Canh canh : edges) { if
					 * (canh.getId().equals(id_canh_giao)) { // chi lay du lieu
					 * cua canh (chieu dung) dau tien if (j == 0) {
					 * chieu_hien_tai = canh.getDirect(); id_nguon =
					 * Integer.parseInt(canh.getSource().getId()); id_dich =
					 * Integer.parseInt(canh.getDestination().getId()); ten =
					 * canh.getName(); i--; } edges.remove(i); j++; } i++; }
					 */
					for (i = 0; i < edges.size(); i++) {
						// System.out.println("Kich thuoc hien tai: "+edges.size());
						if (edges.get(i).getId().equals(id_canh_giao)) {
							if (j == 0) {
								chieu_hien_tai = edges.get(i).getDirect();
								id_nguon = Integer.parseInt(edges.get(i)
										.getSource().getId());
								id_dich = Integer.parseInt(edges.get(i)
										.getDestination().getId());
								ten = edges.get(i).getName();
							}
							edges.remove(i);
							i--;// vi danh sach edges se giam di 1 sau khi xoa
							// System.out.println("Kich thuoc sau khi xoa: "+edges.size());
							j++;// tang len de khong gan lai du lieu thuoc tinh
								// cua chieu nguoc lai(sai nut nguon va dich)
								// khi duong 2 chieu
						}
					}
					/** Them nut moi **/
					id_nut_moi++;
					Nut nut_moi = new Nut(id_nut_moi + "", id_nut_moi
							+ "_POINT(Nut moi ket thuc)");
					nodes.add(nut_moi);
					/**** Them hai canh moi *****/
					Canh canh_moi = new Canh(id_canh_giao,
							nodes.get(id_nguon - 1), nodes.get(id_nut_moi - 1),
							len1, mult1, ten, chieu_hien_tai);
					edges.add(canh_moi);
					canh_moi = new Canh(id_canh_giao,
							nodes.get(id_nut_moi - 1), nodes.get(id_dich - 1),
							len2, mult2, ten, chieu_hien_tai);
					edges.add(canh_moi);
					// neu hai chieu thi them lan nua
					if (chieu_hien_tai == 0) {
						canh_moi = new Canh(id_canh_giao,
								nodes.get(id_dich - 1),
								nodes.get(id_nut_moi - 1), len2, mult2, ten,
								chieu_hien_tai);
						edges.add(canh_moi);
						canh_moi = new Canh(id_canh_giao,
								nodes.get(id_nut_moi - 1),
								nodes.get(id_nguon - 1), len1, mult1, ten,
								chieu_hien_tai);
						edges.add(canh_moi);
					}
					end_point = id_nut_moi;
				}
				/******** KET THUC TRUONG HOP HAI NAM TREN HAI CANH KHAC NHAU *******/
			}

			/************ BAT DAU THUAT TOAN Dijkstra ********************/

			// System.out.print(nodes.get(3));
			DoThi g = new DoThi(nodes, edges);
			Dijkstra dijkstra = new Dijkstra(g);
			dijkstra.executeDijkstra(nodes.get(start_point - 1),
					nodes.get(end_point - 1));
			LinkedList<Nut> path = dijkstra.getPath(nodes.get(end_point - 1));
			System.out.println("Size path: " + path.size());
			// ton tai duong di

			ArrayList ds_canh = new ArrayList();
			if (path.size() > 0) {
				//lay ra nut dau tien
				Nut source = new Nut(path.get(0).getId(), path.get(0).getName());
				// System.out.println(current.getName());
				// duyet qua cac nut con lai
				int so_nut = path.size();	
				String canh_truoc = " ";
				String canh_sau = " ";
				for (int i = 1; i < so_nut; i++) {
					// System.out.println(path.get(i).getName());
					// tao mot mang de luu cac thuoc tinh cua duong
					String[] arr = new String[4];
					Nut target = new Nut(path.get(i).getId(), path.get(i).getName());
					arr[0] = g.getCanh(source, target).getTheGeom();
					//System.out.println("canh "+i+" : "+g.getCanh(source, target).getTheGeom());
					arr[1] = g.getCanh(source, target).getName();
					arr[2] = g.getCanh(source, target).getWeight() + "";
					arr[3] = " ";
					/***Direction***/									
					if (i ==  1){
						//lay canh dau tien	
						canh_truoc = g.getCanh(source, target).getTheGeom();						
					}
					if (i > 1 ){
						//lay ra canh hien tai, so sanh voi canh truoc do
						canh_sau = g.getCanh(source, target).getTheGeom();
						//System.out.println(i+"- canh_truoc : "+canh_truoc);
						//System.out.println(i+"- canh_sau   : "+canh_sau);						
						rs = s.executeQuery("Select get_bearing('"+canh_truoc+"','"+canh_sau+"') As result");
						//gan lai canh_truoc = canh_sau
						while (rs.next()){					
							//System.out.println("direction: "+rs.getString("result"));
							arr[3] = rs.getString("result");
						}
						
						canh_truoc = canh_sau;
					}
					/***End Direction***/
					ds_canh.add(arr);/* Them ngay: 23/02/2011 */
					source = target;
				}				
			}

=======

			// System.out.print(nodes.get(3));
			DoThi g = new DoThi(nodes, edges);
			Dijkstra dijkstra = new Dijkstra(g);
			dijkstra.executeDijkstra(nodes.get(start_point - 1),
					nodes.get(end_point - 1));
			LinkedList<Nut> path = dijkstra.getPath(nodes.get(end_point - 1));
			System.out.println("Size path: " + path.size());
			// ton tai duong di

			ArrayList ds_canh = new ArrayList();
			if (path.size() > 0) {
				Nut source = new Nut(path.get(0).getId(), path.get(0).getName());// lay
																					// ra
																					// nut
																					// dau
																					// tien
				// System.out.println(current.getName());
				// duyet qua cac nut con lai
				for (int i = 1; i < path.size(); i++) {
					// System.out.println(path.get(i).getName());
					// tao mot mang de luu cac thuoc tinh cua duong
					String[] arr = new String[3];
					Nut target = new Nut(path.get(i).getId(), path.get(i)
							.getName());
					arr[0] = g.getCanh(source, target).getTheGeom();
					arr[1] = g.getCanh(source, target).getName();
					arr[2] = g.getCanh(source, target).getWeight() + "";
					ds_canh.add(arr);/* Them ngay: 23/02/2011 */
					source = target;
				}
			}


			for (Nut vertex : path) {

				System.out.println(vertex.getName());
			}
			Double chi_phi = dijkstra.getCost(nodes.get(end_point - 1));
			this.closeConnection();
			// System.out.println("Integer.MAX_VALUE = "+Integer.MAX_VALUE);
			return ds_canh;/* Them ngay: 23/02/2011 */


				System.out.println(vertex.getName());
			}
			Double chi_phi = dijkstra.getCost(nodes.get(end_point - 1));

			this.closeConnection();
			// System.out.println("Integer.MAX_VALUE = "+Integer.MAX_VALUE);
			return ds_canh;/* Them ngay: 23/02/2011 */


		} catch (SQLException e) {
			System.out.print("Error - getDuongDi function: " + e.getMessage());
			// return "Error: " + e.getMessage();
			return null;
		}
	}

	/***********************
	 * DANH SACH CAC DIA DIEM THEO LOP
	 * 
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 ****************************************************/
	public ArrayList getDiaDiem(String lop, String ten) throws SQLException,
			ClassNotFoundException {
		this.openConnection();
		String sql = "SELECT  ST_Astext(the_geom) As the_geom, ten, diachi, sdt FROM "
				+ lop + " WHERE ten LIKE '%" + ten + "%'";
		rs = s.executeQuery(sql);
		ArrayList ds_diadiem = new ArrayList();

		while (rs.next()) {

			String[] arr = new String[4];
			// neu chuoi lay ra la null thi gan gia tri la chuoi rong
			if (rs.getString("the_geom") == null) {
				arr[0] = " ";
			} else {
				arr[0] = rs.getString("the_geom");
			}
			if (rs.getString("ten") == null) {
				arr[1] = " ";
			} else {
				arr[1] = rs.getString("ten");
			}
			if (rs.getString("diachi") == null) {
				arr[2] = " ";
			} else {
				arr[2] = rs.getString("diachi");
			}
			if (rs.getString("sdt") == null) {
				arr[3] = " ";
			} else {
				arr[3] = rs.getString("sdt");
			}
			ds_diadiem.add(arr);
		}
		this.closeConnection();
		return ds_diadiem;
	}

	public ArrayList find_Info_Of_Point(String wkt_point) throws SQLException,
			ClassNotFoundException {
		this.openConnection();
		ArrayList arr = new ArrayList();
		String ten = "";
		String diachi = "";
		String sodienthoai = "";
		String x = "";
		String y = "";
		rs = s.executeQuery("Select find_info_of_point('" + wkt_point
				+ "') As result");
		String result = "";

		while (rs.next()) {
			result = rs.getString("result");
		}
		/**
		 * Ket qua tra ve: ten$diachi$sdt$x$y Neu ko tim thay tra ve
		 * 'nodata$x$y'
		 **/
		// tien hanh tach chuoi dua tren ky tu dac biet $
		String[] temp = new String[5];
		temp = result.split("\\$");
		/*
		 * for (int i=0;i<temp.length;i++){
		 * System.out.println("temp["+i+"]:"+temp[i]); }
		 */
		if (temp[0].equalsIgnoreCase("nodata")) {
			// khong tim thay thong tin tai vi tri nay
			ten = "Khong tim thay thong tin tai vi tri nay...";
			diachi = " ";
			sodienthoai = " ";
			x = temp[1];
			y = temp[2];
		} else {
			// lay ra ten
			if (temp[0].equals("")) {
				ten = " ";
			} else {
				ten = temp[0];
			}
			// lay ra dia chi
			if (temp[1].equals("")) {
				diachi = " ";
			} else {
				diachi = temp[1];
			}
			// lay ra so dien thoai
			if (temp[2].equals("")) {
				sodienthoai = " ";
			} else {
				sodienthoai = temp[2];
			}
			// lay ra toa do x
			if (temp[3].equals("")) {
				x = " ";
			} else {
				x = temp[3];
			}
			// lay ra toa do y
			if (temp[4].equals("")) {
				y = " ";
			} else {
				y = temp[4];
			}
		}
		arr.add(ten);
		arr.add(diachi);
		arr.add(sodienthoai);
		arr.add(x);
		arr.add(y);
		// System.out.println("result: "+result);
		this.closeConnection();
		return arr;
	}

	/*** Can sua lai tra ve them cac thuoc tinh cua dia diem **/
	public ArrayList getLop(String ten_lop) throws SQLException,
			ClassNotFoundException {
		// Cac lop khong co sdt: cau, congvien, cho, ben
		this.openConnection();
		String the_geom = "";
		String ten = "";
		String diachi = "";
		String sdt = "";
		ArrayList ds_dia_diem = new ArrayList();
		// System.out.println("-"+ten_lop+"-");
		if (ten_lop.equalsIgnoreCase("cau")
				|| ten_lop.equalsIgnoreCase("congvien")
				|| ten_lop.equalsIgnoreCase("ben")) {

			String sql_1 = "Select ten, diachi, ST_Astext(the_geom) As the_geom From "
					+ ten_lop;
			rs = s.executeQuery(sql_1);
			sdt = " ";
			while (rs.next()) {
				String[] arr_1 = new String[4];

				if (rs.getString("ten") == null) {
					ten = " ";
				} else {
					ten = rs.getString("ten");
				}
				if (rs.getString("diachi") == null) {
					diachi = " ";
				} else {
					diachi = rs.getString("diachi");
				}
				if (rs.getString("the_geom") == null) {
					the_geom = " ";
				} else {
					the_geom = rs.getString("the_geom");
				}
				// System.out.println("1-Ten: "+ten);
				arr_1[0] = the_geom;
				arr_1[1] = ten;
				arr_1[2] = diachi;
				arr_1[3] = sdt;
				ds_dia_diem.add(arr_1);
			}
		} else {
			// System.out.println("Kiem tra dung");

			String sql_2 = "Select ten, diachi, sdt, ST_Astext(the_geom) As the_geom From "
					+ ten_lop;
			rs = s.executeQuery(sql_2);
			while (rs.next()) {
				String[] arr_2 = new String[4];

				if (rs.getString("ten") == null) {
					ten = " ";
				} else {
					ten = rs.getString("ten");
				}
				if (rs.getString("diachi") == null) {
					diachi = " ";
				} else {
					diachi = rs.getString("diachi");
				}
				if (rs.getString("sdt") == null) {
					sdt = " ";
				} else {
					sdt = rs.getString("sdt");
				}
				if (rs.getString("the_geom") == null) {
					the_geom = " ";
				} else {
					the_geom = rs.getString("the_geom");
				}
				// System.out.println("2-Ten: "+ten);
				arr_2[0] = the_geom;
				arr_2[1] = ten;
				arr_2[2] = diachi;
				arr_2[3] = sdt;
				ds_dia_diem.add(arr_2);
			}
		}
		this.closeConnection();
		return ds_dia_diem;
	}

	public ArrayList find_Place_By_Text(String text) throws SQLException,
			ClassNotFoundException {

		ArrayList ds_dia_diem = new ArrayList();
		String the_geom = " ";
		String ten = " ";
		String diachi = " ";
		String sdt = " ";

		this.openConnection();

		rs = s.executeQuery("SELECT ten, diachi, sdt, ST_Astext(the_geom) As the_geom FROM find_place_by_text('"
				+ text + "')");
		while (rs.next()) {
			String[] arr = new String[4];
			if (rs.getString("the_geom") == null) {
				the_geom = " ";
			} else {
				the_geom = rs.getString("the_geom");
			}
			if (rs.getString("ten") == null) {
				ten = " ";
			} else {
				ten = rs.getString("ten");
			}
			if (rs.getString("diachi") == null) {
				diachi = " ";
			} else {
				diachi = rs.getString("diachi");
			}
			if (rs.getString("sdt") == null) {
				sdt = " ";
			} else {
				sdt = rs.getString("sdt");
			}

			arr[0] = the_geom;
			arr[1] = ten;
			arr[2] = diachi;
			arr[3] = sdt;
			ds_dia_diem.add(arr);
		}
		this.closeConnection();
		return ds_dia_diem;
	}

	public ArrayList find_Place_Around_Point(double x, double y, String chuoi,
			double bankinh) throws SQLException, ClassNotFoundException {
		ArrayList ds_dia_diem = new ArrayList();
		String the_geom = "";
		String ten = "";
		String diachi = "";
		String sdt = "";
		this.openConnection();
		rs = s.executeQuery("SELECT ten, diachi, sdt, ST_Astext(the_geom) As the_geom FROM find_place_around_point('"
				+ x + "','" + y + "','" + chuoi + "'," + bankinh + ")");
		// System.out.println("So mau tin hien tai(find_Place_Around_Point): ");
		while (rs.next()) {
			String[] arr = new String[4];
			if (rs.getString("the_geom") == null) {
				the_geom = " ";
			} else {
				the_geom = rs.getString("the_geom");
			}
			if (rs.getString("ten") == null) {
				ten = " ";
			} else {
				ten = rs.getString("ten");
			}
			if (rs.getString("diachi") == null) {
				diachi = " ";
			} else {
				diachi = rs.getString("diachi");
			}
			if (rs.getString("sdt") == null) {
				sdt = " ";
			} else {
				sdt = rs.getString("sdt");
			}
			// System.out.println(ten);
			arr[0] = the_geom;
			arr[1] = ten;
			arr[2] = diachi;
			arr[3] = sdt;
			ds_dia_diem.add(arr);
		}
		this.closeConnection();
		return ds_dia_diem;
	}

	public ArrayList getQuanHuyen() throws SQLException, ClassNotFoundException {
		ArrayList ds_quanhuyen = new ArrayList();
		String id = " ";
		String ten = " ";
		String the_geom = " ";

		this.openConnection();
		String sql = "Select ma, ten,ST_Astext(the_geom) As the_geom From quanhuyen";
		rs = s.executeQuery(sql);

		while (rs.next()) {
			String[] arr = new String[3];
			if (rs.getString("ma") == null) {
				id = " ";
			} else {
				id = rs.getString("ma");
			}
			if (rs.getString("ten") == null) {
				ten = " ";
			} else {
				ten = rs.getString("ten");
			}
			if (rs.getString("the_geom") == null) {
				the_geom = " ";
			} else {
				the_geom = rs.getString("the_geom");
			}
			arr[0] = id;
			arr[1] = ten;
			arr[2] = the_geom;
			ds_quanhuyen.add(arr);
		}
		this.closeConnection();
		return ds_quanhuyen;
	}

	public ArrayList getXaPhuong(int mahuyen) throws SQLException,
			ClassNotFoundException {
		ArrayList ds_xaphuong = new ArrayList();
		String id = " ";
		String ten = " ";
		String the_geom = " ";
		this.openConnection();
		String sql = "Select ma, ten, ST_Astext(the_geom) As the_geom From xaphuong where ma_huyen ="
				+ mahuyen + "";
		rs = s.executeQuery(sql);

		while (rs.next()) {
			String[] arr = new String[3];
			if (rs.getString("ma") == null) {
				id = " ";
			} else {
				id = rs.getString("ma");
			}
			if (rs.getString("ten") == null) {
				ten = " ";
			} else {
				ten = rs.getString("ten");
			}
			if (rs.getString("the_geom") == null) {
				the_geom = " ";
			} else {
				the_geom = rs.getString("the_geom");
			}
			arr[0] = id;
			arr[1] = ten;
			arr[2] = the_geom;
			ds_xaphuong.add(arr);
		}
		this.closeConnection();
		return ds_xaphuong;
	}

	public ArrayList find_Place_By_Text_And_Huyen(String text, String str_id)
			throws SQLException, ClassNotFoundException {

		ArrayList ds_dia_diem = new ArrayList();
		String the_geom = " ";
		String ten = " ";
		String diachi = " ";
		String sdt = " ";
		int ma = 0;
		String[] temp;
		this.openConnection();
		temp = str_id.split("\\$");
		if (str_id == "") {
			rs = s.executeQuery("SELECT ten, diachi, sdt, ST_Astext(the_geom) As the_geom FROM find_place_by_text('"
					+ text + "')");
			while (rs.next()) {
				String[] arr = new String[4];
				if (rs.getString("the_geom") == null) {
					the_geom = " ";
				} else {
					the_geom = rs.getString("the_geom");
				}
				if (rs.getString("ten") == null) {
					ten = " ";
				} else {
					ten = rs.getString("ten");
				}
				if (rs.getString("diachi") == null) {
					diachi = " ";
				} else {
					diachi = rs.getString("diachi");
				}
				if (rs.getString("sdt") == null) {
					sdt = " ";
				} else {
					sdt = rs.getString("sdt");
				}
				arr[0] = the_geom;
				arr[1] = ten;
				arr[2] = diachi;
				arr[3] = sdt;
				ds_dia_diem.add(arr);
			}
		}
		for (int i = 0; i < temp.length; i++) {
			// System.out.println("temp["+i+"] :"+temp[i]);
			if (temp[i].equals("")) {
				ma = 0;
			} else {
				ma = Integer.parseInt(temp[i]);
			}

			rs = s.executeQuery("SELECT ten, diachi, sdt, ST_Astext(the_geom) As the_geom FROM find_place_by_text_and_huyen('"
					+ text + "'," + ma + ")");
			while (rs.next()) {
				String[] arr = new String[4];
				if (rs.getString("the_geom") == null) {
					the_geom = " ";
				} else {
					the_geom = rs.getString("the_geom");
				}
				if (rs.getString("ten") == null) {
					ten = " ";
				} else {
					ten = rs.getString("ten");
				}
				if (rs.getString("diachi") == null) {
					diachi = " ";
				} else {
					diachi = rs.getString("diachi");
				}
				if (rs.getString("sdt") == null) {
					sdt = " ";
				} else {
					sdt = rs.getString("sdt");
				}

				arr[0] = the_geom;
				arr[1] = ten;
				arr[2] = diachi;
				arr[3] = sdt;
				ds_dia_diem.add(arr);
			}
		}
		this.closeConnection();
		return ds_dia_diem;
	}

	public ArrayList find_Place_By_Text_And_Xa(String text, String str_id)
			throws SQLException, ClassNotFoundException {

		ArrayList ds_dia_diem = new ArrayList();
		String the_geom = " ";
		String ten = " ";
		String diachi = " ";
		String sdt = " ";
		int ma = 0;
		String[] temp;
		this.openConnection();
		temp = str_id.split("\\$");
		for (int i = 0; i < temp.length; i++) {
			// System.out.println("temp["+i+"] :"+temp[i]);
			if (temp[i].equals("")) {
				ma = 0;
			} else {
				ma = Integer.parseInt(temp[i]);
			}

			rs = s.executeQuery("SELECT ten, diachi, sdt, ST_Astext(the_geom) As the_geom FROM find_place_by_text_and_xa('"
					+ text + "'," + ma + ")");
			while (rs.next()) {
				String[] arr = new String[4];
				if (rs.getString("the_geom") == null) {
					the_geom = " ";
				} else {
					the_geom = rs.getString("the_geom");
				}
				if (rs.getString("ten") == null) {
					ten = " ";
				} else {
					ten = rs.getString("ten");
				}
				if (rs.getString("diachi") == null) {
					diachi = " ";
				} else {
					diachi = rs.getString("diachi");
				}
				if (rs.getString("sdt") == null) {
					sdt = " ";
				} else {
					sdt = rs.getString("sdt");
				}

				arr[0] = the_geom;
				arr[1] = ten;
				arr[2] = diachi;
				arr[3] = sdt;
				ds_dia_diem.add(arr);
			}
		}
		this.closeConnection();
		return ds_dia_diem;
	}

	public ArrayList find_place_by_text_and_lop(String str_id, String ten_lop,
			String cap) throws SQLException, ClassNotFoundException {

		ArrayList ds_dia_diem = new ArrayList();
		String the_geom = " ";
		String ten = " ";
		String diachi = " ";
		String sdt = " ";
		int ma = 0;
		String[] temp;
		this.openConnection();
		temp = str_id.split("\\$");
		for (int i = 0; i < temp.length; i++) {
			// System.out.println("temp["+i+"] :"+temp[i]);
			if (temp[i].equals("")) {
				ma = 0;
			} else {
				ma = Integer.parseInt(temp[i]);
			}
			rs = s.executeQuery("SELECT ten, diachi, sdt, ST_Astext(the_geom) As the_geom FROM find_place_by_text_and_lop("
					+ ma + ",'" + ten_lop + "','" + cap + "')");
			while (rs.next()) {
				String[] arr = new String[4];
				if (rs.getString("the_geom") == null) {
					the_geom = " ";
				} else {
					the_geom = rs.getString("the_geom");
				}
				if (rs.getString("ten") == null) {
					ten = " ";
				} else {
					ten = rs.getString("ten");
				}
				if (rs.getString("diachi") == null) {
					diachi = " ";
				} else {
					diachi = rs.getString("diachi");
				}
				if (rs.getString("sdt") == null) {
					sdt = " ";
				} else {
					sdt = rs.getString("sdt");
				}

				arr[0] = the_geom;
				arr[1] = ten;
				arr[2] = diachi;
				arr[3] = sdt;
				ds_dia_diem.add(arr);
			}
		}
		this.closeConnection();
		return ds_dia_diem;
	}

	public String find_address_xp_qh(String x, String y) throws SQLException, ClassNotFoundException{
		String address = "";
		this.openConnection();
		String sql = "Select find_address_xp_qh('"+x+"' ,'"+y+"') As result";
		rs = s.executeQuery(sql);
		while (rs.next()){
			address = rs.getString("result");
		}
		this.closeConnection();
		return address;
	}
	private void openConnection() throws SQLException, ClassNotFoundException {
		conn = null;
		if (conn == null) {
			Class.forName("org.postgresql.Driver");
			String url = "jdbc:postgresql://localhost:5432/postgis";
			conn = DriverManager.getConnection(url, "postgres", "admin");
			s = conn.createStatement();
		}
	}

	private void closeConnection() throws SQLException {
		if (!conn.isClosed()) {
			conn.close();
		}
	}

	public static void main(String[] args) throws ClassNotFoundException,
			SQLException, CloneNotSupportedException {
		CanThoMap obj = new CanThoMap();
		// System.out.println(obj.getDuongDi(586286.42664,
		// 1111763.41867,586281.79722,1111536.85668));
		// obj.find_Info_Of_Point("POINT(586026.386888053 1109704.73845328)");
		// obj.find_Place_Around_Point(583650.998019614, 1112232.66868234,
		// "can tho", 2000);
		// obj.getLop("ben");
		// obj.find_Place_By_Text("can tho");
		// String coquan_gml=obj.getDiaDiem("coquan","can tho");
	}
}