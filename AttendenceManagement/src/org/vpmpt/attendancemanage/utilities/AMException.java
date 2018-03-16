package org.vpmpt.attendancemanage.utilities;

public class AMException extends Exception {

	private static final long serialVersionUID = -6265347718751717652L;
	private int status=0;

	public AMException(){
		
	}

	public AMException(int status){
		this.status = status;
	}

	@Override
	public String getMessage() {
		return super.getMessage();
	}
	
	public void setMessage(String message) {
		
	}


	public int getStatus(){
		return status;
	}
	
	public void setStatus(int status){
		this.status = status;
	}
}
