package org.vpmpt.attendancemanage.beans;

public class ReportDTO {
	
	protected long userId;
	protected String studentName;
	protected String month;
	protected String className;
	protected int totalDays;
	protected int presentDays;
	protected float percentage;
	protected int leaves;
	protected String subject;
	
	
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public int getTotalDays() {
		return totalDays;
	}
	public void setTotalDays(int totalDays) {
		this.totalDays = totalDays;
	}
	public int getPresentDays() {
		return presentDays;
	}
	public void setPresentDays(int presentDays) {
		this.presentDays = presentDays;
	}
	public float getPercentage() {
		return percentage;
	}
	public void setPercentage(float percentage) {
		this.percentage = percentage;
	}
	public int getLeaves() {
		return leaves;
	}
	public void setLeaves(int leaves) {
		this.leaves = leaves;
	}
	
}
