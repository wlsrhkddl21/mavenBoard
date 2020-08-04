package ino.web.freeBoard.common.util;

public class PagingUtil {
	
	// 페이지당 게시물 수
    public static final int PAGE_SCALE = 10;
    // 화면당 페이지 수
    public static final int BLOCK_SCALE = 10;
    
    private int curPage;
    private int totalPage;
    private int pageBegin;
    private int pageEnd;
    private int blockBegin;
    private int blockEnd;
    private int curBlock;
    private int totalBlock;
    
    public PagingUtil(int curPage, int count){
    	this.curPage = curPage;
    	curBlock=1;
    	setTotalBlock(count);
    	setTotalPage(count);
    	pagingRange();
    	blockRange();
    }
	
	private void blockRange() {
		// *현재 페이지가 몇번째 페이지 블록에 속하는지 계산
        curBlock = (int)Math.ceil((curPage-1) / BLOCK_SCALE)+1;
        // *현재 페이지 블록의 시작, 끝 번호 계산
        blockBegin = (curBlock-1)*BLOCK_SCALE+1;
        // 페이지 블록의 끝번호
        blockEnd = blockBegin+BLOCK_SCALE-1;
        if(blockEnd>=totalBlock){
        	blockEnd = totalBlock;
        }
	}

	private void pagingRange() {
		pageBegin = (curPage-1)*PAGE_SCALE+1;
		pageEnd = pageBegin +PAGE_SCALE -1;
	}
	
	public int getTotalBlock() {
		return totalBlock;
	}

	public void setTotalBlock(int count) {
		totalBlock = (int)Math.ceil(count*1.0 / BLOCK_SCALE);
	}

	public int getCurBlock() {
		return curBlock;
	}

	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}

	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int count) {
		totalPage =  (int) Math.ceil(count*1.0 / PAGE_SCALE);
	}
	public int getPageBegin() {
		return pageBegin;
	}
	public void setPageBegin(int pageBegin) {
		this.pageBegin = pageBegin;
	}
	public int getPageEnd() {
		return pageEnd;
	}
	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}
	public int getBlockBegin() {
		return blockBegin;
	}
	public void setBlockBegin(int blockBegin) {
		this.blockBegin = blockBegin;
	}
	public int getBlockEnd() {
		return blockEnd;
	}
	public void setBlockEnd(int blockEnd) {
		this.blockEnd = blockEnd;
	}

	@Override
	public String toString() {
		return "PagingUtil [curPage=" + curPage + ", totalPage=" + totalPage + ", pageBegin=" + pageBegin + ", pageEnd="
				+ pageEnd + ", blockBegin=" + blockBegin + ", blockEnd=" + blockEnd + ", curBlock=" + curBlock
				+ ", totalBlock=" + totalBlock + "]";
	}
	
    
    
}