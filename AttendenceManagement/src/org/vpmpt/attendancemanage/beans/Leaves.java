package org.vpmpt.attendancemanage.beans;

import java.util.Date;

public class Leaves {
	
	protected int id;
	protected int user_id;
	protected Date leaveFromDate;
	protected Date leaveTodate;
	protected int totalTaken;
	protected int approved;
	protected int approvalPending;
	protected String description;
	protected Date createdDate;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public Date getLeaveFromDate() {
		return leaveFromDate;
	}
	public void setLeaveFromDate(Date leaveFromDate) {
		this.leaveFromDate = leaveFromDate;
	}
	public Date getLeaveTodate() {
		return leaveTodate;
	}
	public void setLeaveTodate(Date leaveTodate) {
		this.leaveTodate = leaveTodate;
	}
	public int getTotalTaken() {
		return totalTaken;
	}
	public void setTotalTaken(int totalTaken) {
		this.totalTaken = totalTaken;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
}
