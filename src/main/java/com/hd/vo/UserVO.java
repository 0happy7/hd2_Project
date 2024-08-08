package com.hd.vo;

public class UserVO
{
	private String userno;   //회원번호
	private String userid;   //아이디
	private String userpw;   //비밀번호
	private String uname;    //이름
	private String gender;   //성별
	private String email;    //이메일
	private String uwdate;   //가입일자
	private String isretire; //탈퇴여부
	private String ugrade; 	 //권한
	private String reason; 	 //탈퇴사유
	private String adminmemo;//관리자메모
	private String withdrawaldate; //탈퇴일
	
	public String getUserno() 	{	return userno;		}
	public String getUserid() 	{	return userid;		}
	public String getUserpw() 	{	return userpw;		}
	public String getUname() 	{	return uname;		}
	public String getGender() 	{	return gender;		}
	public String getEmail() 	{	return email;		}	
	public String getUwdate() 	{	return uwdate;		}
	public String getIsretire() {	return isretire;	}
	public String getUgrade() 	{	return ugrade;		}
	public String getReason()   {	return reason;		}
	public String getAdminmemo(){	return adminmemo;	}
	public String getWithdrawaldate() {	return withdrawaldate;}
	
	
	public void setUserno(String userno) 		{	this.userno = userno;		}
	public void setUserid(String userid) 		{	this.userid = userid;		}
	public void setUserpw(String userpw) 		{	this.userpw = userpw;		}
	public void setUname(String uname) 			{	this.uname = uname;			}
	public void setGender(String gender) 		{	this.gender = gender;		}
	public void setEmail(String email) 			{	this.email = email;			}
	public void setUwdate(String uwdate) 		{	this.uwdate = uwdate;		}
	public void setIsretire(String isretire) 	{	this.isretire = isretire;	}
	public void setUgrade(String ugrade) 		{	this.ugrade = ugrade;		}
	public void setReason(String reason) 		{	this.reason = reason;		}
	public void setAdminmemo(String adminmemo)  {	this.adminmemo = adminmemo; }
	public void setWithdrawaldate(String withdrawaldate) {	this.withdrawaldate = withdrawaldate;}
	
	public void printinfo() {
		System.out.println("회원번호 : " + userno);
		System.out.println("아이디 : " + userid);
		System.out.println("비밀번호 : " + userpw);
		System.out.println("이름 : " + uname);
		System.out.println("성별 : " + gender);
		System.out.println("이메일 : " + email);
		System.out.println("가입일자 : " + uwdate);
		System.out.println("탈퇴여부 : " + isretire);
		System.out.println("권한 : " + ugrade);
		System.out.println("----------------------------------");
	}
	
}
