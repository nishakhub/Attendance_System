package org.vpmpt.attendancemanage.beans;

public class StudentDTO extends UserDTO {

	protected String className;
	protected String academicYear;
	protected int classId;
	protected long studentId;
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getAcademicYear() {
		return academicYear;
	}
	public void setAcademicYear(String academicYear) {
		this.academicYear = academicYear;
	}
	public int getClassId() {
		return classId;
	}
	public void setClassId(int classId) {
		this.classId = classId;
	}
	public long getStudentId() {
		return studentId;
	}
	public void setStudent_id(long studentId) {
		this.studentId = studentId;
	}
	
}
