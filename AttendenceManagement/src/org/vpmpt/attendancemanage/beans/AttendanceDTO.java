package org.vpmpt.attendancemanage.beans;

import java.util.Date;

public class AttendanceDTO {
	
	private long attendanceId;
	private Date presentDate;
	private long userId;
	private String fromTime;
	private String toTime;
	private Date createdDate;
	
	public String getFromTime() {
		return fromTime;
	}
	public void setFromTime(String fromTime) {
		this.fromTime = fromTime;
	}
	public String getToTime() {
		return toTime;
	}
	public void setToTime(String toTime) {
		this.toTime = toTime;
	}
	public long getAttendanceId() {
		return attendanceId;
	}
	public void setAttendanceId(long attendanceId) {
		this.attendanceId = attendanceId;
	}
	public Date getPresentDate() {
		return presentDate;
	}
	public void setPresentDate(Date presentDate) {
		this.presentDate = presentDate;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
}
