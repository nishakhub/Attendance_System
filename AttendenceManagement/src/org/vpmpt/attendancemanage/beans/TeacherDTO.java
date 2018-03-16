package org.vpmpt.attendancemanage.beans;

import java.util.List;
import java.util.Map;

public class TeacherDTO extends UserDTO{
	
	protected Map<String, List<String>> classSubjectMap;

	public Map<String, List<String>> getClassSubjectMap() {
		return classSubjectMap;
	}

	public void setClassSubjectMap(Map<String, List<String>> classSubjectMap) {
		this.classSubjectMap = classSubjectMap;
	}
}
