package in.co.jtechy.common.util;

import in.co.jtechy.common.model.AbstractEntity;

import java.util.Comparator;

public class RankComparator implements Comparator<AbstractEntity> {

	public int compare(AbstractEntity o1, AbstractEntity o2) {
		try {
			if (o1.getRank() < o2.getRank()) {
				return -1;
			} else if (o1.getRank() > o2.getRank()) {
				return 1;
			} else {
				return 0;
			}
		} catch (Exception e) {
			return 0;
		}
	}

}
