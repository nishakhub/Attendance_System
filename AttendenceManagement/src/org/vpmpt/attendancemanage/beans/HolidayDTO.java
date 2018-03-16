package org.vpmpt.attendancemanage.beans;

import java.util.Date;

public class HolidayDTO {
	private int id;
	private Date holidayDate;
	private String discription;
	private Date createdDate;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getHolidayDate() {
		return holidayDate;
	}
	public void setHolidayDate(Date holidayDate) {
		this.holidayDate = holidayDate;
	}
	public String getDiscription() {
		return discription;
	}
	public void setDiscription(String discription) {
		this.discription = discription;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	@Override
	public String toString() {
		StringBuilder toString = new StringBuilder("id="+id+";date="+holidayDate+";discription="+discription);
		return toString.toString();
	}
	
	
}
