package org.vpmpt.attendancemanage.beans;

import java.util.Date;

public class ClassDTO {

	protected String classId;
	protected String className;
	protected long classTeacher;
	protected Date updatedDate;
	public String getClassId() {
		return classId;
	}
	public void setClassId(String classId) {
		this.classId = classId;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public long getClassTeacher() {
		return classTeacher;
	}
	public void setClassTeacher(long classTeacher) {
		this.classTeacher = classTeacher;
	}
	public Date getUpdatedDate() {
		return updatedDate;
	}
	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}
	
}
