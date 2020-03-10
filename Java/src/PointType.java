
/**
 * 座標
 * 
 * @author Lin
 *
 */
public class PointType {

	private  Double PositionLat ;
	private  Double PositionLon ;
	
	public Double getPositionLat() {
		return PositionLat;
	}
	public void setPositionLat(Double positionLat) {
		PositionLat = positionLat;
	}
	public Double getPositionLon() {
		return PositionLon;
	}
	public void setPositionLon(Double positionLon) {
		PositionLon = positionLon;
	}
	
	@Override
	public String toString() {
		return "PointType [PositionLat=" + PositionLat + ", PositionLon=" + PositionLon + "]";
	}
}
