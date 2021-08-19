package com.mulcam.project.vo;

public class CookingShowDetailVO {
	
	private int idx;
	private int ridx;
	
	public CookingShowDetailVO() {};
	
	public CookingShowDetailVO(int idx, int ridx, String reasons) {
		super();
		this.idx = idx;
		this.ridx = ridx;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getRidx() {
		return ridx;
	}

	public void setRidx(int ridx) {
		this.ridx = ridx;
	}


}
