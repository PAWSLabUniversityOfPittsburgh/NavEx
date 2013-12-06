MatLab Functions
================

1. ClickEventF - does click stream peaks with overlays of homeworks, filnals, etc (from files)
   ClickEventA - does click stream peaks with overlays of homeworks, filnals, etc (from Array)
	

ClickEventF('Clickstream peaks 2002 Fall','2002F_clickstream.txt','2002F_check.txt',1,10);
ClickEventF('Clickstream peaks 2003 Spring','2003S_clickstream.txt','2003S_check.txt',2,10);
ClickEventF('Clickstream peaks 2003 Fall','2003F_clickstream.txt','2003F_check.txt',3,10);
ClickEventF('Clickstream peaks 2004 Spring','2004S_clickstream.txt','2004S_check.txt',4,10);

2. left_till_hw_due - Computes binning for clicks 'around' homeworks finals etc.



ASSUMPTIONS AND ADJUSTMENTS
===========================

1. The following users should be filtered out:
	[1, 21, 52, 62, 72, 82, 92, 102, 112, 122, 132, 142, 152, 162, 502, 712, 1322, 1432, 1552]





