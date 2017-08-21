package pantheon.iwrs.g01;

import java.util.Comparator;

public class BlockInfo {
	private int no;
	private double randNum;
	private int blockNo;
	private String block;
	
	public BlockInfo(int no, double randNum, int blockNo, String block){
		this.setNo(no);
		this.setRandNum(randNum);
		this.setBlockNo(blockNo);
		this.setBlock(block);
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

	public int getBlockNo() {
		return blockNo;
	}

	public void setBlockNo(int blockNo) {
		this.blockNo = blockNo;
	}

	public static Comparator<BlockInfo> randNumComparator = new Comparator<BlockInfo>(){
		public int compare(BlockInfo obj1, BlockInfo obj2){
			double rand1 = obj1.getRandNum();
			double rand2 = obj2.getRandNum();
			
			return (rand1 < rand2) ? -1 : (rand1 > rand2) ? 1 : 0;
		}
	};
	
	public static Comparator<BlockInfo> noComparator = new Comparator<BlockInfo>(){
		public int compare(BlockInfo obj1, BlockInfo obj2){
			int no1 = obj1.getNo();
			int no2 = obj2.getNo();
			
			return (no1 < no2) ? -1 : (no1 > no2) ? 1 : 0;
		}
	};
}
