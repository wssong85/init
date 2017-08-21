package pantheon.iwrs.g01;

import java.util.Comparator;

public class BlockSizeInfo {
	private int no;
	private double randNum;
	private String block;
	private int index;
	
	public BlockSizeInfo(int no, double randNum, String block, int index){
		this.setNo(no);
		this.setRandNum(randNum);
		this.setBlock(block);
		this.setIndex(index);
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public double getRandNum() {
		return randNum;
	}

	public void setRandNum(double randNum) {
		this.randNum = randNum;
	}

	public String getBlock() {
		return block;
	}

	public void setBlock(String block) {
		this.block = block;
	}
	
	public int getIndex(){
		return index;
	}
	
	public void setIndex(int index){
		this.index = index;
	}

	public static Comparator<BlockSizeInfo> randNumComparator = new Comparator<BlockSizeInfo>(){
		public int compare(BlockSizeInfo obj1, BlockSizeInfo obj2){
			double rand1 = obj1.getRandNum();
			double rand2 = obj2.getRandNum();
			
			return (rand1 < rand2) ? -1 : (rand1 > rand2) ? 1 : 0;
		}
	};
	
	public static Comparator<BlockSizeInfo> noComparator = new Comparator<BlockSizeInfo>(){
		public int compare(BlockSizeInfo obj1, BlockSizeInfo obj2){
			int no1 = obj1.getNo();
			int no2 = obj2.getNo();
			
			return (no1 < no2) ? -1 : (no1 > no2) ? 1 : 0;
		}
	};
}
