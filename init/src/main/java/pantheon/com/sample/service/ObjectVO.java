package pantheon.com.sample.service;

import java.util.ArrayList;

public class ObjectVO {
    private boolean success;
    private ArrayList<ListVO> result;
    private int total_count;
    private String message;
    /**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}
	/**
	 * @param message the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}
	public boolean isSuccess() {
        return success;
    }
    public void setSuccess(boolean success) {
        this.success = success;
    }
    public ArrayList<ListVO> getResult() {
        return result;
    }
    public void setResult(ArrayList<ListVO> result) {
        this.result = result;
    }
    public int getTotal_count() {
        return total_count;
    }
    public void setTotal_count(int total_count) {
        this.total_count = total_count;
    }
}
