
/**
 * 台鐵車站基本資料
 * 
 * @author Lin
 *
 */
public class RailStation {

	private  String StationUID;
	private  String StationID;
	private  NameType StationName;
	private  PointType StationPosition;
	private  String StationAddress;
	private  String StationPhone;
	private  String OperatorID ;
	private  String StationClass;
	private  String ReservationCode;
    private  String UpdateTime;
    private  int VersionID ;

	public String getStationUID() {
		return StationUID;
	}

	public void setStationUID(String stationUID) {
		StationUID = stationUID;
	}

	public String getStationID() {
		return StationID;
	}

	public void setStationID(String stationID) {
		StationID = stationID;
	}

	public NameType getStationName() {
		return StationName;
	}

	public void setStationName(NameType stationName) {
		StationName = stationName;
	}

	public PointType getStationPosition() {
		return StationPosition;
	}

	public void setStationPosition(PointType stationPosition) {
		StationPosition = stationPosition;
	}

	public String getStationAddress() {
		return StationAddress;
	}

	public void setStationAddress(String stationAddress) {
		StationAddress = stationAddress;
	}

	public String getStationPhone() {
		return StationPhone;
	}

	public void setStationPhone(String stationPhone) {
		StationPhone = stationPhone;
	}

	public String getOperatorID() {
		return OperatorID;
	}

	public void setOperatorID(String operatorID) {
		OperatorID = operatorID;
	}

	public String getStationClass() {
		return StationClass;
	}

	public void setStationClass(String stationClass) {
		StationClass = stationClass;
	}

	public String getReservationCode() {
		return ReservationCode;
	}

	public void setReservationCode(String reservationCode) {
		ReservationCode = reservationCode;
	}

	public String getUpdateTime() {
		return UpdateTime;
	}

	public void setUpdateTime(String updateTime) {
		UpdateTime = updateTime;
	}

	public int getVersionID() {
		return VersionID;
	}

	public void setVersionID(int versionID) {
		VersionID = versionID;
	}

	@Override
	public String toString() {
		return "RailStation [StationUID=" + StationUID + ", StationID=" + StationID + ", StationName=" + StationName
				+ ", StationPosition=" + StationPosition + ", StationAddress=" + StationAddress + ", StationPhone="
				+ StationPhone + ", OperatorID=" + OperatorID + ", StationClass=" + StationClass + ", ReservationCode="
				+ ReservationCode + ", UpdateTime=" + UpdateTime + ", VersionID=" + VersionID + "]";
	}
}
