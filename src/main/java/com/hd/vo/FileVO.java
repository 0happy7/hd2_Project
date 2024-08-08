package com.hd.vo;

public class FileVO {
	private int fid; 			//파일 ID
	private int entityid; 			//엔티티 ID (itemno 또는 bno)
	private String bfname;		//원본 파일 이름
	private String bpname;		//저장된 파일 이름
	private String bno;
	private int fitemno;
    
    
	public int getFid() 				{	return fid;				}
	public int getEntityid() 			{	return entityid;		}
	public String getBfname() 			{	return bfname;			}
	public String getBpname() 			{	return bpname;			}
	public String getBno() 				{	return bno;				}
	public int getFitemno() 			{	return fitemno;			}
	
	public void setFid(int fid) 						{	this.fid = fid;					}
	public void setEntityid(int entityid) 				{	this.entityid = entityid;		}
	public void setBfname(String bfname) 				{	this.bfname = bfname;			}
	public void setBpname(String bpname) 				{	this.bpname = bpname;			}
	public void setBno(String bno) 						{	this.bno = bno;					}
	public void setFitemno(int fitemno) 				{	this.fitemno = fitemno;			}
	
	public void printinfo() {
    	System.out.println(fid);
    	System.out.println(entityid);
    	System.out.println(bfname);
    	System.out.println(bpname);
    	System.out.println(bno);
    	System.out.println(fitemno);
    	System.out.println("----------------------");
    }
}
