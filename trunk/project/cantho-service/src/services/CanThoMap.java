package services;

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

	public String getDuongDi(int param_source, int param_target) throws ClassNotFoundException {		
		try {								
			this.openConnection();			
			
			/**** Cho toa do 4 diem *****/
			/*
			//OK
			double x1 = 585953.10874;
			double y1 = 1109793.52265;
			double x2 = 585863.71313;
			double y2 = 1110149.82799;
			*/
			/*
			//OK
			double x1 = 584321.00040;
			double y1 = 1110220.06740;
			double x2 = 585268.59381;
			double y2 = 1110784.53679;
			*/
			/*
			 //OK
			double x1 = 586055.91368;
			double y1 = 1111536.73696;
			double x2 = 586199.90446;
			double y2 = 1111469.37099;
			*/
			/*
			 //Hai diem nam tren mot duong: hai diem tren mot duong
			double x1 = 585899.47137;
			double y1 = 1111277.80897;
			double x2 = 586099.65367;
			double y2 = 1111408.39041;
			*/
			/*
			//di qua vong xoay: OK
			double x1 = 586424.03201;
			double y1 = 1110974.18319;
			double x2 = 586406.15289;
			double y2 = 1110178.56230;
			*/
			//di qua vong xoay(chieu nguoc lai): OK
			/*
			double x1 = 586406.15289;
			double y1 = 1110178.56230;
			double x2 = 586424.03201;
			double y2 = 1110974.18319;
			*/
			/*
			//hai diem nam tren cung mot duong hai chieu, cung thu tu tu nguon den dich: OK		
			double x1 = 586153.61031;
			double y1 = 1110998.44770;
			double x2 = 586329.84736;
			double y2 = 1111085.28915;
			*/
			/*
			//hai diem nam tren cung mot duong hai chieu, khac tu tu nguon den dich: OK
			double x1 = 586329.84736;
			double y1 = 1111085.28915;
			double x2 = 586153.61031;
			double y2 = 1110998.44770;
			*/
			/*
			//hai diem nam tren cung mot duong mot chieu, cung thu tu tu nguon den dich: OK (Tran Phu)
			double x1 = 585887.01984;
			double y1 = 1111296.32663;
			double x2 = 585846.15328;
			double y2 = 1111259.61058;
			*/
			/*
			//hai diem nam tren cung mot duong mot chieu, khac thu tu tu nguon den dich: OK
			double x1 = 585846.15328;
			double y1 = 1111259.61058;
			double x2 = 585887.01984;
			double y2 = 1111296.32663;
			*/
			/*
			//hai diem nam tai mot dinh cua mot canh OK
			double x1 = 586286.42664;
			double y1 = 1111763.41867;
			double x2 = 586307.49846;
			double y2 = 1111764.69575;
			*/
			//hai diem nam tai hai dinh cua mot canh 
			double x1 = 586286.42664;
			double y1 = 1111763.41867;
			double x2 = 586281.79722;
			double y2 = 1111536.85668;
			/***** Danh sach canh va nut *****/
			List<Canh> edges = new ArrayList<Canh>();
			List<Nut> nodes = new ArrayList<Nut>();
			
			// lay ra danh sach cac dinh
			String sql_nut = "SELECT id, ST_AsText(the_geom) As the_geom FROM vertices_tmp Order By id";
			rs_nut = s.executeQuery(sql_nut);
			while (rs_nut.next()) {
				Nut node = new Nut(rs_nut.getString("id"), rs_nut.getString("id")+ "_" + rs_nut.getString("the_geom"));
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
			String sql3 = "SELECT gid As id, ma_duong, ten_duong, mot_chieu, source, target,length,"
					+ " ST_AsGML(the_geom) as the_geom "
					+ " FROM giaothong"
					+ " Order By id";
			rs_canh = s.executeQuery(sql3);
			/**Duyet qua tung mau tin de them canh vao danh sach canh**/
			while (rs_canh.next()) {
				String current_id = rs_canh.getString("id");
				int source = rs_canh.getInt("source") - 1;
				int target = rs_canh.getInt("target") - 1;
				String ten_duong = rs_canh.getString("ten_duong");
				if (ten_duong == null) {
					ten_duong = "Ä�Æ°á»�ng khÃ´ng tÃªn";
				}
				int mot_chieu = rs_canh.getInt("mot_chieu");
				String the_geom = rs_canh.getString("the_geom");
				Double chieu_dai = rs_canh.getDouble("length");			
						
				Canh edge = new Canh(current_id, nodes.get(source),nodes.get(target), chieu_dai, the_geom, ten_duong,mot_chieu);
				edges.add(edge);
				// neu duong hai chieu add them chieu nguoc lai
				if (mot_chieu == 0) {
					Canh edge_r = new Canh(current_id, nodes.get(target),nodes.get(source), chieu_dai, the_geom, ten_duong,	mot_chieu);
					edges.add(edge_r);
				}
			}
			/**Ket thuc Duyet qua tung mau tin de them canh vao danh sach canh**/
			
			/**** Lay du lieu giao cua Diem 1 ***********/
			String sql1 = "SELECT split_multi_from_any_point(" + x1 + "," + y1 + ") AS result";
			rs_1 = s.executeQuery(sql1);
			String[] temp1;
			String result1 = "";
			while (rs_1.next()) {
				result1 = rs_1.getString("result");
				break;
			}
			temp1 = result1.split("\\$");
			for (int i = 0; i < temp1.length; i++) {
				//System.out.println(temp1[i]);
			}
			/**** Ket thuc lay du lieu giao cua Diem 1 ***********/
			/**** Lay du lieu giao cua Diem 2 ***********/
			String sql2 = "SELECT split_multi_from_any_point(" + x2 + "," + y2 + ") AS result";
			rs_2 = s.executeQuery(sql2);
			String[] temp2;
			String result2 = "";
			while (rs_2.next()) {
				result2 = rs_2.getString("result");
				break;
			}
			temp2 = result2.split("\\$");
			for (int i = 0; i < temp2.length; i++) {
				//System.out.println(temp2[i]);
			}
			/**** Ket thuc lay du lieu giao cua Diem 1 ***********/
			/****/		
			int start_point = 0;//nut bat dau trong thuat toan Dijkstra
			int end_point = 0;//nut ket thuc trong thuat toan Dijkstra		
			/****/	
			
			/**Neu hai diem gan nhat cung nam tren mot canh
			 * function: split_multi_from_two_point( x1 float, y1 float, x2 float, y2 float)
			 * Ket qua: 0 - Neu hai diem khong cung tren mot canh, nguoc lai ket qua tach canh co dang nhu:
			 * 			<multilinestring_1>$<do_dai_1>$<id_nut_moi>$<multilinestring_2>$<do_dai_2>$<id_nut_moi>$<multilinestring_3>$<do_dai_3>			
			 * **/
			rs=s.executeQuery("SELECT split_multi_from_two_point("+ x1 +" , "+ y1 +" , "+x2+" , "+y2+" ) As result");
			
			/**Bat dau kiem tra tung diem giao de tach canh, neu diem giao khong trung voi cac dinh cua canh**/
			String result="";
			while (rs.next()){
				result=rs.getString("result");
			}
			//Kiem tra xem hai diem co cung nam tren mot canh giao hay khong?
			if (!result.equals("0")){
				/*****BAT DAU TRUONG HOP HAI DIEM NAM TREN CUNG MOT CANH******/
				System.out.println("Ket qua: Trung - result= "+result);		
				String[] temp;
				temp=result.split("\\$");
				for (int i=0;i<temp.length;i++){
					System.out.println("temp["+i+"]="+temp[i]);
				}
				String mult1=temp[0];
				double len1=Double.parseDouble(temp[1]);
				int id_nut_moi_1=Integer.parseInt(temp[2]);
				String mult2=temp[3];
				double len2=Double.parseDouble(temp[4]);
				int id_nut_moi_2=Integer.parseInt(temp[5]);
				String mult3=temp[6];
				double len3=Double.parseDouble(temp[7]);
				/**Them hai nut moi vao danh sach nut theo thu tu tang dan**/
				if (id_nut_moi_1 < id_nut_moi_2){
					start_point = id_nut_moi_1;
					end_point = id_nut_moi_2;
				}else{
					start_point = id_nut_moi_2;
					end_point = id_nut_moi_1;
				}
				Nut node = new Nut(start_point+"", start_point+ "_POINT(Nut Moi Start Point)" );
				nodes.add(node);
				node = new Nut(end_point+"", end_point+ "_POINT(Nut Moi End Point)" );
				nodes.add(node);
				//lay ra id canh giao
				rs=s.executeQuery("SELECT find_id_nearest_edge( "+x2+" , "+y2+" ) As edges_id");
				String id_canh_giao="";
				while(rs.next()){
					id_canh_giao=rs.getString("edges_id");
				}
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
				for ( i=0 ; i < edges.size() ; i++ ){
					//System.out.println("Kich thuoc hien tai: "+edges.size());
					if (edges.get(i).getId().equals(id_canh_giao)){
						if (j==0){
							chieu_hien_tai = edges.get(i).getDirect();
							id_nguon = Integer.parseInt(edges.get(i).getSource().getId());
							id_dich = Integer.parseInt(edges.get(i).getDestination().getId());
							ten = edges.get(i).getName();						
						}					
						edges.remove(i);
						i--;//vi danh sach edges se giam di 1 sau khi xoa
						//System.out.println("Kich thuoc sau khi xoa: "+edges.size());
						j++;//tang len de khong gan lai du lieu thuoc tinh cua chieu nguoc lai(sai nut nguon va dich) khi duong la 2 chieu
					}
				}
				//System.out.println("id_nguon: "+id_nguon+" -id_dich: "+id_dich+" -ten: "+ten+" -chieu: "+chieu_hien_tai);
				/**** Them ba canh moi *****/
				Canh canh_moi = new Canh(id_canh_giao, nodes.get(id_nguon - 1),nodes.get(id_nut_moi_1 - 1), len1, mult1, ten, chieu_hien_tai);
				edges.add(canh_moi);
				canh_moi = new Canh(id_canh_giao, nodes.get(id_nut_moi_1 - 1),nodes.get(id_nut_moi_2 - 1), len2, mult2, ten, chieu_hien_tai);
				edges.add(canh_moi);
				canh_moi = new Canh(id_canh_giao, nodes.get(id_nut_moi_2 - 1),nodes.get(id_dich - 1), len3, mult3, ten, chieu_hien_tai);
				edges.add(canh_moi);
				// neu hai chieu thi them lan nua
				if (chieu_hien_tai == 0) {
					canh_moi = new Canh(id_canh_giao, nodes.get(id_dich - 1),nodes.get(id_nut_moi_2 - 1), len3, mult3, ten,chieu_hien_tai);
					edges.add(canh_moi);
					canh_moi = new Canh(id_canh_giao, nodes.get(id_nut_moi_2 - 1),nodes.get(id_nut_moi_1 - 1), len2, mult2, ten, chieu_hien_tai);
					edges.add(canh_moi);
					canh_moi = new Canh(id_canh_giao, nodes.get(id_nut_moi_1 - 1),nodes.get(id_nguon - 1), len1, mult1, ten, chieu_hien_tai);
					edges.add(canh_moi);
				}			
				/*
				for (i=0 ; i<edges.size() ; i++){
					System.out.println("id:"+edges.get(i).getId()+" - nguon:"+edges.get(i).getSource().getId()+" -dich:"+edges.get(i).getDestination().getId()+" -trong luong:"+edges.get(i).getWeight()+" -the_geom:"+edges.get(i).getTheGeom());
				}
				*/
				/*****KET THUC TRUONG HOP HAI DIEM NAM TREN CUNG MOT CANH******/
			}else{
				//hai diem nam tren hai canh khac nhau
				//copy doan duoi bo vao cho nay
				//System.out.println("Ket qua: khong trung - result= "+result);
				/********BAT DAU TRUONG HOP HAI NAM TREN HAI CANH KHAC NHAU*******/
				
				int id_nut_moi = 0;
				rs_nut_moi = s.executeQuery("SELECT MAX(id) As id_nut_max FROM VERTICES_TMP");
				while (rs_nut_moi.next()) {
					id_nut_moi = rs_nut_moi.getInt("id_nut_max");
				}		
						
				/*** Xet diem thu 1 ***/
				/****** xet diem gan nhat co trung voi nut (dinh) nao cua canh gan nhat khong? */
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
					for (Canh canh : edges) {
						if (canh.getId().equals(id_canh_giao)) {
							// chi lay du lieu cua canh (chieu dung) dau tien 
							if (j == 0) {						
								chieu_hien_tai = canh.getDirect();
								id_nguon = Integer.parseInt(canh.getSource().getId());
								id_dich = Integer.parseInt(canh.getDestination().getId());
								ten = canh.getName();
							}
							edges.remove(i);
							j++;
						}
						i++;
					}
					*/
					for ( i=0 ; i < edges.size() ; i++ ){
						//System.out.println("Kich thuoc hien tai: "+edges.size());
						if (edges.get(i).getId().equals(id_canh_giao)){
							if (j==0){
								chieu_hien_tai = edges.get(i).getDirect();
								id_nguon = Integer.parseInt(edges.get(i).getSource().getId());
								id_dich = Integer.parseInt(edges.get(i).getDestination().getId());
								ten = edges.get(i).getName();						
							}					
							edges.remove(i);
							i--;//vi danh sach edges se giam di 1 sau khi xoa
							//System.out.println("Kich thuoc sau khi xoa: "+edges.size());
							j++;//tang len de khong gan lai du lieu thuoc tinh cua chieu nguoc lai(sai nut nguon va dich) khi duong la 2 chieu
						}
					}

					
					/** Them nut moi **/
					id_nut_moi++;
					Nut nut_moi = new Nut(id_nut_moi + "", id_nut_moi+"_POINT(Nut Moi Bat Dau)");
					nodes.add(nut_moi);
					// System.out.println("1-Sau khi them nut moi ban dau: id_nut_moi="+id_nut_moi+"-kich thuoc nodes= "+nodes.size());
					/**** Them hai canh moi *****/
					Canh canh_moi = new Canh(id_canh_giao, nodes.get(id_nguon - 1),nodes.get(id_nut_moi - 1), len1, mult1, ten, chieu_hien_tai);
					edges.add(canh_moi);
					canh_moi = new Canh(id_canh_giao, nodes.get(id_nut_moi - 1),nodes.get(id_dich - 1), len2, mult2, ten, chieu_hien_tai);
					edges.add(canh_moi);
					// neu hai chieu thi them lan nua
					if (chieu_hien_tai == 0) {
						canh_moi = new Canh(id_canh_giao, nodes.get(id_dich - 1),nodes.get(id_nut_moi - 1), len2, mult2, ten,chieu_hien_tai);
						edges.add(canh_moi);
						canh_moi = new Canh(id_canh_giao, nodes.get(id_nut_moi - 1),nodes.get(id_nguon - 1), len1, mult1, ten, chieu_hien_tai);
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
					for (Canh canh : edges) {
						if (canh.getId().equals(id_canh_giao)) {
							// chi lay du lieu cua canh (chieu dung) dau tien 
							if (j == 0) {
								chieu_hien_tai = canh.getDirect();
								id_nguon = Integer.parseInt(canh.getSource().getId());
								id_dich = Integer.parseInt(canh.getDestination().getId());
								ten = canh.getName();
								i--;
							}
							edges.remove(i);
							j++;
						}
						i++;
					}
					 */
					for ( i=0 ; i <edges.size() ; i++ ){
						//System.out.println("Kich thuoc hien tai: "+edges.size());
						if (edges.get(i).getId().equals(id_canh_giao)){
							if (j==0){
								chieu_hien_tai = edges.get(i).getDirect();
								id_nguon = Integer.parseInt(edges.get(i).getSource().getId());
								id_dich = Integer.parseInt(edges.get(i).getDestination().getId());
								ten = edges.get(i).getName();						
							}					
							edges.remove(i);
							i--;//vi danh sach edges se giam di 1 sau khi xoa
							//System.out.println("Kich thuoc sau khi xoa: "+edges.size());
							j++;//tang len de khong gan lai du lieu thuoc tinh cua chieu nguoc lai(sai nut nguon va dich) khi duong 2 chieu
						}
					}
					/** Them nut moi **/
					id_nut_moi++;
					Nut nut_moi = new Nut(id_nut_moi + "",id_nut_moi+ "_POINT(Nut moi ket thuc)");
					nodes.add(nut_moi);			
					/**** Them hai canh moi *****/			
					Canh canh_moi = new Canh(id_canh_giao, nodes.get(id_nguon - 1),nodes.get(id_nut_moi - 1), len1, mult1, ten, chieu_hien_tai);			
					edges.add(canh_moi);			
					canh_moi = new Canh(id_canh_giao, nodes.get(id_nut_moi - 1),nodes.get(id_dich - 1), len2, mult2, ten, chieu_hien_tai);			
					edges.add(canh_moi);
					// neu hai chieu thi them lan nua
					
					if (chieu_hien_tai == 0) {				
						canh_moi = new Canh(id_canh_giao, nodes.get(id_dich - 1),nodes.get(id_nut_moi - 1), len2, mult2, ten,chieu_hien_tai);				
						edges.add(canh_moi);
						canh_moi = new Canh(id_canh_giao, nodes.get(id_nut_moi - 1),nodes.get(id_nguon - 1), len1, mult1, ten,chieu_hien_tai);				
						edges.add(canh_moi);				
					}
					end_point = id_nut_moi;			
				}			
				/********BAT DAU TRUONG HOP HAI NAM TREN HAI CANH KHAC NHAU*******/			
			}
			
			
			/************ BAT DAU THUAT TOAN Dijkstra ********************/	    
		    //System.out.print(nodes.get(3));		
			DoThi g=new DoThi(nodes,edges);
			Dijkstra dijkstra=new Dijkstra(g);
			dijkstra.execute(nodes.get(start_point-1));
			LinkedList<Nut> path = dijkstra.getPath(nodes.get(end_point-1));
			System.out.println("Số đỉnh của đường đi: "+path.size());
			//ton tai duong di
			
							
			/******************Dinh Dang GML Cho Con Duong*******************************************/
			//phan dau cua chuoi GML
			String gml="<?xml version='1.0' encoding='utf-8'?>";
			 		gml+="\n<wfs:FeatureCollection xmlns:ms='http://mapserver.gis.umn.edu/mapserver' xmlns:wfs='http://www.opengis.net/wfs' xmlns:gml='http://www.opengis.net/gml' xmlns:ogc='http://www.opengis.net/ogc' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xsi:schemaLocation=' http://www.opengis.net/wfs http://schemas.opengis.net/wfs/1.0.0/WFS-basic.xsd                         http://mapserver.gis.umn.edu/mapserver http://aneto.oco/cgi-bin/worldwfs?SERVICE=WFS&amp;VERSION=1.0.0&amp;REQUEST=DescribeFeatureType&amp;TYPENAME=multipolygon&amp;OUTPUTFORMAT=XMLSCHEMA'>";
					 		gml+="\n<gml:boundedBy>";
						 		gml+="\n	<gml:null>unknown";
						 		gml+="\n	</gml:null>";
					 		gml+="\n</gml:boundedBy>";
				 	   
				 	   		
			if (path.size()>0){
				Nut source=new Nut(path.get(0).getId(),path.get(0).getName());//lay ra nut dau tien	
				//System.out.println(current.getName());
				//duyet qua cac nut con lai
				for (int i=1;i < path.size();i++){
				gml+="\n<gml:featureMember>";
					gml+="\n<ms:multilinestring fid='"+i+"'>";
						gml+="\n<ms:msGeometry>";
						
					//System.out.println(path.get(i).getName());
					Nut target=new Nut(path.get(i).getId(),path.get(i).getName());
					//System.out.println(g.getCanh(source, target).getTheGeom());
							gml+="\n"+g.getCanh(source, target).getTheGeom();//lay the_geom cua tung canh
							
						gml+="\n</ms:msGeometry>";
						//cac thuoc tinh khac o day
					gml+="\n</ms:multilinestring>";
				gml+="\n</gml:featureMember>";					
					source=target;
				}
			}		
			//phan cuoi cua chuoi GML			
			
			gml+="\n</wfs:FeatureCollection>";			
			
			/******************Ket Thuc Dinh Dang GML Cho Con Duong***************************************/		
			//System.out.println("GML: "+gml);
			
			for (Nut vertex : path) {
				System.out.println(vertex.getName());		
			}					
			Double chi_phi=dijkstra.getCost(nodes.get(param_target));
			this.closeConnection(); 
			return gml;
			//return "hoang";
			
		} catch (SQLException e) {
			System.out.print("Error - getDuongDi function: " + e.getMessage());
			return "Error: " + e.getMessage();
		}	
	}
	
	/***********************DANH SACH CAC DIA DIEM THEO LOP
	 * @throws ClassNotFoundException 
	 * @throws SQLException ****************************************************/
	
	public String getDiaDiem(String lop,String ten) throws SQLException, ClassNotFoundException{
		this.openConnection();
		String sql="SELECT ten,ST_AsGML(the_geom) As the_geom FROM "+lop+" WHERE ten LIKE '%"+ten+"%'";
		rs=s.executeQuery(sql);
		//phan dau cua chuoi GML
		String gml="<?xml version='1.0' encoding='utf-8'?>";
		 		gml+="\n<wfs:FeatureCollection xmlns:ms='http://mapserver.gis.umn.edu/mapserver' xmlns:wfs='http://www.opengis.net/wfs' xmlns:gml='http://www.opengis.net/gml' xmlns:ogc='http://www.opengis.net/ogc' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xsi:schemaLocation=' http://www.opengis.net/wfs http://schemas.opengis.net/wfs/1.0.0/WFS-basic.xsd                         http://mapserver.gis.umn.edu/mapserver http://aneto.oco/cgi-bin/worldwfs?SERVICE=WFS&amp;VERSION=1.0.0&amp;REQUEST=DescribeFeatureType&amp;TYPENAME=multipolygon&amp;OUTPUTFORMAT=XMLSCHEMA'>";
				 		gml+="\n<gml:boundedBy>";
					 		gml+="\n	<gml:null>unknown";
					 		gml+="\n	</gml:null>";
				 		gml+="\n</gml:boundedBy>";
		int i=1;
		while (rs.next()){
			gml+="\n<gml:featureMember>";
			gml+="\n<ms:Point fid='"+i+"'>";
				gml+="\n<ms:msGeometry>";
					gml+=rs.getString("the_geom");
			//System.out.println(rs.getString("the_geom"));
				gml+="\n</ms:msGeometry>";
					//cac thuoc tinh khac o day
				gml+="\n</ms:Point>";
			gml+="\n</gml:featureMember>";
			i++;//tang bien id
		}
		gml+="\n</wfs:FeatureCollection>";		
		this.closeConnection();
		return gml;
	}		
	
	private void openConnection() throws SQLException, ClassNotFoundException{
		conn=null;
		if (conn==null){
			Class.forName("org.postgresql.Driver"); 
		    String url = "jdbc:postgresql://localhost:5432/postgis"; 
		    conn = DriverManager.getConnection(url, "postgres", "admin");		   
			s=conn.createStatement();
		}
	}
	
	private void closeConnection() throws SQLException{
		if (!conn.isClosed()){
			conn.close();
		}
	}
	
	public static void main(String[] args) throws ClassNotFoundException,
			SQLException, CloneNotSupportedException {
		CanThoMap obj = new CanThoMap();
		System.out.println(obj.getDuongDi(1, 2));
		//String coquan_gml=obj.getDiaDiem("coquan","can tho");
		//System.out.println(coquan_gml);
	}
}

